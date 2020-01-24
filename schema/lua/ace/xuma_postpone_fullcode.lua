-- xuma_postpone_fullcode.lua
-- 出现重码时，将全码匹配且有简码的「单字」「适当」后置。
-- 目前的实现方式，原理适用于所有使用规则简码的形码方案。

local function init(env)
  env.code_rvdb = ReverseDb("build/xuma.reverse.bin")
  local cofig = env.engine.context.schema.config
end

local function get_short(codestr)
  local s = ' ' .. codestr
  for code in s:gmatch('%l+') do
    if s:find(' ' .. code .. '%l+') then
      return code
    end
  end
end

local function is_short_or_only_code(cand, env)
  -- completion 和 sentence 类型不属于精确匹配，但不能仅用 cand.type 判断，因为
  -- 可能被 simplifier 覆盖为 simplified 类型。先行判断 cand.type 并非必要，只是
  -- 为了轻微的性能优势。
  if cand.type == 'completion' or cand.type == 'sentence' then
    return
  end
  local input = env.engine.context.input
  local cand_input = input:sub(cand.start + 1, cand._end)
  -- 去掉可能含有的 delimiter。
  cand_input = cand_input:gsub('[ `\']', '')
  local codestr = env.code_rvdb:lookup(cand:get_genuine().text)
  local is_comp = not
      string.find(' ' .. codestr .. ' ', ' ' .. cand_input .. ' ', 1, true)
  if not is_comp then
    local short = get_short(codestr)
    local not_drop = (not short or cand_input == short)
    return not_drop, is_comp
  end
end

local function filter(input, env)
  local context = env.engine.context
  if not context:get_option("xuma_postpone_fullcode") then
    for cand in input:iter() do yield(cand) end
  else
    -- 具体实现不是后置目标候选，而是前置非目标候选
    local dropped_cands = {}
    local done_drop
    local pos, max_pos = 1, 4  -- 适当后置，太靠后没有意义。
    -- Todo: 计算 pos 时考虑可能存在的重复候选被 uniquifier 合并的情况。
    for cand in input:iter() do
      if done_drop then
        yield(cand)
      else
        -- 顶功方案使用 script_translator，没有 completion ，但会匹配部分输入，
        -- 如输入 otu 且光标在 u 后时会出现编码为 ot 的候选，需单独排除。
        local is_bad_script_cand = cand._end < context.caret_pos
        local not_drop, is_comp = is_short_or_only_code(cand, env)
        if pos >= max_pos or is_bad_script_cand or is_comp then
          for i, cand in ipairs(dropped_cands) do yield(cand) end
          done_drop = true
          yield(cand)
        -- 精确匹配的词组不予后置
        elseif not_drop or utf8.len(cand.text) > 1 then
          yield(cand)
          pos = pos + 1
        else table.insert(dropped_cands, cand)
        end
      end
    end
    for i, cand in ipairs(dropped_cands) do yield(cand) end
  end
end

return { init = init, func = filter }

--[[ 测试例字：
一	原	gu
大	把	fd
和	舌	rov
中	喝	oku
我	箋	pffg
出	艸 糾 ⾋	aau
在	黄土	hkjv
地	軐	jbe
是	鶗	kglu
上	肯	ls
道	单身汉	xtzd
以	(多个词组)	cwuu
儿	(多个词组)	ve
了	(多个词组)	bl
同	同路	mgov
只	叭	otu
--]]
