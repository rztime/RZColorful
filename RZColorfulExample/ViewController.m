//
//  ViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "ViewController.h"
#import "RZColorful.h"

#define rzFont(font) [UIFont systemFontOfSize:font]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define GRAY(c) RGBA(c, c, c, 1)
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"富文本的简单使用";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:0 target:self action:@selector(toNextVc)];
    
    
    UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
    textView.delegate = self;
    textView.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 528);
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor redColor].CGColor;
    textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath =[resourcePath stringByAppendingPathComponent:@"test.html"];
    NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
#pragma mark - 全局样式  包含 paragraphStyle shadow 此时不能使用and等连接词，需单独设置，在此block中任意位置设置即可
        // 全局样式 如 paragraphStyle
//        confer.paragraphStyle.lineSpacing(4).paragraphSpacingBefore(10); 属性很多，查看 RZParagraphStyle
//        confer.paragraphStyle.lineSpacing(4).paragraphSpacingBefore(10).paragraphSpacing(10).alignment(NSTextAlignmentCenter).firstLineHeadIndent(4).headIndent(4).tailIndent(4).lineBreakMode(NSLineBreakByTruncatingTail).maximumLineHeight(15).minimumLineHeight(4).baseWritingDirection(NSWritingDirectionLeftToRight).lineHeightMultiple(1.5);
        
        // shadow
//        confer.shadow.color(RGBA(255, 0, 0, 1)).radius(5).offset(CGSizeMake(5, 5));
        
#pragma mark - 文字设置 文字包含 text()、htmlText（）
        // 仅仅是string时，两个方法都可，text()更优，如果是html源码富文本，用htmlText（）才有效
//        confer.text(@"在代码中，text() 和 htmlText()都可以直接传入string字符串\n\n");
//        confer.text(@"如果是html富文本标签内容，需要使用htmlText()\n");
//        confer.htmlText(htmlstring);
//        
#pragma mark - 文字属性 包含文字属性、段落属性、阴影属性，连接使用and等,
//        confer.text(@"\n\n");
//        confer.text(@"文字的属性连接使用, 使用and连接回到 text()/htmlText(),将可继续连接其他的属性").font(rzFont(20)).textColor([UIColor blueColor]).paragraphStyle.lineSpacing(20).and.shadow.color([UIColor redColor]).and.paragraphStyle.paragraphSpacing(20);
        
        
#pragma mark - 图片设置 appendImage()、appendImageByUrl()
//        confer.text(@"\n");
//        confer.appendImage([UIImage imageNamed:@"test.jpg"]).paragraphStyle.alignment(NSTextAlignmentCenter).andAttach.bounds(CGRectMake(0, 0, 50, 50));
//        confer.text(@"\n");
//        confer.text(@"在appendImage中使用andAttach连接词回到appendImage()来\n").font(rzFont(20));
//        confer.appendImageByUrl(@"http://pic28.photophoto.cn/20130830/0005018667531249_b.jpg").bounds(CGRectMake(0, 0, 50, 50)).paragraphStyle.alignment(NSTextAlignmentRight);
        
//        confer.text(@"点击事件").font(rzFont(18))setAction:^(id actionId) {
//
//        };
        [confer.text(@"点击事件1").font(rzFont(18)) tapAction:@"111" handle:^(id actionId) {
            NSLog(@"%@     11111111111实现了", actionId);
        }];
        confer.text(@"\n");
        [confer.text(@"点击事件2").font(rzFont(18)) tapAction:@"222" handle:^(id actionId) {
            NSLog(@"%@     2222222实现了", actionId);
        }];
        confer.text(@"\n");
        [confer.text(@"点击事件3").font(rzFont(18)) tapAction:@"333" handle:nil].textColor(RGBA(255, 0, 0, 1));
    }];
    textView.linkTextAttributes = @{};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"URL:%@", URL);
    return NO;
}

- (void)toNextVc {
    ViewController *vc = [ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
