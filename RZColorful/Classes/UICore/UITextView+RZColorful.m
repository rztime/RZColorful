//
//  UITextView+RZColorful.m
//  RZColorfulExample
//
//  Created by 若醉 on 2018/7/6.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "UITextView+RZColorful.h"
#import "NSAttributedString+RZColorful.h"
#import <objc/runtime.h>
#import "RZColorfulView.h"

@interface UITextView ()

@end

@implementation UITextView (RZColorful)

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
    return self.attributedText.string.length;
}
// 光标的位置
- (NSUInteger)getCursorLocation {
    return self.selectedRange.location;;
}

/// 设置富文本（超过行数后，自动追加“展开” “收起”）
/// @param attr 原文
/// @param line 最大显示行数
/// @param width 最大显示宽度，这个宽度用于计算文本行
/// @param fold 当前是否折叠
/// @param allText 超过了行数之后，折叠状态显示的文本 如”展开“  需要给文本设置rztapLabel属性  (tapActionByLable)
/// @param foldText 超过行数之后，全部展开状态显示的文本  如”收起“  需要给文本设置rztapLabel属性 (tapActionByLable)
- (void)rz_setAttributedString:(NSAttributedString *)attr maxLine:(NSInteger)line maxWidth:(CGFloat)width isFold:(BOOL)fold showAllText:(NSAttributedString *)allText showFoldText:(NSAttributedString *)foldText {
    if (attr == nil || attr.length == 0) {
        self.attributedText = attr;
        return;
    }
    self.attributedText = [attr rz_attributedStringBy:line maxWidth:width isFold:fold showAllText:allText showFoldText:foldText];
}
/// 设置富文本超行时自定义截断方式
/// @param attr 原文
/// @param line 最大行数
/// @param width 最大宽度
/// @param mode 截断方式
/// @param placeHolder 截断时占位内容 如原系统是"..."， 可改为其他自定义内容
- (void)rz_setAttributedString:(NSAttributedString * _Nullable)attr maxLine:(NSInteger)line maxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)mode placeHolder:(NSAttributedString *_Nullable)placeHolder {
    if (attr == nil || attr.length == 0) {
        self.attributedText = attr;
        return;
    }
    self.attributedText = [attr rz_attributedStringBy:line maxWidth:width lineBreakMode:mode placeHolder:placeHolder];
}
- (void)rz_tapAction:(ColorfulTapActionRZ)tapAction {
    RZColorfulView *v = [self activeColorful:true];
    v.tapAction = tapAction;
}
/// 获取range所在文本的位置
- (CGRect)rz_rectFor:(NSRange)range {
    UITextView *textView = self;
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *star = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:star offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:star toPosition:end];
    return [textView firstRectForRange:textRange];
}
/// 获取range所在文本的位置,可能涉及多行 NSValue: CGRect
- (NSArray<NSValue *> *)rz_rectFors:(NSRange)range {
    UITextView *textView = self;
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *star = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:star offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:star toPosition:end];
    NSArray<UITextSelectionRect *> *rects = [textView selectionRectsForRange:textRange];
    NSMutableArray *res = @[].mutableCopy;
    [rects enumerateObjectsUsingBlock:^(UITextSelectionRect * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [res addObject:@(obj.rect)];
    }];
    return res;
}
- (void)disableLink:(BOOL)disable {
    self.rzHelper.disableLink = disable;
}
- (void)disableAttachment:(BOOL)disable {
    self.rzHelper.disableAttachment = disable;
}

@end

@implementation RZTextViewHelper

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction API_AVAILABLE(ios(10.0)) {
    return !self.disableLink;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction API_AVAILABLE(ios(10.0)) {
    return !self.disableAttachment;
}

@end
@implementation UITextView (RZHelper)

static const char *kRZTextViewHelperKey = "kRZTextViewHelperKey";

- (RZTextViewHelper *)rzHelper {
    RZTextViewHelper *helper = objc_getAssociatedObject(self, kRZTextViewHelperKey);
    if (!helper) {
        helper = [[RZTextViewHelper alloc] init];
        self.rzHelper = helper;
    }
    return helper;
}

- (void)setRzHelper:(RZTextViewHelper *)rzHelper {
    objc_setAssociatedObject(self, kRZTextViewHelperKey, rzHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (rzHelper) {
        self.delegate = rzHelper;
    }
}

@end
