//
//  BaseUseViewController.m
//  RZColorful_Example
//
//  Created by rztime on 2026/7/7.
//  Copyright © 2026 rztime. All rights reserved.
//

#import "BaseUseViewController.h"
#import <Masonry.h>
#import <RZColorful.h>
#import <SDWebImage.h>

@interface BaseUseViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation BaseUseViewController

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
    [self.textView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3]];
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
        /// 全局配置 paragraphStyle、shadow
        confer.paragraphStyle.lineSpacing(5).paragraphSpacingBefore(5);
        confer.shadow.color([[UIColor blackColor] colorWithAlphaComponent:0.5]).offset(CGSizeMake(1, 1)).radius(3);
        
        confer.text(@"可配置多种内容和属性:\n").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        
        confer.text(@"添加内容：text(文字)、image(图片)、imageByUrl(链接、本地图片路径)、htmlString()、view(添加自定义view),可直接在后面连接font、textColor等属性的配置，具体可看AttributeKeyRZ").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);

        confer.text(@"\n1: paragraphStyle\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"单独的段落样式：具体可以进入paragraphStyle查看").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).paragraphStyle.lineSpacing(2);
        
        confer.text(@"\n2: shadow\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"单独的阴影样式：具体可以进入shadow查看").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).shadow.color([[UIColor redColor] colorWithAlphaComponent:0.5]).offset(CGSizeMake(1, 1)).radius(3);
        
        confer.text(@"\n3: shadow 和 paragraphStyle\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"单独的阴影、段落样式可用and连接").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).shadow.color([[UIColor redColor] colorWithAlphaComponent:0.5]).offset(CGSizeMake(1, 1)).radius(3).and.paragraphStyle.lineSpacing(2);
    
        confer.text(@"\n4: font textColor\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"字体的字号、颜色").font([UIFont systemFontOfSize:16]).textColor([UIColor brownColor]);
        
        confer.text(@"\n5: backgroundColor\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"字体的背景色").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).backgroundColor([UIColor lightGrayColor]);
        
        confer.text(@"\n6: strikethroughStyle strikethroughColor\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"删除线").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).strikeThrough(NSUnderlineStyleSingle).strikeThroughColor([UIColor brownColor]);
        
        confer.text(@"\n7: underlineStyle underlineColor\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"下划线").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).underLineStyle(NSUnderlineStyleSingle).underLineColor([UIColor brownColor]);
        
        confer.text(@"\n8: strokeWidth strokeColor\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"描边(负值填充)").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).strokeWidth(@(-1)).strokeColor([UIColor brownColor]);
        confer.text(@"    描边(正直中空)").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).strokeWidth(@(1)).strokeColor([UIColor brownColor]);
        confer.text(@"    描边(3空心)").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).strokeWidth(@(3)).strokeColor([UIColor brownColor]);
        
        confer.text(@"\n9: obliqueness\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"斜体").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).italic(@0.4);
        
        confer.text(@"\n10: kern\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"字间距").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).wordSpace(@10);
        
        confer.text(@"\n11: baselineOffset\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"上标").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"2").font([UIFont systemFontOfSize:11]).textColor([UIColor blackColor]).baselineOffset(@8);
        confer.text(@"、下标").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"2").font([UIFont systemFontOfSize:11]).textColor([UIColor blackColor]).baselineOffset(@-5);
        
        confer.text(@"\n12: expansion\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"拉伸(>0)    ").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).expansion(@0.5);
        confer.text(@"压缩(<0)").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]).expansion(@-0.2);
        
        confer.text(@"\n13: link\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"百度一下，你就知道").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).url([[NSURL alloc] initWithString:@"https://www.baidu.com"]);
        
        confer.text(@"\n14 添加图片(两种方式)，以及对齐方式 image imageByUrl:\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.image([UIImage imageNamed:@"image"]).size(CGSizeMake(30, 0), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]).tapAction(@"图片点击");
        confer.text(@"（居中）参考对齐文本\n").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Html.bundle/html_placeholder_gif" ofType:@"gif"];
        confer.imageByUrl(path).size(CGSizeMake(30, 0), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]).clicked ( ^(id sender, NSRange range) {
            NSLog(@"点击了图片%@", NSStringFromRange(range));
        });
        confer.text(@"（居下）参考对齐文本").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        
        confer.text(@"\n15 添加自定义视图（如需gif，则可以自定义设置）view:\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.view([self gifView]).size(CGSizeMake(200, 100), RZHorizontalAlignCenter, [UIFont systemFontOfSize:16]);
        
        confer.text(@"\n16: backgroundView\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"给内容添加背景view, 多行的时候, 会有多个rects,frame即为文本所占的位置，包含了行间距，可以自行调整size，来调优显示").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]).tapAction(@"点击背景").backgroundView( ^(NSArray<NSValue *> *rects) {
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
        
        confer.text(@"\n17 将html转为富文本: htmlString\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.htmlText(@"<p style='color: green;font-size: 18px;'>我区紧密型县域医共体建设取得阶段性成效…</p>");
        
        confer.text(@"\n18 添加文本可点击的功能: tapAction\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"<隐私政策>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).tapAction(@"<隐私政策>");
        confer.text(@"和").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"<使用说明>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).tapAction(@"<使用说明>");
       
        confer.text(@"\n19 添加文本可点击的功能: clicked\n").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"<隐私政策>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).clicked( ^(id sender, NSRange range) {
            NSLog(@"---range: <隐私政策> \(%@)", NSStringFromRange(range));
        });
        confer.text(@"和").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"<使用说明>").font([UIFont systemFontOfSize:16]).textColor([UIColor blueColor]).clicked( ^(id sender, NSRange range) {
            NSLog(@"---range: <使用说明> \(%@)", NSStringFromRange(range));
        });
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
