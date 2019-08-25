# Rime 徐码三重注解方案与补丁

[发布地址](https://github.com/Ace-Who/rime-xuma-spelling) ·
[项目主页](https://ace-who.github.io/rime-xuma-spelling/) ·
[徐码文档](https://www.xumax.top)

![效果图](demo.png)

## 功能

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>：三重注解（字根拆分提示 + 编
码提示 + 拼音提示）

<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd>：简入繁出

引导符「\`」：双重反查（全拼 + 五笔画）

引导符「\`P」：全拼反查

引导符「\`B」：五笔画反查（横h 竖s 撇p 捺n 折z）

## 说明

可使用完整方案，文件在 schema 目录下。

也可使用补丁，文件在 patch 目录下。需要自备基础方案，包括 xuma.schema.yaml 文件
和词典文件。补丁仅包含三重注解功能。

1. 将方案或补丁文件放到 rime 用户目录（补丁与 xuma.schema.yaml 并列），
2. 将 opencc 内的文件放到「程序目录/opencc」目录。

补丁默认使用 `xuma_spelling_qmod.json`，可修改 xuma.custom.yaml 以使用
`xuma_spelling_qmod_xumaCase.json`，效果是「**大码大写**」。

![大码大写版本效果图](demo_xumaCase.png)

或用 `xuma_spelling_qmod_2in1code.json`，效果是「**简全合一**」。

![简全合一版本效果图](demo_2in1code.png)

还有 `xuma_spelling_qmod_xumaCase_2in1code`，「**两者兼得**」。完整方案使用此版
本。

![大码大写简全合一版本效果图](demo_xumaCase_2in1code.png)

## 提示

结合反查功能使用效果更佳，三重注解滤镜已经配置为对 `tag` 为 `reverse_lookup` 的
相关组件生效。（完整方案已包含双重反查功能）

## 其它

字根拆分提示数据由 QQ 徐码输入法官方群（218210590）小鸮（1360057135）提供。  
拼音数据来自 [Mozillazg 整理的汉典数据](https://github.com/mozillazg/pinyin-data)。
