//
//  UIView+RZColorful.m
//  RZColorfulExample
//
//  Created by rztime on 2017/11/16.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "UIView+RZColorful.h"
#import "NSAttributedString+RZColorful.h"
#import "UITextField+SelectedRange.h"

@implementation UIView (RZColorful)

/**
 是否是有效文本框

 @return YES
 */
- (BOOL)rzIsValidView {
    if ([self isKindOfClass:[UITextView class]] || [self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UILabel class]]) {
        return YES;
    }
    return NO;
}

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
    if (![self rzIsValidView]) {
        return;
    }
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
    if (![self rzIsValidView]) {
        return;
    }
    __block NSUInteger loc = location;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSAttributedString *conferrerColorful = [NSAttributedString rz_colorfulConfer:attribute];
        if (conferrerColorful.string.length == 0) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (loc > [self getEndLocation]) {
                loc = [self getEndLocation];
            }
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:[self rzAttributedString]];
            [attr insertAttributedString:conferrerColorful atIndex:loc];
            [self rzSetAttributedText:attr];
        });
    });
}
// 文本框的内容
- (NSAttributedString *)rzAttributedString {
    if ([self isKindOfClass:[UITextView class]]) {
        return ((UITextView *)self).attributedText;
    }
    if ([self isKindOfClass:[UITextField class]]) {
        return ((UITextField *)self).attributedText;
    }
    if ([self isKindOfClass:[UILabel class]]) {
        return ((UILabel *)self).attributedText;
    }
    return nil;
}
// 设置文本框的内容
- (void)rzSetAttributedText:(NSAttributedString *)attributedString {
    if ([self isKindOfClass:[UITextView class]]) {
        ((UITextView *)self).attributedText = attributedString;
    } else if ([self isKindOfClass:[UITextField class]]) {
        ((UITextField *)self).attributedText = attributedString;
    }else if ([self isKindOfClass:[UILabel class]]) {
        ((UILabel *)self).attributedText = attributedString;
    }
}
// 尾部的位置
- (NSUInteger)getEndLocation {
    if ([self isKindOfClass:[UITextView class]]) {
        return ((UITextView *)self).attributedText.string.length;
    }
    if ([self isKindOfClass:[UITextField class]]) {
        return ((UITextField *)self).attributedText.string.length;
    }
    if ([self isKindOfClass:[UILabel class]]) {
        return ((UILabel *)self).attributedText.string.length;
    }
    return 0;
}
// 光标的位置
- (NSUInteger)getCursorLocation {
    if ([self isKindOfClass:[UITextView class]]) {
        return ((UITextView *)self).selectedRange.location;
    }
    if ([self isKindOfClass:[UITextField class]]) {
        return ((UITextField *)self).selectedRange.location;
    }
    if ([self isKindOfClass:[UILabel class]]) {
        return ((UILabel *)self).attributedText.string.length;
    }
    return 0;
}

@end
