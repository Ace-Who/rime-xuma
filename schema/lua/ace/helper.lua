-- helper.lua

-- List features and usage of the schema.
local function translator(input, seg)
  if input:find('^help/$') then
    local table = {
          { '簡入繁出', 'Ctrl + Shift + F' }
        , { '三重注解', 'Ctrl + C' }
        , { '屏蔽词组', 'Ctrl + S' }
        , { '显示时钟', 'Ctrl + T' }
        , { '双重反查', '`' }
        , { '全拼反查', '`P' }
        , { '笔画反查', '`B' }
        , { '环境变量', 'env/' }
        , { '显示帮助', 'help/' }
    }
    for k, v in ipairs(table) do
      yield(Candidate('help', seg.start, seg._end, v[2], ' ' .. v[1]))
    end
  end
end

return translator
