//
//  MDToHtmlViewController.m
//  RZColorful_Example
//
//  Created by rztime on 2025/3/14.
//  Copyright © 2025 rztime. All rights reserved.
//

#import "MDToHtmlViewController.h"
#import <WebKit/WKWebView.h>
#import "RZColorful.h"
@interface MDToHtmlViewController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation MDToHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    NSString * text = @"## 关于RZColorful\n\
* 对NSAttributeString的初始化做支持\n\
* 支持UILabel、UITextView、UITextField的attributedText的设置。\n\
* 包含的属性快捷设置：\n\
    * 段落样式\n\
    * 阴影\n\
    * 文本字体、颜色\n\
    * 文本所在区域对应的背景颜色\n\
    * 连体字\n\
    * 字间距\n\
    * 删除线、下划线，及其线条颜色\n\
    * 描边，及其颜色\n\
    * 斜体字\n\
    * 拉伸\n\
    * 通过html源码加载富文本\n\
    * 通过url添加图片到富文本\n\
    * 等等\n\
\n\
示例代码：\n\
\n\
\n\
```swift\n\
text.rz.colorfulConfer { (confer) in \n\
    confer.paragraphStyle?.lineSpacing(10).paragraphSpacingBefore(15)\n\
    confer.image(UIImage.init(named: \"indexMore\"))?.bounds(CGRect.init(x: 0, y: 0, width: 20, height: 20))\n\
    confer.text(\"  姓名 : \")?.font(UIFont.systemFont(ofSize: 15)).textColor(.gray)\n\
    confer.text(\"rztime\")?.font(UIFont.systemFont(ofSize: 15)).textColor(.black)\n\
}\n\
```\n\
    ";
    NSString *md = text;
    NSString *html = [MarkdownRZ parse:md];
    /// 解析md后的html，没有任何的样式，需要自行组装head里style：颜色、字号、列表、代码等等）
    [_webView loadHTMLString:[self mdcss:html] baseURL:nil];
}

- (NSString *)mdcss:(NSString *)html {
    return [[NSString alloc] initWithFormat: @"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\
    <html>\
        <head>\
            <meta http-equiv=\"Content-Typ\e\" content=\"text/html; charset=utf-8\">\
            <meta http-equiv=\"Content-Style-Type\" content=\"text/css\">\
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
            <style>\
                body {\
                    font-size: 16px; /* 16号字体 */\
                }\
                table {\
                    border-collapse: collapse; /* 合并边框 */\
                    border: 1px solid #dddddd; /* 表格边框颜色和宽度 */\
                }\
        /* 为单元格设置边框颜色 */\
                th, td {\
                    border: 1px solid #dddddd; /* 单元格边框颜色和宽度 */\
                    padding: 8px; /* 单元格内边距 */\
                    text-align: left; /* 文本居中 */\
                }\
                /* 块级代码样式 */\
                pre {\
                    background-color: #f8f8f8; /* 浅灰色背景 */\
                    padding: 10px; /* 内边距 */\
                    border-radius: 5px; /* 圆角边框 */\
                    border: 1px solid #ddd; /* 浅灰色边框 */\
                    overflow-x: auto; /* 水平滚动条 */\
                    white-space: pre-wrap; /* 自动换行 */\
                }\
            </style>\
        </head>\
        <body>\
            %@\
        </body>\
    </html>\
    ", html];
}
@end
