//
//  UILabel+RZColorful.m
//  RZColorfulExample
//
//  Created by 若醉 on 2018/7/6.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "UILabel+RZColorful.h"
#import "NSAttributedString+RZColorful.h"
#import "LabelFoldHelper.h"

@implementation UILabel (RZColorful)

/**
 设置富文本，原内容将清除  仅UILabel、UITextField、UITextView 有效
 
 @param attribute <#block description#>
 */
- (void )rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute {
    [self rzSetAttributedText:nil];
    [self rz_colorfulConferInsetToLocation:0 append:attribute];
}

- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer *confer))attribute {
    [self rz_colorfulConferInsetTo:rzConferInsertPositionEnd append:attribute];
}

/**
 插入文本
 
 @param position 插入的位置
 @param attribute 新的内容
 */
- (void )rz_colorfulConferInsetTo:(rzConferInsertPosition)position append:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute {
    NSUInteger location;
    switch (position) {
        case rzConferInsertPositionDefault:
        case rzConferInsertPositionCursor: { // 默认位置 光标处
            location = [self getCursorLocation];
            break;
        }
        case rzConferInsertPositionHeader: {  // 头
            location = 0;
            break;
        }
        case rzConferInsertPositionEnd: {    // 尾
            location = [self getEndLocation];
            break;
        }
        default:
            location = [self getEndLocation];
            break;
    }
    [self rz_colorfulConferInsetToLocation:location append:attribute];
}

/**
 添加到指定位置
 
 @param location <#location description#>
 @param attribute <#attribute description#>
 */
- (void )rz_colorfulConferInsetToLocation:(NSUInteger)location append:(void (^)(RZColorfulConferrer * _Nonnull))attribute {
    if(!attribute) {
        return ;
    }
    NSUInteger loc = location;
    NSAttributedString *conferrerColorful = [NSAttributedString rz_colorfulConfer:attribute];
    if (conferrerColorful.string.length == 0) {
        return ;
    }
    if (loc > [self getEndLocation]) {
        loc = [self getEndLocation];
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:[self rzAttributedString]];
    [attr insertAttributedString:conferrerColorful atIndex:loc];
    [self rzSetAttributedText:attr];
}
// 文本框的内容
- (NSAttributedString *)rzAttributedString {
    return self.attributedText;
}
// 设置文本框的内容
- (void)rzSetAttributedText:(NSAttributedString *)attributedString {
    self.attributedText = attributedString;
}
// 尾部的位置
- (NSUInteger)getEndLocation {
    return self.attributedText.string.length;;
}
// 光标的位置
- (NSUInteger)getCursorLocation {
    return self.attributedText.string.length;;
}

/// 设置富文本（超过行数后，自动追加“展开” “收起”）
/// @param attr 原文
/// @param line 最大显示行数
/// @param width 最大显示宽度，这个宽度用于计算文本行
/// @param fold 当前是否折叠
/// @param allText 超过了行数之后，折叠状态显示的文本 如”展开“  需要给文本设置rztapLabel属性  (tapActionByLable)
/// @param foldText 超过行数之后，全部展开状态显示的文本  如”收起“  需要给文本设置rztapLabel属性 (tapActionByLable)
- (void)rz_setAttributedString:(NSAttributedString *)attr maxLine:(NSInteger)line maxWidth:(CGFloat)width isFold:(BOOL)fold showAllText:(NSAttributedString *)allText showFoldText:(NSAttributedString *)foldText {
    self.numberOfLines = 0;
    if (attr == nil || attr.length == 0) {
        self.attributedText = attr;
        return;
    }
    self.attributedText = [attr rz_attributedStringBy:line maxWidth:width isFold:fold showAllText:allText showFoldText:foldText];
}

- (void)rz_tapAction:(RZLabelTapAction)tapAction {
    self.numberOfLines = 0;
    self.userInteractionEnabled = true;
    __block LabelFoldHelper *helper;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: [LabelFoldHelper class]]) {
            helper = (LabelFoldHelper *)obj;
            *stop = true;
        }
    }];
    if (helper == nil) {
        helper = [[LabelFoldHelper alloc] initWithtarget:self tapAction:tapAction];
        [self addSubview:helper];
        UIView *v1 = helper;
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self addConstraints:@[left, top, right, bottom]];
    }
}

@end
