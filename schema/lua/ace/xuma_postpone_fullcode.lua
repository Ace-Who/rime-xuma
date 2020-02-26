-- xuma_postpone_fullcode.lua
-- 出现重码时，将全码匹配且有简码的「单字」「适当」后置。
-- 目前的实现方式，原理适用于所有使用规则简码的形码方案。

local function init(env)
  local config = env.engine.schema.config
  local code_rvdb = config:get_string('lua_reverse_db/code')
  env.code_rvdb = ReverseDb('build/' .. code_rvdb .. '.reverse.bin')
  env.his_inp = config:get_string('history/input')
  env.delimiter = config:get_string('speller/delimiter')
  env.radstr = ''
      .. ' 一不了人之大上也子而生自其行十用发天方'
      .. '日三小二心又长已月力文王西手工门身由儿入'
      .. '己山曰世水立走女言马金口几气比白非夫未士'
      .. '且目电八九七石车千干火臣广古早母乃亦示土'
      .. '片音止食黑衣革巴户木米田毛永习耳雨皮甲凡'
      .. '丁鱼牛申川鬼刀牙予骨末辛尤厂丰乌麻贝乙鸟'
      .. '辰羊瓦虫尸鼻壬羽戊寸巳舟夕甫矛酉亥卜戈鼠'
      .. '鹿弓瓜穴欠巾兀矢犬爪歹禾夭禺匕豕臼匚弋皿'
      .. '缶髟钅攵幺卅艮耒隹殳攴長見風彡門貝車飛巛'
      .. '馬魚齒頁鹵鳥丂丄丅丆丌丨丩丬丱丶丷丿乀乁'
      .. '乂乚乛亅亠亻僉冂冊冎冖冫凵刂勹匸卄卌卝卩'
      .. '厶吅囗夂夊宀屮巜廴廾彐彳忄戶扌朩氵氺灬為'
      .. '烏爫爾爿牜犭疒癶礻糸糹纟罒耂艹虍衤覀訁讠'
      .. '豸辶釒镸阝韋飠饣鬥黽'
      .. '兀㐄㐅㔾䒑'
end

local function get_short(codestr)
  local s = ' ' .. codestr
  for code in s:gmatch('%l+') do
    if s:find(' ' .. code .. '%l+') then
      return code
    end
  end
end

local function not_longer_and_full(cand, env)
  -- completion 和 sentence 类型不属于精确匹配，但不能仅用 cand.type 判断，因为
  -- 可能被 simplifier 覆盖为 simplified 类型。先行判断 cand.type 并非必要，只是
  -- 为了轻微的性能优势。
  if cand.type == 'completion' or cand.type == 'sentence' then
    return false, true
  end
  local input = env.engine.context.input
  local cand_input = input:sub(cand.start + 1, cand._end)
  -- 去掉可能含有的 delimiter。
  -- cand_input = cand_input:gsub('[ `\']', '')
  cand_input = cand_input:gsub('[' .. env.delimiter .. ']', '')
  -- 字根可能设置了三码以上的特码，输入特码时不予后置。
  if cand_input:len() > 2 and env.radstr:find(cand.text, 1, true) then
    return true
  end
  -- history_translator 不后置。
  if cand_input == env.his_inp then
    return true
  end
  local codestr = env.code_rvdb:lookup(cand:get_genuine().text)
  local is_comp = not
      string.find(' ' .. codestr .. ' ', ' ' .. cand_input .. ' ', 1, true)
  if not is_comp then
    local short = get_short(codestr)
    return (not short or cand_input == short), is_comp
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
        -- 如输入 otu 且光标在 u 后时会出现编码为 ot 的候选，需单独排除。不过通
        -- 过码表填满三码和四码的位置，就没有这个问题了。但是造句翻译器还是需要
        -- 。
        local is_bad_script_cand = cand._end < context.caret_pos
        local not_drop, is_comp = not_longer_and_full(cand, env)
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
