# 徐码五二顶

## 什么是五二顶

四码定长方案的用户应该都熟悉「五码顶屏」的打法，即每次打第五码时就把前四码顶出
，输入码只剩下最后一码，同时上屏前四码第一候选。「五二顶」是类似的，区别只是顶
出的是前二码，剩下的是后三码。

## 为什么要做五二顶

先说说为什么要有「五码顶四码」——为了少按空格，降低键长。但是经测试，用徐码打
文章和日常打字，四码字是最少的，二码字是最多的，是四码字的十倍以上，因此徐码适
合改造为五二顶。经测试，用五二顶打文章的键长降低了 10%~15%。

## 区重补码

徐码五二顶版沿用普通版码表，一简和二简设置了三重候选，第一重为单字，二三重为词
组。顶功版仅为一简和二简增设区重补码 `[;'`，打出补码后自动上屏。如 `u` 的三重候
选为 「的」「的话」「的吗」，输入 `u[`、`u;`、`u'` 可依次上屏这三个词条。为方便
和效率计，补码 `[` 还绑定到了 `TAB` 键，这样安排在双手对称位置，尽可能接近敲空
格的体验。

在三码或四码后输入补码时，也会顶出前二码并上屏其第一候选和余下编码对应的唯一简
码词条。参考下面的示例。

## 五二顶示例详解

例子（`_` 表示空格）：

    wiivo_ = 空格 = wi_ivo_

在输入 `o` 时输入码长度达到 5，会顶出前二码 `wi` 并上屏其第一候选「空」，余下三
码 `ivo` 的唯一候选是「格」，按空格后上屏。

    fuvr_ = 摠
    fuvr2 = 输入
    fuvr[ = 输入（等同于 fu_vr_）

空格上屏等同于按数字键 1，是上屏候选界面的第一项。同样是上屏「输入」，`fuvr2`
是选择 `fuvr` 的第二候选，是词组打法。 `fuvr[` 是依次上屏「输」「入」二字，是单
字打法。`fu = 输, vr[ = 入`，在输入 `[` 时顶出前二码 `fu`，自动上屏「输」和「入
」。五二顶是可以完全打单字或简词的，具有完全的确定性，因为它和常规的五码顶屏没
有本质区别。又如：

    xk[ = xk_ = 单
    wb[ = wb_ = 字
    xkwb[ = 单字 = xk_wb_（打单字）
    xkwb_ = 单字（打词组）

    sb[ = sb_ = 很
    ea; = ea2 = 可能
    sbea; = 很可能 = sb_ea2
    sbea_ = 律动

    cbu[ = 好的 = cb_u_
    gqwgl_ = 确定 = gq_wgl_
    yuwci_ = 方案 = yu_wci_
    fuvrzj[ = 输入法 = fu_vr_zj_

只能顶前二码，不是二码字就只能用空格上屏，正如五四顶中只能顶前四码。错误顶码的
例子：

    正：f_cx_ = 大小
    误：fcx[ = 车道 = fc_x_

    正：pvz_rk_ = 选重
    误：pvzrk[ = 先话是 = pv_zr_k_

    正：sui_gam_ = 徐码
    误：suigam[ = 脸工马 = su_ig_am_（三码字并无区重补码，gam[ 也不对）

只能顶首选，其他候选只能先选重上屏，再输入后续文字的编码。错误顶码的例子：

    正：kj;kg_ = 思考题
    误：kjkg[ = 甲题 = kj_kg_

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
接在二码字后）。如果每次先判断前一个字是不是单独打的、是不是一码或二码字，可能
降低效率，不容易形成条件反射，所以可以考虑在初期一律用 `[` 上屏一二码的第一候选
，即如下打法：

```
冰灯是流行于中国北方的一种古老的民间艺术形式。因为独特的地域优势，黑龙江可以说是制作冰灯最早的地方。
xaxed k[zysxgio[nexvi yuu[g[rok jgjvi u[dfzkhbiwu ghs figi.nfzcvlv pji u[j[jfo tjo fr,mhjpu zieoc[zxk[pmtpl xaxed khkzu[j[yu.
xaxed k[zysxgio;xvi yuu[g[rok jgjvi u[dfzkhb'gh'.nz;vl'u[j[jfo tjo fr,mhjpu ziec;zxk[pt;xaxed khkzu[j;.
```

## 与普通版功能的差异

### 造词和连打

切分符由 `'` 改为 `` ` ``，并且插入切分符后才能进入「连打·造词」模式，造词是在
此模式中，自造词也只能在该模式中看到，这是由于 Rime 实现方式的限制。如造「五二
顶」，需输入 ``gdu`ee`egm`` 并上屏，该词组即编码为 `geeg`，要调出时，需输入
`` geeg` ``。

## 鸣谢

用 Rime 改造徐码为五二顶的方法来自蓝落萧的形音四二顶方案
[C42](https://github.com/lanluoxiao/c42)。
