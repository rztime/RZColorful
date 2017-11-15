//
//  UITextView+RZColorfulText.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "UITextView+RZColorfulText.h"
#import "NSAttributedString+RZColorful.h"

@implementation UITextView (RZColorfulText)

- (void )rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute {
    if(!attribute) {
        return ;
    }
    self.attributedText = nil;
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
            if ([self isFirstResponder]) {
                location = self.selectedRange.location;
            } else {
                location = self.attributedText.string.length;
            }
            break;
        }
        case rzConferInsertPositionHeader: {  // 头
            location = 0;
            break;
        }
        case rzConferInsertPositionEnd: {    // 尾
            location = self.attributedText.string.length;
            break;
        }
        default:
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
    __block NSUInteger loc = location;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSAttributedString *conferrerColorful = [NSAttributedString rz_colorfulConfer:attribute];
        if (conferrerColorful.length == 0) {
            return ;
        }
        if (loc > self.attributedText.string.length) {
            loc = self.attributedText.string.length;
        }
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attr insertAttributedString:conferrerColorful atIndex:loc];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.attributedText = attr;
        });
    });
}

@end
