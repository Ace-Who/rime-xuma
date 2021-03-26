-- rime.lua

helper = require("ace/helper")

single_char_only = require("ace/single_char_only")

local os_tools = require("ace/os_tools")
lazy_clock = os_tools.lazy_clock_filter
preedit_lazy_clock = os_tools.preedit_lazy_clock_filter
os_env = os_tools.os_env_translator

local t = require("ace/xuma_spelling")
xuma_spelling = t.filter
xuma_spelling_processor = t.processor

xuma_postpone_fullcode = require("ace/xuma_postpone_fullcode")

local t = require("ace/xuma_52p_precand")
xuma_52p_precand = t.filter
xuma_52p_precand_processor = t.processor
