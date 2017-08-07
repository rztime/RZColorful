# RZColorful
NSAttributedString富文本的方法集合，以及简单优雅的使用其多种属性

日常iOS开发过程中，少不得需要添加富文本以突出显示，在富文本设置过程中，代码冗长且不好记忆，所以这里以一个简洁的方式实现富文本字符串的使用集合。

## 关于RZColorful
* 支持UILabel、UITextView、UITextField的AttributedString的设置。
* 包含的属性快捷设置
    * 文本颜色
    * 文本所在区域对应的背景颜色
    * 字体
    * 连体字
    * 字间距
    * 删除线、下划线，及其线条颜色
    * 描边，及其颜色
    * 斜体字
    * 拉伸
    * 阴影
    * 段落样式
* 这里感谢[Masnory](https://github.com/SnapKit/Masonry),参照其思路才实现了快捷简单使用的方法。

## How to use
* 请在需要使用的地方加上

```objc
#import "RZColorful.h"
```
下面以一段简单的代码来展示使用方法

### 基本的简单使用方法
```objc

    // 基本简单使用方法
    [label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        // 设置文本颜色
        confer.text(@"荷花开后西湖好，\n").textColor(RGB(255, 0, 0));
        // 设置文本字体
        confer.text(@"载酒来时。\n").font(FONT(19));
        // 可以将属性连起来
        confer.text(@"不用旌旗，\n").textColor(RGB(255, 0, 0)).font(FONT(19));
        // 更多属性方法可以参考 RZColorfulAttribute.h文件 基本属性设置
        // 基本属性包含 文本颜色、文字所在区域背景色，字体，连体字，字间距，删除线以及其颜色，下划线以及其颜色，描边，横竖排版，斜体字，拉伸字体（扩展）,带url的文本等
        confer.text(@"前后红幢绿盖随。\n").textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
    }];

```
### 有特殊属性使用方法（阴影，段落）

```objc

    // 基本简单使用方法 包含特殊的属性（阴影、段落），有且只有这两个属性设置稍有不同
    [label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
         // 设置阴影，偏移量，颜色，模糊等等
        confer.text(@"画船撑入花深处，\n").shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9));
        // 可设置好文本属性在设置阴影
        confer.text(@"香泛金卮。\n").font(FONT(19)).textColor(RGB(255, 0 , 0)).shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9));
        // 也可以使用连接词and/with/end之后，在继续设置文本的属性
        confer.text(@"烟雨微微，\n").shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9)).and.textColor(RGB(255, 0, 0)).font(FONT(19));
        // 段落使用方法及技巧也是同样如此，具体方法参照 RZParagraphStyle.h设置
        confer.text(@"一片笙歌醉里归。\n").paragraph.alignment(1).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
    }];

```

### 段落方法---统一的段落样式

```objc

        // 设置统一段落样式
    [label rz_colorfulWithParagraphStyle:^(RZParagraphStyle * _Nullable paragraph) {
        // 这里设置统一的段落样式，即confer.text（）都遵循此段落样式
        // 这里设置完后请勿使用and/with/end连接词，使用无效
        paragraph.lineSpacing(5).alignment(1);

    } confer:^(RZColorfulConferrer * _Nonnull confer) {
        // 所有的text内容都遵循上边的paragraphStyle，这里设置paragraph将无效。
        confer.text(@"常记溪亭日暮，\n沉醉不知归路。\n").paragraph.alignment(0).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
        confer.text(@"兴尽晚回舟，\n误入藕花深处。\n争渡，争渡，惊起一滩鸥鹭。\n").paragraph.alignment(3).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
    }];

```

* 在confer.text后添加的所有属性，仅且仅对当前行的text有效，对其他行无效
* 段落样式的两种方法
    * 1. confer.text().paragraph...() 
    * 2. rz_colorfulWithParagraphStyle: confer: 
    其区别在于第二种方法，可以设置confer中多种文本统一段落样式，文本更富有多样化，而第一种段落仅对其当前行内容有效

# 备注：
    * 多种属性使用名请参考对应的文件。
    * UILabel、UITextFile是同样的使用方法。
    * `在UILabel、UITextFiled上url点击方法无效`。
    * `在UITextView中若要添加url且可点击方法，请先设置其editable = NO,并实现代理`。


```objc
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"URL:%@", URL);
    // return NO;则不跳转，这里可以做一些基本判断在执行是否跳转浏览器打开url
    return YES; 
}
```

## 注意

* 因为富文本渲染需要一定的时间，在使用过程中，如果需要在scrollView如tableView上不断的设置其富文本，此时请尽量少使用`rz_colorfulConferAppend:` 以及 `rz_colorfulWithParagraphStyleAppend: attribute:`方法，因为其追加时将重复绘制，在tableview滑动时可能会造成卡顿
* 尽管我已经在代码中已经处理过（弱）引用问题，但是在实际运用写入text时，还是请尽量检查避免循环引用


## 最后
* 在使用过程中，如果您发现有什么问题，欢迎向我反馈，谢谢
