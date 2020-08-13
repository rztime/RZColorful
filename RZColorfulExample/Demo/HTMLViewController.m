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
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGRect frame1 = self.view.bounds;
    frame1.size.height  = frame1.size.height / 3.0;
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc] initWithFrame:frame1];
    [self.view addSubview:self.textView];
    [self.textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli完整的测试 fli").font([UIFont systemFontOfSize:18]).textColor(UIColor.redColor).strikeThrough(1).strikeThroughColor(UIColor.greenColor);
    }];
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    NSString *html = self.textView.attributedText.rz_codingToCompleteHtml;
    NSString *t = [self.textView.attributedText rz_codingToCompleteHtmlByWeb];
     
    CGRect frame2 = self.view.bounds;
    frame2.origin.y = frame2.size.height / 3.0;
    frame2.size.height  = frame2.size.height / 3.0;
    self.webView = [[UIWebView alloc] initWithFrame:frame2];
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:t baseURL:nil];

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
//    NSURL* url = [NSURL  fileURLWithPath:path];//创建URL
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
//    [self.webView loadRequest:request];//加载
    
    CGRect frame3 = self.view.bounds;
    frame3.origin.y = frame3.size.height / 3.0 * 2;
    frame3.size.height  = frame3.size.height / 3.0;
    self.textView2 = [[UITextView alloc] initWithFrame:frame3];
    [self.view addSubview:self.textView2];

    [self.textView2 rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.htmlText(t);
    }];
    self.textView2.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.textView2 setEditable:false];
    self.textView2.rzDidTapTextView = ^BOOL(id  _Nullable tapObj) {
        return true;
    };
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
