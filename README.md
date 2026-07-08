# RZColorful

[![CI Status](https://img.shields.io/travis/rztime/RZColorful.svg?style=flat)](https://travis-ci.org/rztime/RZColorful)
[![Version](https://img.shields.io/cocoapods/v/RZColorful.svg?style=flat)](https://cocoapods.org/pods/RZColorful)
[![License](https://img.shields.io/cocoapods/l/RZColorful.svg?style=flat)](https://cocoapods.org/pods/RZColorful)
[![Platform](https://img.shields.io/cocoapods/p/RZColorful.svg?style=flat)](https://cocoapods.org/pods/RZColorful)


iOS NSAttributedString 富文本方法 (图文混排、多样式文本); 
文本超行，可自动添加"折叠"、"全部"; 
markdown 转 html;
UILabel、UITextView支持显示gif、给文本添加背景图、文本支持点击等功能

2.0.0版本后，富文本添加的点击功能更友好，富文本的布局计算更高效


## Installation

RZColorful is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RZColorful'
```

## Author

rztime, rztime@vip.qq.com QQ群：580839749

### swift版本看这里[RZColorfulSwift](https://github.com/rztime/RZColorfulSwift)

## License

RZColorful is available under the MIT license. See the LICENSE file for more info.


## 更新日志
[更新日志](https://github.com/rztime/RZColorful/blob/master/UpdateLog.md)

UITextView实现的富文本编辑器[RZRichTextView](https://github.com/rztime/RZRichTextView)

* NSAttributedString 的多样化设置(文字字体、颜色、阴影、段落样式、url、下划线，以及图文混排、显示gif，backgroundView，文本点击等等)
* 添加UITextField、UITextView、UILabel的attributedText的富文本设置。


## 关于RZColorful
* 对NSAttributeString的初始化做支持
* 支持 markdown 文档转换为html
* 支持 HTML 与 NSAttributedString互换
* 支持UILabel、UITextView、UITextField的attributedText的设置。
* 包含的属性设置：
    * 段落样式
    * 阴影
    * 文本字体、颜色
    * 文本所在区域对应的背景颜色
    * 连体字
    * 字间距
    * 删除线、下划线，及其线条颜色
    * 描边，及其颜色
    * 斜体字
    * 上标 下标
    * 拉伸
    * 链接
    * 通过html源码加载富文本
    * 通过url添加图片到富文本
    * 添加自定义view，可用于显示gif、自定义标签等等
    * 添加backgroundView，在文本背后的位置显示view
    * 文本、图片、自定义view的点击事件
    * 等等

## How to use

* 主要的功能：
    * RZColorfulConferrer 
        * text                              -- 添加文本
        * htmlText                          -- 添加html源码
        * image                             -- 添加图片 
        * imageByUrl                        -- 添加图片（通过图片的URL添加）
        * view                              -- 添加自定义view，gif可以用此方法
        * paragraphStyle                    -- 全局的段落样式
        * shadow                            -- 全局的阴影样式
        
    * RZColorfulAttribute           -- 设置文本的所有的属性
    * RZImageAttachment         -- 设置图片的所有的属性

### 基本方法（UILabel和UITextView用法一样）
```objc
    [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.paragraphStyle.paragraphSpacing(15); // 设置段落之间的行距

        confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, -2, 15, 15)); // 图片
        confer.text(@" 姓名: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11));
        confer.text(@"rztime").font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
    }];
```

### 进阶用法（UILabel和UITextView用法一样）

* 点击、自定义view、backgroundView等等
```objc
    // 如果不实现label rz_tapAction方法，则需要调用label activeColorful方法,否则clicked、backgroundView、自定义view将无法实现
    [_label rz_tapAction:^(id  _Nullable sender, NSString * _Nonnull actionId, NSRange range) {
        NSLog(@"---label:\(%@)", actionId);
    }];
    NSAttributedString * attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"<隐私政策>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).tapAction(@"<隐私政策>");
        confer.text(@"<使用说明>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).clicked( ^(id sender, NSRange range) {
            NSLog(@"<使用说明>");
        });
        
        // 添加自定义view，可以显示gif的UIImageView，view可以自行实现点击事件，也可以在后边添加tapAction或者clicked
        confer.view([self gifView]).size(CGSizeMake(200, 100), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]);
        
        // 给文本添加背景图，可以自行实现点击事件，也可以在后边添加tapAction或者clicked
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
    }];
    _label.attributedText = attr;
    
```

* 自定义截断内容

```objc
    // 系统默认超行时显示"..."，这可以使用自定义的内容去替换"..."
    [label rz_setAttributedString:[self displayText] maxLine:3 maxWidth:[self vwidth] lineBreakMode:NSLineBreakByTruncatingTail placeHolder:[self customText]];
```

* 超行时 折叠 展开

```objc
    __weak typeof(self) weakSelf = self;
    [label rz_tapAction:^(id  _Nullable sender, NSString * _Nonnull actionId, NSRange range) {
        NSLog(@"%@", actionId);
        if ([actionId isEqual: @"...显示全文"]) {
            isFold = NO;
        } else if ([actionId isEqual: @"收起"]) {
            isFold = YES;
        }
        // 刷新
        ...
    }];
    [label2 rz_setAttributedString:[self displayText] maxLine:3 maxWidth:[self vwidth] isFold:isFold showAllText:[self showAllText] showFoldText:[self foldText]];
```


### NSAttributedString 转 HTML 行内样式的方法

可以参考[RZRichTextView](https://github.com/rztime/RZRichTextView)里[code2Html](https://github.com/rztime/RZRichTextView/blob/master/RZRichTextView/Classes/RZHtml.swift)方法

## 注意

* 尽管我已经在代码中已经处理过（弱）引用问题，但是在实际运用写入text时，还是请尽量检查避免循环引用


## 最后
* 在使用过程中，如果您发现有什么问题，欢迎向我反馈，谢谢
