//
//  HTMLViewController.m
//  RZColorfulExample
//
//  Created by rztime on 2020/8/5.
//  Copyright © 2020 rztime. All rights reserved.
//

#import "HTMLViewController.h"
#import "RZColorful.h"

@interface HTMLViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITextView *textView2;
@end

@implementation HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame1 = self.view.bounds;
    frame1.size.height  = frame1.size.height / 2.0;
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc] initWithFrame:frame1];
    [self.view addSubview:self.textView];
    [self.textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"按实际地方拉卡视角").textColor(UIColor.redColor).font([UIFont systemFontOfSize:18]).italic(@1);
        confer.text(@"按实际地方拉卡视角按实际地方拉卡视角按实际地方拉卡视角按实际地方拉卡视角").textColor(UIColor.redColor).font([UIFont systemFontOfSize:12]);
        confer.text(@"按实际地方拉卡视角按实际地方拉卡视角按实际地方拉卡视角按实际地方拉卡视角").textColor(UIColor.blueColor).font([UIFont systemFontOfSize:10]);
        confer.text(@"按实际地方拉卡视角按实际地方拉卡视角按实际地方拉卡视角按实际地方拉卡视角").textColor(UIColor.greenColor).font([UIFont systemFontOfSize:11]).strikeThrough(1).strikeThroughColor(UIColor.blueColor).tapAction(@"123");
        confer.text(@"\n丸子发卡方阿斯蒂芬阿斯蒂芬").textColor(UIColor.redColor).font([UIFont systemFontOfSize:28]);
    }];
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.textView setEditable:false]; 
    NSString *html = self.textView.attributedText.rz_codingToCompleteHtml;
 
    NSLog(@"%@", html);
//    html = [html stringByReplacingOccurrencesOfString:@"color: rgba(0, 0, 0, 0)" withString:@"color: rgba(255, 0, 0, 0.5)"];
//    html = [html stringByReplacingOccurrencesOfString:@"-webkit-text-stroke: #ff0000" withString:@"-webkit-text-stroke: 1.5px #ff0000"];

//    html = [html stringByReplacingOccurrencesOfString:@"font-size: 18.00px" withString:@"font-size: 18.00px; -webkit-transform:skew(60deg);"];


    CGRect frame2 = self.view.bounds;
    frame2.origin.y = frame2.size.height / 2.0;
    frame2.size.height  = frame2.size.height / 2.0;
    self.webView = [[UIWebView alloc] initWithFrame:frame2];
    [self.view addSubview:self.webView];
//    [self.webView loadHTMLString:html baseURL:nil];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL* url = [NSURL  fileURLWithPath:path];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
    
//    CGRect frame3 = self.view.bounds;
//    frame3.origin.y = frame3.size.height / 2.0;
//    frame3.size.height  = frame3.size.height / 2.0;
//    self.textView2 = [[UITextView alloc] initWithFrame:frame3];
//    [self.view addSubview:self.textView2];
//
//    [self.textView2 rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
////        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
////        NSString *filePath =[resourcePath stringByAppendingPathComponent:@"test.html"];
////        NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
////        confer.htmlText(htmlstring);
//        confer.htmlText(html);
//
//    }];
//    self.textView2.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.textView2 setEditable:false];
//    self.textView2.rzDidTapTextView = ^BOOL(id  _Nullable tapObj) {
//        return true;
//    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
