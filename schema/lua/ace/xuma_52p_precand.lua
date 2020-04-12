-- xuma_52p_precand.lua
-- 在 preedit 中显示编码的两个分段所对应的两个候选
-- 滤镜只对 [ abc, long ] 标签生效，所以可假定输入码仅含小写字母

local basic = require('ace/lib/basic')
local map = basic.map
local index = basic.index
local utf8chars = basic.utf8chars

local function lookup(db)
  return function (str)
    return db:lookup(str)
  end
end

local function filter(input, env)
  local context = env.engine.context
  if context:get_option("xuma_52p_precand") and
      (context.input:find('%l$') or
       context.input:find('^;')) then
    local sel_inp = context.caret_pos == 0 and context.input or
        context.input:sub(1, context.caret_pos)
    if sel_inp:find('%l$') then  -- 一定要加这个判断，否则会影响符号键的功能
      sel_inp = sel_inp:match('%l+$')  -- 去掉前置标点部分
    end
    local detailed = context:get_option("detailed_x52_precand")
    local codes, cand1, cand2, seg1, seg2
    if context.input:find('^;') then -- 本方案中分号引导用于实现其他多个功能
      -- Do nothing
    elseif sel_inp:len() < 3 then
      if detailed then
        codes = { sel_inp .. '_1', sel_inp .. '_2', sel_inp .. '_3' }
        cand2 = map(codes, lookup(env.code2cand_rvdb))
      end
    else
      seg1 = sel_inp:sub(1, 2)
      seg2 = sel_inp:sub(3)
      cand1 = env.code2cand_rvdb:lookup(seg1 .. '_1')
      codes = { seg2 .. '_1', seg2 .. '_2', seg2 .. '_3' }
      cand2 = map(codes, lookup(env.code2cand_rvdb))
    end
    -- 这是以候选迭代为基础的，因此要求无空码。
    for cand in input:iter() do
      local rep = ''
      if context.input:find('^;') then
        rep = cand.text
      elseif sel_inp:len() < 3 then
        if detailed then
          if cand2[1] == cand.text then
            rep = table.concat(cand2, '|')
          else
            rep = ('%s>%s'):format(table.concat(cand2, '|'), cand.text)
          end
        else
          rep = cand.text
        end
      else
        if detailed then
          -- rep = ('%s%s|%s'):format(cand1, cand2[1], cand.text)
          rep = ('%s+%s=%s'):format(cand1, table.concat(cand2, '|'), cand.text)
          -- rep = ('%s%s%s%s'):format(
          -- cand1, sel_inp:sub(1,2), cand2[1], sel_inp:sub(3))
        else
          rep = ('%s%s'):format(cand1, cand2[1])
        end
      end
      if cand.preedit:find('\t') then
        cand.preedit = cand.preedit:gsub('.+\t', rep .. '\t')
      else
        cand.preedit = rep .. '\t'
      end
      -- simplifier 的候选无法这样修改 preedit，只能用 Candidate() 生成再修改。
      yield(cand)
    end
  else
    for cand in input:iter() do yield(cand) end
  end
end

local function init(env)
  local config = env.engine.schema.config
  local code2cand_rvdb = config:get_string('lua_reverse_db/code_to_cand')
  env.code2cand_rvdb = ReverseDb('build/' .. code2cand_rvdb .. '.reverse.bin')
end

return { init = init, func = filter }
