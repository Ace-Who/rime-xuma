# 徐码五二顶

## 什么是五二顶

四码定长方案的用户应该都熟悉「五码顶屏」的打法，即每次打第五码时就顶出前四码，
上屏其第一候选，此时输入码只剩下最后一码，从而实现省略四码字后面的空格的目的。
「五二顶」是类似的，区别只是顶出的是前二码，剩下的是后三码，省略的是二码字后面
的空格。五二顶与常规方案的码表一致，保持了徐码「完美的规则性」。

经测试，徐码的二码离散性较高，二码字频率高于三码字，因此适合改造为五二顶。并不
是每一款四码定长方案都是如此，这是徐码的特性。

## 五二顶的优势

省略了多少空格？键长降低了多少？

科学形码评测系统v1.6.3 测得的加权键长：前 300 字 2.13，前 1500 字 2.52。

经测试，用五二顶打文章，键长降低了 10%~15%。在引入「置换码」优化二级简码字从而
提高二码字频率后，杀空格的效果进一步增强。在目前的码表下，都打单字时键长降低
15%~18%，都打简词时键长降低 12%~15%。打单的键长低于三码定长的至至郑码，高于四二
顶 C42，打简词的键长浮动较大，低时低于单字小兮码、西风瘦码，高时高于 C42，总体
上在两类之间，日常聊天的场景更占优势。

简言之，键长令人满意。五二顶改造当然无法和天生的顶功方案相提并论，但是别忘了徐
码是以全体九万汉字为编码目标的，本方案没有改变这一点。

## 学习徐码五二顶的最佳时机是何时

以下是个人看法。应先通过常规方案学习徐码，再适时转向五二顶。早了不行，步子迈太
大；晚了不好，一二码字加空格上屏的习惯难改。最好是在完全掌握了徐码字根和拆字规
则之后，打字未到熟练之时，量化标准大约是击键 2.5 或速度 40 字/分钟。

## 区重补码

徐码五二顶沿用常规版码表，一级简码和二级简码设置了三重候选，第一重为单字，二三
重为词组。五二顶仅为一简和二简增设区重补码 `[;'`，打出补码后自动上屏。如 `u` 的
三重候选为 「的」「的是」「的时候」，输入 `u[`、`u;`、`u'` 可依次上屏这三个词条
。为方便和效率计，补码 `[` 还绑定到了 `TAB` 键，这样安排在双手对称位置，尽可能
接近敲空格的体验。

在三码或四码后输入补码时，也会上屏前二码的第一候选和余下编码对应的简码词条。参
考下面的示例。

## 五二顶示例详解

例子（`_` 表示空格）：

    fstgl_ = 示例 = fs_tgl_

在输入 `l` 时输入码长度达到 5，会顶出前二码 `fs` 并上屏其第一候选「示」，余下三
码 `tgl` 的唯一候选是「例」，按空格后上屏。

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
    gqwg_ = 确定 = gq_wg_
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

下面依次用常规方案的单字打法、简词打法和五二顶方案的单字打法、简词打法来打同一
段文字。常规方案打法也省略标点前的空格。界面候选的选重键假定为数字键（常规方案
固然可以定义符号键选重，但由于顶功占用了符号来作区重补码，就统一为数字键选重，
以免混淆和误解。）试比较它们的键长。

