-- rime.lua

local rime = {}
package.loaded[...] = rime


-- 用这样的表描述构词规则，之后解析为另一张表，面向后端函数。彼表格的元素以词组
-- 长度为键，以表格 { char_idx = i, code_idx = j } 的列表为值，其中第 n 个表格
-- 指示词组编码的第 n 码为词组第 char_idx 字的第 code_idx 码。formula 中 'U' 和
-- 'u' 之后的字母表示从末尾倒数，解析为负数索引。
-- sample encoder configuration
-- { { length_equal = 2, formula = 'AaAbBaBb' }
-- , { length_equal = 3, formula = 'AaBaCaCb' }
-- , { length_in_range = {4, 10}, formula = 'AaBaCaZa' }
-- }
rime.encoder = {}


function rime.encoder.parse_formula(formula)
  if type(formula) ~= 'string' or formula:gsub('%u%l', '') ~= '' then return end
  local rule = {}
  local A, a, U, u, Z, z = ('AaUuZz'):byte(1, -1)
  for m in formula:gmatch('%u%l') do
    local upper, lower = m:byte(1, 2)
    local char_idx = upper < U and upper - A + 1 or upper - Z - 1
    local code_idx = lower < u and lower - a + 1 or lower - z - 1
    rule[#rule+1] = { char_idx = char_idx, code_idx = code_idx }
  end
  return rule
end


function rime.encoder.load_settings(setting)
  local ft, rt = {}, {}
  local f2r = {}  -- 注意到公式同则规则同，可在 rt 中作引用定义，以节省资源。
  for _, t in ipairs(setting) do
    if t.length_equal then ft[t.length_equal] = t.formula
    elseif t.length_in_range then
      local min, max = table.unpack(t.length_in_range)
      for l = min, max do
        ft[l] = t.formula
      end
    end
  end
  -- setting 中的 length 不一定连续且一般不包括 1，所以不能用 ipairs()。
  for k, f in pairs(ft) do
    local rule = rime.encoder.parse_formula(f)
    if not rule then return end
    if not f2r[f] then f2r[f] = rule end
    rt[k] = f2r[f]
  end
  return rt
end


function rime.switch_option(name, context)
  context:set_option(name, not context:get_option(name))
end
