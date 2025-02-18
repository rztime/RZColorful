##### 1.6.0

新增完善iOS14-18的富文本属性
优化富文本截断方法的内部实现
图片使用.more，可以添加文本一样的属性

##### 1.5.0

新增对富文本进行阶段
```
    NSAttributedString *newAttr = [attr rz_attributedStringBy:3 maxWidth:300 lineBreakMode:NSLineBreakByTruncatingTail placeHolder:[[NSAttributedString alloc] initWithString:@"..."]];
```

新增给paragraphStyle里添加行数限制 如：
```
/// 只对2中的文本进行行数计算，如果前后有1、3，将不适用
confer.text("1").
confer.text("2")?.paragraphStyle?.numberOfLines(3, maxWidth: width).lineBreakMode(.byTruncatingMiddle)
confer.text("3").
```

新增NSAttributedString里关键字标记

##### 1.4.0
* 新增iOS15的方法
* 给UILabel添加超行显示 “折叠” “收起” 功能
* 给UILabel添加富文本可点击事件

##### 1.3.1
* 将 RZLineStyle 替换为原系统 NSUnderlineStyle ，设置时，可设置单线双线虚线破折号线等等
* NSAttributedString系统转换为html的方法，有部分标签会无效，所以新增方法，将无效的标签，通过代码注入style，将无效的标签通过css实现了。 看[- (NSString *)rz_codingToCompleteHtmlByWeb](https://github.com/rztime/RZColorful/blob/master/RZColorfulExample/RZColorful/AttributeCore/NSAttributedString+RZHtml.h)


##### 1.3.0
* 新增富文本在drawRect之后，获取每一行的文本和Range 
* 一些其他优化


##### 1.2.5更新日志
* 1.修复在html转换成富文本时，当NSLinkAttributeName对应的URL未包含http（https）时，iOS系统自动为其添加的“applewebdata://BF307C6C-5A2C-4F76-B3A0-6FD67E66CF82/”，导致所对应的url或tapId错误的bug
* 2.在UITextView的rzDidTapTextView回调中新增返回值，以控制其是否跳转浏览器



##### 1.2.4更新日志

* 1.新增图片的size设置方式 并可参照前后文本字体进行对齐，并在某些情况下做y轴偏移 （对齐中文效果较好，英文会有偏差）
```
	confer.appendImage([UIImage imageNamed:@"image"]).size(CGSizeMake(32, 32), RZHorizontalAlignBottom, rzFont(16)).yOffset(10);
```


* 2.新增图片、文本、html的点击事件 .tapAction(@"1") 只对UITextView有效
```
	confer.appendImage([UIImage imageNamed:@"image"]).size(CGSizeMake(32, 32), RZHorizontalAlignBottom, rzFont(16)).tapAction(@"22222222");

	confer.text(@"点击事件1").font(rzFont(30)).tapAction(@"1").textColor(UIColor.orangeColor);

	confer.htmlText(htmlstring); // 此自动实现tapAction方法
```
* 需要实现UITextView的rzDidTapTextView方法
```
    textView.rzDidTapTextView = ^(id  _Nullable tapObj) {
        //tapObj :可以是tapaction里的 tapId， 也可能是htmlstring里的NSURL
        NSLog(@"点击了：%@", tapObj);
    };
```

``` 
    // 点击事件默认文本会有颜色，去掉可用：
    textView.linkTextAttributes = @{};
```