``` 
简词标注：
冰灯是流行于[中国]北方的一种古老的民间[艺术][形式]。[因为][独特]的地域优势，黑龙江[可以]说是[制作]冰灯最早的[地方]。

原始文本：
冰灯是流行于中国北方的一种古老的民间艺术形式。因为独特的地域优势，黑龙江可以说是制作冰灯最早的地方。
xa xed k zy sx gi o ne xvi yu u g rok jg jvi u df zk hb iwu ghs figi.nf zc vlv pji u j jfo tjo fr,mh jpu zi eo c zx k pm tpl xa xed kh kz u j yu.
xa xed k zy sx gi o;xvi yu u g rok jg jvi u df zk hb3gh3.n2vl3u j jfo tjo fr,mh jpu zi e2zx k pt2xa xed kh kz u j3.
xaxed k zysxgio[nexvi yuu[g rok jgjvi u dfzkhbiwu ghs figi.nfzcvlv pji u j jfo tjo fr,mhjpu zieoc[zxk[pmtpl xaxed khkzu[j yu.
xaxed k zysxgio;xvi yuu[g rok jgjvi u dfzkhb'gh'.n;vl'u j jfo tjo fr,mhjpu zie;zxk[pt;xaxed khkzu[j'.

按照引入置换码后的码表：
xa xed k zy sx gi o ne xvi yu u g ro jg jv u df zk hb iwu ghs fi.nf zc vlv pji u j jfo tjo fr,mh jpu zi eo c zx k pm tp xa xed kh kz u j yu.
xa xed k zy xs gi o;xvi yu u g ro jg jv u df zk hb3gh3.n2vl3u j jfo tjo fr,mh jpu zi e2zx k pt2xa xed kh kz u j3.
xaxed k zysxgio[nexvi yuu[g rojgjvu[dfzkhbiwu ghs fi.nfzcvlv pji u j jfo tjo fr,mhjpu zieoc[zxk[pmtpxaxed khkzu[j yu.
xaxed k zysxgio;xvi yuu[g rojgjvu[dfzkhb'gh'.n;vl'u j jfo tjo fr,mhjpu zie;zxk[pt;xaxed khkzu[j'.
```

以下是单字打法和简词打法的慢速动态演示（使用的是较旧的码表，码长较长）：

![单字打法](demo/xuma_52p_single_style.gif)
![简词打法](demo/xuma_52p_phrase_style.gif)

一二简的第一候选总是可以用 `[` 上屏的，而空格上屏只能用在单独打的时候（即不是紧
接在二码字后）。如果每次先判断前一个字是不是单独打的、是不是一码或二码字，可能
降低效率，不容易形成条件反射，所以可以考虑在初期一律用 `[` 上屏一二码的第一候选
，即如下打法：

```
冰灯是流行于中国北方的一种古老的民间艺术形式。因为独特的地域优势，黑龙江可以说是制作冰灯最早的地方。
xaxed k[zysxgio[nexvi yuu[g[rok jgjvi u[dfzkhbiwu ghs figi.nfzcvlv pji u[j[jfo tjo fr,mhjpu zieoc[zxk[pmtpl xaxed khkzu[j[yu.
xaxed k[zysxgio;xvi yuu[g[rok jgjvi u[dfzkhb'gh'.n;vl'u[j[jfo tjo fr,mhjpu zie;zxk[pt;xaxed khkzu[j'.

按照引入置换码后的码表：
xaxed k[zysxgio[nexvi yuu[g[rojgjvu[dfzkhbiwu ghs fi.nfzcvlv pji u[j[jfo tjo fr,mhjpu zieoc[zxk[pmtpxaxed khkzu[j[yu.
xaxed k[zysxgio;xvi yuu[g[rojgjvu[dfzkhb'gh'.n;vl'u[j[jfo tjo fr,mhjpu zie;zxk[pt;xaxed khkzu[j'.
```

## 与常规版功能的差异

### 造词和连打

切分符由 `'` 改为 `` ` ``，并且插入切分符后才能进入「连打·造词」模式，造词是在
此模式中，自造词也只能在该模式中看到，这是由于 Rime 实现方式的限制。如造「五二
顶」，需输入 ``gd`ee`egm`` 并上屏，该词组即编码为 `geeg`，要调出时，需输入 ``
geeg` ``。

## 鸣谢

用 Rime 改造徐码为五二顶的方法来自蓝落萧的形音四二顶方案
[C42](https://github.com/lanluoxiao/c42)。
