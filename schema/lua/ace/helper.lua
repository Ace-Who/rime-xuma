-- helper.lua

-- List features and usage of the schema.
local function translator(input, seg)
  if input:find('^help/$') then
    yield(Candidate("text", seg.start, seg._end, 'Ctrl + Shift + F', ' 簡入繁出'))
    yield(Candidate("text", seg.start, seg._end, 'Ctrl + C', ' 三重注解'))
    yield(Candidate("text", seg.start, seg._end, 'Ctrl + S', ' 屏蔽词组'))
    yield(Candidate("text", seg.start, seg._end, 'Ctrl + T', ' 显示时钟'))
  end
end

return translator
