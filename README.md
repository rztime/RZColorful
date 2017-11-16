# RZColorful
NSAttributedString富文本的方法集合，以及简单优雅的使用其多种属性

* 日常iOS开发过程中，少不得需要添加富文本以突出显示，在富文本设置过程中，代码冗长且不好记忆，所以这里以一个简洁的方式实现富文本字符串的使用集合。
* 因为textField、textView、label三方内容相似，所以整合所有的使用方法到UIView中。
* 新增刷新界面时保持文本框焦点的方法 [demo查看](https://github.com/rztime/ContinueFirsterResponder)
* 富文本内容可单独抽出来,在下边这个文件夹中
```
#import "NSAttributedString+RZColorful.h"
```

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
    * 通过html源码加载富文本
    * 通过url添加图片到富文本
* 这里感谢[Masnory](https://github.com/SnapKit/Masonry),参照其思路才实现了快捷简单使用的方法。

## How to use
* 添加代码到项目中
```objc
pod ‘RZColorful’
```

* 请在需要使用的地方加上

```objc
#import "RZColorful.h"
```
下面以一段简单的代码来展示使用方法

### 基本的简单使用方法
```objc

    // 基本简单使用方法
    [textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        // 设置文本颜色
        confer.text(@"荷花开后西湖好，\n").textColor(RGB(255, 0, 0));
        // 设置文本字体
        confer.text(@"载酒来时。\n").font(FONT(19));
        // 可以将属性连起来
        confer.text(@"不用旌旗，\n").textColor(RGB(255, 0, 0)).font(FONT(19));
        // 更多属性方法可以参考 RZColorfulAttribute.h文件 基本属性设置
        // 基本属性包含 文本颜色、文字所在区域背景色，字体，连体字，字间距，删除线以及其颜色，下划线以及其颜色，描边，横竖排版，斜体字，拉伸字体（扩展）,带url的文本等
        confer.text(@"前后红幢绿盖随。\n").textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
        
        #warning 设置宽或者高为0 时，其将自动根据图片大小适配宽或者高
        // 通过图片url加载图片
        confer.appendImageByUrl(url).bounds(CGRectMake(0, 0, 300, 0)); //
        
        #warning 加载html源码内容
        // 通过html源码，加载内容
        confer.htmlText(htmlstring);
        
        #warning 将按照设置宽高显示
        // 直接添加资源文件中的图片
        confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, 0, 100, 100));
    }];

```
### 有特殊属性使用方法（阴影，段落）

```objc

    // 基本简单使用方法 包含特殊的属性（阴影、段落），有且只有这两个属性设置稍有不同
    [textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
         // 设置阴影，偏移量，颜色，模糊等等
        confer.text(@"画船撑入花深处，\n").shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9));
        // 可设置好文本属性在设置阴影
        confer.text(@"香泛金卮。\n").font(FONT(19)).textColor(RGB(255, 0 , 0)).shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9));
        // 也可以使用连接词and/with/end之后，在继续设置文本的属性
        confer.text(@"烟雨微微，\n").shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9)).and.textColor(RGB(255, 0, 0)).font(FONT(19));
        // 段落使用方法及技巧也是同样如此，具体方法参照 RZParagraphStyle.h设置
        confer.text(@"一片笙歌醉里归。\n").paragraphStyle.alignment(1).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
    }];


```

### 段落方法---统一的段落样式

```objc

    // 段落，阴影，可以设置当前控件全局的统一样式，也可以设置局部的样式，局部的样式优先级高于全局的
    [label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.paragraphStyle.lineSpacing(15).baseWritingDirection(NSWritingDirectionRightToLeft); // 这里设置全局的段落样式，and等连接词不可用
        confer.text(@"常记溪亭日暮，\n沉醉不知归路。\n").textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
        confer.text(@"兴尽晚回舟，\n误入藕花深处。\n争渡，争渡，惊起一滩鸥鹭。\n").paragraphStyle.alignment(3).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);// 这里设置局部的连接词，and连接词之后可以继续添加text的属性
    }];

```

* 在confer.text后添加的所有属性，仅且仅对当前行的text有效，对其他行无效
* 段落样式的两种方法
    *   confer.text().paragraphStyle
    *  confer.paragraphStyle
    *  第2种方法是对当前控件的全局的一个段落样式设置，第1种是局部的段落样式，当设置了1的部分，则全局样式将被局部覆盖

* 阴影方法与上同样两种方式

# 备注：
    * 多种属性使用名请参考对应的文件。
    * UILabel、UITextFile是同样的使用方法。
    * 在UILabel、UITextFiled上url点击方法无效。
    * 在UITextView中若要添加url且可点击方法，请先设置其editable = NO,并实现代理。


```objc
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"URL:%@", URL);
    // return NO;则不跳转，这里可以做一些基本判断在执行是否跳转浏览器打开url
    return YES; 
}
```

## 注意

* 尽管我已经在代码中已经处理过（弱）引用问题，但是在实际运用写入text时，还是请尽量检查避免循环引用


## 最后
* 在使用过程中，如果您发现有什么问题，欢迎向我反馈，谢谢
