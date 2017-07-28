# RZColorful
NSAttributedString富文本的方法集合，以及简单优雅的使用其多种属性

日常iOS开发过程中，少不得需要添加富文本以突出显示，在富文本设置过程中，代码冗长且不好记忆，所以这里以一个简洁的方式实现富文本字符串的使用集合。

## 关于RZColorful
* 支持UILabel、UITextView、UITextField的AttributedString的设置。
* 大部分富文本常用功能已经支持(颜色，字体，插入图片，阴影，下划线，删除线等等)，剩段落设置方法未实现，待空闲之后在补充完善。
* 因为构思不长，也找不到比较好的方法来规避iOS长方法名的限制，所以这里感谢[Masnory](https://github.com/SnapKit/Masonry),参照其思路方法也是目前我能想到的比较优雅的实现方式。

## How to use
* 请在需要使用的地方加上

```objc
#import "RZColorful.h"
```
下面以一段简单的代码来展示使用方法

```objc
    [textView rz_colorfulConfer:^(RZColorfulConferrer *confer) {
        confer.text(@"hello，大家好，先来默认数据").font(FONT(21));
        confer.appendImage([UIImage imageNamed:@"flower"]);
        confer.text(@"先来个红色").textColor(RGB(255, 0 ,0));
        confer.text(@"继续看颜色加字体").textColor(RGB(255, 255 ,80)).font(FONT(25));
        confer.text(@"继续看颜色加字体,给字加个背景").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230));
        confer.text(@"flush 连体字效果没看出来").ligature(@1);
        confer.appendImage([UIImage imageNamed:@"flower"]).bounds(CGRectMake(10, -2, 15, 15));
        confer.text(@"继续看颜色加字体,给字加个背景, 加点间距").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230)).wordSpace(@15);
        confer.text(@"限时特卖 加个删除线").strikeThrough(RZLineStyleSignl);
        // 插入图片时，可以设置图片和前后排文字字体大小一样，并且设置其origin.y 为适当负值，可对齐文本
        confer.appendImage([UIImage imageNamed:@""]).bounds(CGRectMake(10, -2, 15, 15));
        confer.text(@"删除线颜色修改").textColor(RGB(255, 0, 0)).font(FONT(15));


    }];

    [textView rz_colorfulConferAppend:^(RZColorfulConferrer *confer) {
        confer.text(@"此方法在原内容上增加文本\n");
        confer.text(@"空心描边\n").strokeColor(RGB(255, 0, 0)).strokeWidth(@3).font(FONT(30));
        confer.text(@"横竖排版好像iOS上并没有卵用\n").verticalGlyphForm(@1);
        confer.text(@"斜体字设置 > 0\n").italic(@1);
        confer.text(@"斜体字设置 < 0\n").italic(@(-1));
        confer.text(@"拉伸字体\n").expansion(@2);
        confer.text(@"设置点击的链接属性，需要textView.editable = NO\n");
        confer.text(@"可以添加一个带有url的字符串,可点击\n").underLineStyle(1).url(nil).font(FONT(30));

        confer.text(@"【text】之后的属性添加方法具体可以查看RZColorfulAttribute.h").font(FONT(21)).textColor(RGB(255, 0, 0));
        confer.text(@"  还有段落方法还未实现，我会在稍后继续完善\n").font(FONT(21)).textColor(RGB(255, 0, 0));
        // 阴影设置完之后如还需设置其他属性，可直接使用and，with，end连接词以继续添加text的属性
        confer.text(@"阴影测试").shadow.offset(CGSizeMake(10, 10)).radius(5).and.font(FONT(40)).textColor(RGB(255, 0, 0));
        confer.text(@"阴影测试2").shadow.color(RGB(0, 255, 0)).offset(CGSizeMake(10, 10)).radius(5).and.font(FONT(22));
        confer.text(@"阴影测试3").shadow.color(RGB(0, 0, 255)).offset(CGSizeMake(10, 10)).radius(5);
        confer.text(@"阴影测试4").shadow.color(RGB(0, 255, 255)).offset(CGSizeMake(-10, 10)).radius(5);
    }];

```
* 上边的代码主要就是textView的attributedString使用方法，UILabel、UITextFile是同样的使用方法
* `在UILabel、UITextFiled上url点击方法无效`
* `在UITextView中若要添加url且可点击方法，请先设置其editable = NO,并实现代理`


```objc
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"URL:%@", URL);
    // return NO;则不跳转，这里可以做一些基本判断在执行是否跳转浏览器打开url
    return YES; 
}
```

## 看看效果图
![IMG10.jpeg](https://github.com/rztime/RZColorful/blob/master/IMG10.jpeg)


## 注意

* 因为富文本渲染需要一定的时间，在使用过程中，如果需要在scrollView如tableView上不断的设置其富文本，此时请尽量少使用`rz_colorfulConferAppend:`这个方法，因为这个方法搭配`rz_colorfulConfer:`会重复绘制两次，在tableview滑动时可能会造成卡顿
* 所以在优化时，尽量少使用`rz_colorfulConferAppend:`这个方法，在`rz_colorfulConfer:`方法中绘制多一点进去将不影响
* 尽管我已经在代码中已经处理过（弱）引用问题，但是在实际运用写入text时，还是请尽量检查避免循环引用


## 最后
* 在使用过程中，如果您发现有什么问题，欢迎向我反馈，谢谢
