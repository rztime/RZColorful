##### 2.0.0

此次进行了大更新，统一了UILabel和UITextView关于富文本的用法，不需要区分了


```
1.以前的 tapAction(), tapActionByLable() 不在区分UILabel或者UITextView, 
仅保留tapAction(), 与link() 的区别是link添加的url，会使文本为蓝色+下划线
原key：NSTapActionByLabelAttributeName删除，替换改为key：RZTapActionAttributeName
```

```
2.UITextView的rzDidTapTextView方法删掉，替换为与UILabel一样的rz_tapAction;
```

```
3.新增confer.view()方法，可以添加自定义的view，本质是添加的NSAttachment,最终将自定义view显示在UILabel或者UITextView对应的位置上，实现了gif、自定义标签等功能
confer.view([self gifView]).size(CGSizeMake(200, 100), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]);
```

```
4.新增backgroundView(), 可以用于对文本添加背景视图，设置圆角，背景图等等
confer.text(@"hello").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]).tapAction(@"点击背景").backgroundView( ^(NSArray<NSValue *> *rects) {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    [rects enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = obj.CGRectValue;
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0.3;
        view.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 21);
        [views addObject:view];
        /// 如果UIView.isUserInteractionEnabled = true, 则将不会触发tapAction，link，clicked等事件
        view.userInteractionEnabled = false;
    }];
    return views.copy;
});
```

```
5.新增clicked()方法，可直接用block来处理文本、图片、backgroundView的点击事件
confer.text(@"hello").clicked( ^(id sender, NSRange range) {
    
});
```

```
新增RZTextLayout，用于计算富文本的相关信息
```
本次更新后，解决了UILabel在加载了大量可点击文本时，导致的hitTest方法耗时卡顿的问题

##### 1.7.0

新增了markdown文档转换为html的方法
```
// 1.初始化(可以提前初始化，用于下载最新的js解析方法)  
[MarkdownRZ asyncInit:3];
// 2.解析 解析md后的html，没有任何的样式，需要自行组装head里style：颜色、字号、列表、代码等等）
NSString *html = [MarkdownRZ parse:md];
```

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
