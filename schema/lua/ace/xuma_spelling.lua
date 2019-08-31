-- xuma_phrase_spelling.lua
-- 为词组的三重注解进行简化处理，仅显示词组编码和对应字根。
-- 实现障碍：simplifier 返回的类型，无法修改其注释。
--    https://github.com/hchunhui/librime-lua/issues/16
-- 一个思路：show_in_commet: false
--    然后读取 cand.text 修改后作为注释显示，问题是无法直接将 cand.text 改回。
--    理论上只能用 Candidate() 生成简单类型候选。

-- 编码存在多个的情况，先捕获全部再确定全码，最后提取词组编码。
-- 考虑到词组中单字的字根和编码可能缺失，仅对无缺失词组作注解。
-- Handle multibye string in Lua:
--   https://stackoverflow.com/questions/9003747/splitting-a-multibyte-string-in-lua

local function xform(input)
  if input == "" then return "" end
  input = input:gsub('%[', '〔 ')
  input = input:gsub('%]', ' 〕')
  input = input:gsub('_', ' ')
  input = input:gsub(',', ' · ')
  return input
end

-- Unused function.
local function utf8sub(str, first, ...)
  local last = ...
  if last == nil or last > utf8.len(str) then
    last = utf8.len(str)
  elseif last < 0 then
    last = utf8.len(str) + 1 + last
  end
  local fstoff = utf8.offset(str, first)
  local lstoff = utf8.offset(str, last + 1)
  if fstoff == nil then fstoff = 1 end
  if lstoff ~= nil then lstoff = lstoff - 1 end
  return string.sub(str, fstoff, lstoff)
end

local function utf8chars(str, ...)
  local chars = {}
  for pos, code in utf8.codes(str) do
    chars[#chars + 1] = utf8.char(code)
  end
  return chars
end

function radicals(str, ...)
  -- Handle spellings like "{于下}{四点}丶"(求) where some radicals are
  -- represented by multiple characters.
  local first, last = ...
  if first == nil then return str end
  local radicals = {}
  local radical = ''
  local is_single = true
  for _, code in utf8.codes(str) do
    local char = utf8.char(code)
    if is_single then
      if char ~= '{' then
        table.insert(radicals, char)
      else
        is_single = false
        radical = '{'
      end
    else
      radical = radical .. char
      if char == '}' then
        table.insert(radicals, radical)
        is_single = true
      end
    end
  end
  return table.concat{ table.unpack(radicals, first, last) }
end

local function map(table, func)
  local t = {}
  for k, v in pairs(table) do
    t[k] = func(v)
  end
  return t
end

local function lookup(db)
  return function (str)
    return db:lookup(str)
  end
end

local function index(table, item)
  for k, v in pairs(table) do
    if v == item then return k end
  end
end

local function parse_spll(str)
  local s = string.gsub(str, ',.*', '')
  return string.gsub(s, '^%[', '')
end

local function wrap_comment(s, c, cand, env)
  -- 'completion' 类型的候选来自固态词典还是用户词典，通过查询词组编码来确定。
  if cand.type == 'user_table' or cand.type == 'completion' and
      env.code_rvdb:lookup(cand.text) == '' then
    return '〈 ' .. s .. ' 〉' .. cand.comment
  elseif cand.type == 'table' or cand.type == 'completion' then
    return '〔 ' .. s .. ' · ' .. c .. ' 〕' .. cand.comment
  else
    return cand.comment
  end
end

local function spell_phrase(s, spll_rvdb)
  local chars = utf8chars(s)
  local rvlk_results
  if #chars == 2 or #chars == 3 then
    rvlk_results = map(chars, lookup(spll_rvdb))
  else
    rvlk_results = map({chars[1], chars[2], chars[3], chars[#chars]},
        lookup(spll_rvdb))
  end
  if index(rvlk_results, '') then return '' end
  local spellings = map(rvlk_results, parse_spll)
  local sup = '◇'
  if #spellings == 2 then
    return radicals(spellings[1] .. sup, 1, 2) ..
           radicals(spellings[2] .. sup, 1, 2)
  elseif #spellings == 3 then
    return radicals(spellings[1], 1, 1) ..
           radicals(spellings[2], 1, 1) ..
           radicals(spellings[3] .. sup, 1, 2)
  else
    return radicals(spellings[1], 1, 1) ..
           radicals(spellings[2], 1, 1) ..
           radicals(spellings[3], 1, 1) ..
           radicals(spellings[4], 1, 1)
  end
end

local function set_comment(input, env)
  for cand in input:iter() do
    if cand.type == 'sentence' then  -- Do not modify the comment of this type.
    elseif utf8.len(cand.text) == 1 then
      local rvlk_result = env.spll_rvdb:lookup(cand.text)
      if rvlk_result ~= '' then
        cand:get_genuine().comment = xform(rvlk_result) .. cand.comment
            -- .. ' (' ..  lookup(code_rvdb)(cand.text) .. ')'
      end
    else
      local spelling = spell_phrase(cand.text, env.spll_rvdb)
      local code = env.code_rvdb:lookup(cand.text)
      cand:get_genuine().comment = wrap_comment(spelling, code, cand, env)
    end
    yield(cand)
  end
end

local function filter(input, env)
  if env.engine.context:get_option("xuma_spelling") then
    set_comment(input, env)
  else
    for cand in input:iter() do
      yield(cand)
    end
  end
end

local function init(env)
  env.spll_rvdb = ReverseDb("lua/ace/data/xuma_spelling.reverse.bin")
  env.code_rvdb = ReverseDb("build/xuma.reverse.bin")
end

return { init = init, func = filter }
