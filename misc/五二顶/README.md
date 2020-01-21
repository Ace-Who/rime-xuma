# 徐码五二顶（未完成）

## 什么是五二顶

四码定长方案的用户应该都熟悉「五码顶屏」的打法，即每次打第五码时就把前四码顶出
，输入码只剩下最后一码，同时上屏前四码第一候选。这可以理解为「五四顶」。类似地，
「五二顶」就是每次打第五码时就顶出前二码，剩下后三码，同时上屏前二码的第一候选。
这也是唯一的区别。

## 为什么要做五二顶

先说说为什么要有五四顶——少按空格，降低键长。但是日常打字，四码字是最少的，最
多的是二码字，是四码字的十倍以上，改为五二顶才能最大程度地节省空格键。经测试，
打文章，徐码五二顶比五四顶的键长降低 10%~15%。

## 区重补码

延用普通版码表，一简和二简设置了三重候选，第一重为单字，二三重为词组。顶功版仅
为一简和二简增设区重补码 `[;'`，打补码后必定无重，并自动上屏。如 `u` 的三重候选
为 「的」「的话」「的吗」，输入 `u[`、`u;`、`u'` 可依次上屏这三个词条。为方便和
效率计，补码 `[` 还绑定到了 `TAB` 键，这样安排在双手对称位置，尽可能接近敲空格
的体验。

## 五二顶示例详解

例子（`_` 表示空格）：

    fuvr_ = 摠
    fuvr2 = 输入
    fuvr[ = 输入

同样是上屏「输入」，`fuvr2` 是选择 `fuvr` 的第二候选，是词组打法。 `fuvr[` 是依
次上屏「输」「入」二字，是单字打法。`fu = 输, vr[ = 入`，在输入 `[` 时顶出前二
码 `fu` 并上屏它的第一候选「输」，接着余下三码 `vr[` 的候选「入」是无重的，因此
自动上屏。五二顶是可以完全打单字或简词的，具有完全的确定性。又如：

    pf = 看
    yc = 望
    pfyc[ = 看望（单字顶，等同于 pf_yc_）
    pfyc_ = 看望（打词组）

    sb = 很
    ea = 可能（第二重）
    sbea; = 很可能（等同于 sb_ea; 或 sb_ea2）
    sbea2 = 律动（sbea 的第二重）

    fuvrzj[ = 输入法（等同于 fu_vr_zj_）

只能顶前二码，不是二码字就只能用空格上屏，正如五四顶中只能顶前四码。错误顶码的
例子：

    正：f_cx_ = 大小
    误：fcx[ = 车道

    正：sui_gam_ = 徐码
    误：suigam[ = 脸工马

只能顶首选，其他候选只能先选重上屏，再输入后续文字的编码。错误顶码的例子：

    正：kj;kg_ = 思考题
    误：kjkg[ = 甲题

## 键长比较和演示

下面依次用普通单字打法、普通简词打法、五二顶单字打法、五二顶简词打法来打同一段
文字。普通打法也省略标点前的空格。界面候选的选重键假定为数字键（普通打法固然可
以定义符号键选重，但由于顶功占用了符号来作区重补码，就统一为数字键选重，以免混
淆和误解。）试比较它们的键长。

``` 
简词标注：
冰灯是流行于[中国]北方的一种古老的民间[艺术][形式]。[因为][独特]的地域优势，黑龙江[可以]说是[制作]冰灯最早的[地方]。

原始文本：
冰灯是流行于中国北方的一种古老的民间艺术形式。因为独特的地域优势，黑龙江可以说是制作冰灯最早的地方。
xa xed k zy sx gi o ne xvi yu u g rok jg jvi u df zk hb iwu ghs figi.nf zc vlv pji u j jfo tjo fr,mh jpu zi eo c zx k pm tpl xa xed kh kz u j yu.
xa xed k zy sx gi o; xvi yu u g rok jg jvi u df zk hb3gh3.nz2vl3u j jfo tjo fr,mh jpu zi ec2zx k pt2xa xed kh kz u j2.
xaxed k zysxgio[nexvi yuu[g rok jgjvi u dfzkhbiwu ghs figi.nfzcvlv pji u j jfo tjo fr,mhjpu zieoc[zxk[pmtpl xaxed khkzu[j yu.
xaxed k zysxgio;xvi yuu[g rok jgjvi u dfzkhb'gh'.nz;vl'u j jfo tjo fr,mhjpu ziec;zxk[pt;xaxed khkzu[j;.

```

以下是单字打法和简词打法的慢速动态演示：

![单字打法](demo/xuma_52p_single_style.gif)
![简词打法](demo/xuma_52p_phrase_style.gif)

一二简的第一候选总是可以用 `[` 上屏的，而空格上屏只能用在单独打的时候（即不是紧
接在二码字后）。有人习惯空格上屏，因此每次要判断前一个字是不是二码字，可能降低
效率，不容易形成条件反射，所以可以考虑一律用 `[` 上屏一二简的第一候选，即如下打
法：

```
冰灯是流行于中国北方的一种古老的民间艺术形式。因为独特的地域优势，黑龙江可以说是制作冰灯最早的地方。
xaxed k[zysxgio[nexvi yuu[g[rok jgjvi u[dfzkhbiwu ghs figi.nfzcvlv pji u[j[jfo tjo fr,mhjpu zieoc[zxk[pmtpl xaxed khkzu[j[yu.
xaxed k[zysxgio;xvi yuu[g[rok jgjvi u[dfzkhb'gh'.nz;vl'u[j[jfo tjo fr,mhjpu ziec;zxk[pt;xaxed khkzu[j;.
```

## 与普通版功能的区别——造词和连打

切分符由 `'` 改为 `` ` ``，并且插入切分符后才能进入「连打·造词」模式，造词是在
此模式中，自造词也只能在该模式中看到，这是由于 Rime 实现方式的限制。如造「五二
顶」，需输入 ``gdu`ee`egm`` 并上屏，该词组即编码为 `geeg`，要调出时，需输入
`` geeg` ``。

## 鸣谢

用 Rime 改造徐码为五二顶的方法来自蓝落萧的形音四二顶方案
[C42](https://github.com/lanluoxiao/c42)。
