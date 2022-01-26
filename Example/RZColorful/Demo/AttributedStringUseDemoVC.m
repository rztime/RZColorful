//
//  AttributedStringUseDemoVC.m
//  RZColorful_Example
//
//  Created by rztime on 2022/1/25.
//  Copyright © 2022 rztime. All rights reserved.
//

#import "AttributedStringUseDemoVC.h"
#import <RZColorful.h>

@interface AttributedStringUseDemoVC ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation AttributedStringUseDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    [self.view addSubview:_label];
    _label.frame = self.view.bounds;
    NSAttributedString *attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.htmlText(@"<span style=\"background-color: red;\">标签富文本</br></span>").font([UIFont systemFontOfSize:16]);
        confer.text(@"\n正文使用方法:常规 字体 + 颜色\n\n").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor);
        
        confer.text(@"添加本地图片 ").font([UIFont systemFontOfSize:20]).textColor(UIColor.redColor);
        confer.image([UIImage imageNamed:@"image"]).size(CGSizeMake(40, 40), RZHorizontalAlignCenter, [UIFont systemFontOfSize:20]).tapActionByLable(@"2"); // 点击事件
        confer.text(@"  ");
        confer.image([UIImage imageNamed:@"image"]).size(CGSizeMake(40, 40), RZHorizontalAlignCenter, [UIFont systemFontOfSize:20]).custom(NSTapActionByLabelAttributeName, @"3"); // 自定义点击事件
        confer.text(@" 图片可对齐文本\n\n").font([UIFont systemFontOfSize:20]).textColor(UIColor.redColor);
        
        confer.text(@"\n正文使用方法:斜体").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor).italic(@1);
        confer.text(@"\n正文使用方法:删除线").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor).strikeThrough(NSUnderlineStyleSingle).strikeThroughColor(UIColor.redColor);
        confer.text(@"\n正文使用方法:下划线").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor).underLineStyle(NSUnderlineStyleSingle).underLineColor(UIColor.redColor);
        confer.text(@"\n正文使用方法:描边\n").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor).strokeWidth(@1).strokeColor(UIColor.redColor);
        confer.text(@"正文使用方法:背景色").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor).backgroundColor(UIColor.lightGrayColor);
        confer.text(@"\n文本的点击事件").font([UIFont systemFontOfSize:16]);
        confer.text(@"可点击文本").textColor(UIColor.redColor).font([UIFont systemFontOfSize:16]).tapActionByLable(@"点击的id");
        confer.text(@"\n");
        confer.text(@"段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置\n段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置段落样式的方法设置\n").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor).paragraphStyle.lineSpacing(20).paragraphSpacingBefore(10);
    }];
    _label.attributedText = attr;
    [_label rz_tapAction:^(UILabel * _Nonnull label, NSString * _Nonnull tapActionId, NSRange range) {
        NSLog(@"%@", tapActionId); // print: 点击的id
    }];
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
