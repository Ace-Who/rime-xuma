-- os_tools.lua

-- Insert a candidate containing current time as a lazy clock.
local function lazy_clock_filter(input, env)
  if not env.engine.context:get_option('lazy_clock') then
    for cand in input:iter() do yield(cand) end
    return
  end
  local page_size = env.engine.schema.page_size
  local i = 1
  local prev_cand = {}
  local done = false
  for cand in input:iter() do
    if page_size > 1 and not done and i == page_size then
      done = true
      yield(Candidate("lazy_clock", cand.start, cand._end, os.date("%H:%M:%S"), " 懒钟"))
    end
    yield(cand)
    -- Only count unique candidates.
    if cand.text ~= prev_cand.text then i = i+1 end
    prev_cand = cand
  end
  if not done then
    yield(Candidate("lazy_clock", 1, -1, os.date("%H:%M:%S"), " 不打不走"))
  end
end

-- 将 `env/VAR` 翻译为系统环境变量。
-- 长度限制为 199 字节。太长时 UI 卡住，且实际上屏的是前 199 字节。
local function os_env_translator(input, seg)
  local prefix = '^env/'
  if input:find(prefix .. '%w+') then
    local val = os.getenv(input:gsub(prefix, ''))
    if val ~= '' then
      yield(Candidate("os_env", seg.start, seg._end, val:sub(1,199), " 环境变量"))
    end
  end
end

local function os_run_translator(input, seg)
  local prefix = '^run/'
  if input:find(prefix .. '%w+') then
    local command = input:gsub(prefix, '')
    yield(Candidate("os_run", seg.start, seg._end, command, "运行命令(Ctrl+R)"))
  end
end

return { lazy_clock_filter = lazy_clock_filter,
    os_env_translator = os_env_translator,
    os_run_translator = os_run_translator }
