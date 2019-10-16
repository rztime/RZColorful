1.2.4更新日志

1.新增图片的size设置方式 并可参照前后文本字体进行对齐，并在某些情况下做y轴偏移 （对齐中文效果较好，英文会有偏差）
```
	confer.appendImage([UIImage imageNamed:@"image"]).size(CGSizeMake(32, 32), RZHorizontalAlignBottom, rzFont(16)).yOffset(10);
```


2.新增图片、文本、html的点击事件 .tapAction(@"1") 只对UITextView有效
```
	confer.appendImage([UIImage imageNamed:@"image"]).size(CGSizeMake(32, 32), RZHorizontalAlignBottom, rzFont(16)).tapAction(@"22222222");

	confer.text(@"点击事件1").font(rzFont(30)).tapAction(@"1").textColor(UIColor.orangeColor);

	confer.htmlText(htmlstring); // 此自动实现tapAction方法
```
需要实现UITextView的rzDidTapTextView方法
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
