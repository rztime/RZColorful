//
//  TextClickViewController.m
//  RZColorful_Example
//
//  Created by rztime on 2026/7/7.
//  Copyright © 2026 rztime. All rights reserved.
//

#import "TextClickViewController.h"
#import <Masonry.h>
#import <RZColorful.h>
#import <SDWebImage.h>

@interface TextClickViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TextClickViewController

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
    /// UILabel UITextView用法一样
    self.label.attributedText = [self attr];
    self.textView.attributedText = [self attr];
}
- (NSAttributedString *)attr {
    NSAttributedString * attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"1 添加文本可点击的功能: tapAction clicked\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"<隐私政策>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).tapAction(@"<隐私政策>");
        confer.text(@"和").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"<用户协议>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).tapAction(@"<用户协议>");
        confer.text(@"和").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"<使用说明>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).clicked( ^(id sender, NSRange range) {
            NSLog(@"---range: <使用说明> \(%@)", NSStringFromRange(range));
        });
        
        confer.text(@"\n2 图片点击的功能: tapAction clicked\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.image([UIImage imageNamed:@"image"]).size(CGSizeMake(0, 30), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]).tapAction(@"点击图片");
        confer.text(@"请点击图片\n").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        
        confer.image([UIImage imageNamed:@"image"]).size(CGSizeMake(0, 30), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]).clicked( ^(id sender, NSRange range) {
            NSLog(@"---range: <点击图片> \(%@)", NSStringFromRange(range));
        });
        confer.text(@"请点击图片\n").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
    }];
    return attr;
}
- (UIView *)gifView {
    SDAnimatedImageView *imageV = [[SDAnimatedImageView alloc] initWithFrame: CGRectMake(0, 0, 20, 10)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Html.bundle/html_placeholder_gif" ofType:@"gif"];
    [imageV sd_setImageWithURL:[NSURL fileURLWithPath:path]];
//    imageV.backgroundColor = [UIColor redColor];
    return imageV;
}
@end
