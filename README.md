# Rime 徐码三重注解方案

[发布地址](https://github.com/Ace-Who/rime-xuma-spelling) ·
[项目主页](https://ace-who.github.io/rime-xuma-spelling/) ·
[徐码文档](https://www.xumax.top) ·
[Rime 输入法引擎 | 中州韻 | 小狼毫 | 鼠须管](https://rime.im/)

三重注解的特点：

- 字根拆分 + 编码 + 拼音。
- 支持词组拆分（按照官方词组编码规则）。
- 大码大写、全简合一。

![三重注解](demo/tripple_comment.png)

方案自带说明：

![自带说明](demo/help.gif)

快捷键演示：

![快捷键效果](demo/shortcut_keys.gif)

## 功能

多种实用功能，尤其适合「徐码简繁通打输入法／爾雅输入法」初学者（我）。

![自带说明](demo/help.shortcut_keys.png)
![自带说明](demo/help.reverse_lookup.png)

- ~<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>：三重注解~ (划掉)
- <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd>：简入繁出
- <kbd>Ctrl</kbd> + <kbd>C</kbd>：三重注解，仅在选字界面有效。
- <kbd>Ctrl</kbd> + <kbd>S</kbd>：屏蔽词组，仅在选字界面有效。
- <kbd>Ctrl</kbd> + <kbd>T</kbd>：显示时钟，仅在选字界面有效。
- <kbd>F4</kbd> / <kbd>Ctrl</kbd> + <kbd>\` </kbd> 选单：可控制以上开关、字符集
选择（默认 GBK）、繁体简化（繁入简出，默认开启）。
- 引导符「\`」：双重反查（全拼 + 五笔画）
- 引导符「\`P」：全拼反查
- 引导符「\`B」：五笔画反查（横h 竖s 撇p 捺/点n 折z）

还有其它贴心特性（固态词典固定词序、自造词自动调序），省略介绍。

![自造词注解](demo/user_dict_comment.png)

![环境变量支持](demo/environment_variable.png)

## 安装说明

0. 如果正在使用本方案的 v0.4 之后的版本，`xuma_spelling.reverse.bin` 文件会被
   Rime 算法服务进程锁定，新文件无法直接覆盖替换，需要先退出算法服务，完成以下
   步骤后可能需要手动启动算法服务。
1. 将 schema 目录下的文件放到 rime 用户目录（什么是[用户目录](
  https://github.com/rime/home/wiki/UserData)）。
2. 在输入法设定中添加方案「徐码／爾雅·Q分享版」。

## 数据来源

字根拆分原始数据由 QQ 徐码输入法官方群（218210590）小鸮（1360057135）提供。  
拼音数据来自 [Mozillazg 整理的汉典数据](https://github.com/mozillazg/pinyin-data)。  
