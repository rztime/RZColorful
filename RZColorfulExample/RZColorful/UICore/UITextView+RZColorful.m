//
//  UITextView+RZColorful.m
//  RZColorfulExample
//
//  Created by 若醉 on 2018/7/6.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "UITextView+RZColorful.h"
#import "NSAttributedString+RZColorful.h"
#import "RZTapActionHelper.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, strong) RZTapActionHelper *helper;

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
    if (conferrerColorful.hadTapAction) {
        if (!self.helper) {
            RZTapActionHelper *helper = [[RZTapActionHelper alloc] init];
            helper.textView = self;
            helper.tagert = self.delegate;
            self.helper = helper;
        }
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

- (void)setHelper:(RZTapActionHelper *)helper {
    objc_setAssociatedObject(self, @"rzweakHelper", helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RZTapActionHelper *)helper {
    return objc_getAssociatedObject(self, @"rzweakHelper");
}

- (void)setRzDidTapTextView:(void (^)(id __nullable))rzDidTapTextView {
    objc_setAssociatedObject(self, @"rzDidTapTextView", rzDidTapTextView, OBJC_ASSOCIATION_COPY);
}
- (void (^)(id __nullable))rzDidTapTextView {
    return objc_getAssociatedObject(self, @"rzDidTapTextView");
}
@end
