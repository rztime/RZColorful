//
//  TextLineModeViewController.m
//  RZColorful_Example
//
//  Created by rztime on 2026/7/7.
//  Copyright © 2026 rztime. All rights reserved.
//

#import "TextLineModeViewController.h"
#import <Masonry.h>
#import <RZColorful.h>
#import <SDWebImage.h>

@interface TextLineModeViewController ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, assign) BOOL isFold;
@end

@implementation TextLineModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _stackView = [[UIStackView alloc] init];
    _stackView.alignment = UIStackViewAlignmentFill;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    _stackView.spacing = 20;
    [_scrollView addSubview:_stackView];
    [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView).inset(20);
        make.width.equalTo(@([self vwidth]));
    }];
    [self reload];
}
- (CGFloat)vwidth {
    return [UIScreen mainScreen].bounds.size.width - 40;
}
- (void)reload {
    /// demo为了方便，直接每次重新初始化，实际代码中不要这样写
    __weak typeof(self) weakSelf = self;
    [_stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.stackView removeArrangedSubview:obj];
        [obj removeFromSuperview];
    }];
    /// 系统超行的情况下默认是"...", 这里可以自定义（文本、图片）都可以，
    UILabel *label = [self label];
    [label rz_setAttributedString:[self displayText] maxLine:3 maxWidth:[self vwidth] lineBreakMode:NSLineBreakByTruncatingTail placeHolder:[self customText]];
    [_stackView addArrangedSubview:label];
    
    /// 显示折叠、展开，本质上就是判断了是否超行，然后替换这个customeText
    /// 超行显示收起或者显示全文，变的只是isFold
    /// 1.未超行的情况下，全部显示
    UILabel *label1 = [self label];
    [label1 rz_setAttributedString:[self displayText] maxLine:10 maxWidth:[self vwidth] isFold:isFold showAllText:[self showAllText] showFoldText:[self foldText]];
    [_stackView addArrangedSubview:label1];
    
    /// 2 超行的情况下，有展开和收起
    UILabel *label2 = [self label];
    [label2 rz_setAttributedString:[self displayText] maxLine:3 maxWidth:[self vwidth] isFold:isFold showAllText:[self showAllText] showFoldText:[self foldText]];
    [_stackView addArrangedSubview:label2];
    
    /// 3 UITextView也支持，但宽度需要减去两侧的边距
    UITextView *tv = [[UITextView alloc] init];
    tv.editable = NO;
    tv.scrollEnabled = NO;
    CGFloat p = tv.textContainerInset.left + tv.textContainerInset.right + 2 * tv.textContainer.lineFragmentPadding;
    [tv rz_setAttributedString:[self displayText] maxLine:3 maxWidth:([self vwidth] - p) isFold:isFold showAllText:[self showAllText] showFoldText:[self foldText]];
    [_stackView addArrangedSubview:tv];
    [tv rz_tapAction:^(id  _Nullable sender, NSString * _Nonnull actionId, NSRange range) {
        NSLog(@"%@", actionId);
        if ([actionId isEqual: @"...显示全文"]) {
            isFold = NO;
        } else if ([actionId isEqual: @"收起"]) {
            isFold = YES;
        }
        [weakSelf reload];
    }];
}
- (NSAttributedString *)showAllText {
    return [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"...显示全文").font([UIFont systemFontOfSize:17]).textColor([UIColor redColor]).tapAction(@"...显示全文");
    }];
}
- (NSAttributedString *)foldText {
    return [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"收起").font([UIFont systemFontOfSize:17]).textColor([UIColor redColor]).tapAction(@"收起");
    }];
}
- (NSAttributedString *)customText {
    /// 截断时，填充内容, 可以是图片、文本、view等等
    return [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"---").font([UIFont systemFontOfSize:17]).textColor([UIColor greenColor]);
        confer.image([UIImage imageNamed:@"image"]).size(CGSizeMake(0, 20), RZHorizontalAlignCenter, [UIFont systemFontOfSize:17]);
    }];
}
- (NSAttributedString *)displayText {
    return [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"展开或者折叠功能，需要设置maxLines，以及maxWidth，用于计算最终会显示多少行，如果行数未超过，则直接完全显示，如果行数超过了，则根据isFold属性，判断是展开是还是折叠").font([UIFont systemFontOfSize:17]).textColor([UIColor blackColor]);
    }];
}
BOOL isFold = YES;

- (UILabel *)label {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    __weak typeof(self) weakSelf = self;
    [label rz_tapAction:^(id  _Nullable sender, NSString * _Nonnull actionId, NSRange range) {
        NSLog(@"%@", actionId);
        if ([actionId isEqual: @"...显示全文"]) {
            isFold = NO;
        } else if ([actionId isEqual: @"收起"]) {
            isFold = YES;
        }
        [weakSelf reload];
    }];
    return label;
}

@end

