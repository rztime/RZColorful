//
//  HTMLViewController.m
//  RZColorful_Example
//
//  Created by rztime on 2026/7/7.
//  Copyright © 2026 rztime. All rights reserved.
//

#import "HTMLViewController.h"
#import <Masonry.h>
#import <RZColorful.h>
#import <SDWebImage.h>

@interface HTMLViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    UILabel *l1 = [[UILabel alloc] init];
    l1.text = @"UILabel:";
    [self.scrollView addSubview:l1];
    
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    [self.scrollView addSubview:self.label];
    [self.label activeColorful:true];
    [self.label rz_tapAction:^(id  _Nullable sender, NSString * _Nonnull actionId, NSRange range) {
        NSLog(@"---label:\(%@)", actionId);
    }];
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.text = @"UITextView:";
    [self.scrollView addSubview:l2];
    self.textView = [[UITextView alloc] init];
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    [self.scrollView addSubview:self.textView];
    [self.textView activeColorful:true];
    [self.textView rz_tapAction:^(id  _Nullable sender, NSString * _Nonnull actionId, NSRange range) {
        NSLog(@"---textView:\(%@)", actionId);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 40;
    [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.scrollView).inset(20);
        make.width.equalTo(@(w));
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView).inset(20);
        make.top.equalTo(l1.mas_bottom).offset(10);
        make.width.equalTo(@(w));
    }];
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView).inset(20);
        make.top.equalTo(self.label.mas_bottom).offset(20);
        make.width.equalTo(@(w));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.scrollView).inset(20);
        make.width.equalTo(@(w));
        make.top.equalTo(l2.mas_bottom).offset(10);
    }];
    /// 需要注意，html里的字体，必须存在，否则无法正确计算
    [self.label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.htmlText([self html]).font([UIFont systemFontOfSize:16]);
    }];
    [self.textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.htmlText([self html]).font([UIFont systemFontOfSize:16]);
    }];
}
- (NSString *)html {
    return @"<p style='color:red;'>html内容html内容html内容html内容html内容html内容</p><p style='color:blue;'>html内容html内容html内容html内容html内容html内容</p><p>html内容html内容html内容html内容html内容html内容</p><p>html内容html内容<a href='http://www.baidu.com'>百度一下</a>html内容html内容html内容</p><p>html内容html内容html内容html内容html内容html内容</p><p>html内容html内容html内容html内容html内容html内容</p><p>html内容html内容html内容html内容html内容html内容</p>";
}

@end
