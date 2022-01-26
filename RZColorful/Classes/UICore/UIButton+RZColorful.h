//
//  UIButton+RZColorful.h
//  RZColorful
//
//  Created by rztime on 2022/1/25.
//

#import <UIKit/UIKit.h>
#import "RZColorfulConferrer.h"
#import "NSAttributedString+RZColorful.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (RZColorful)

/**
 仅UILabel、UITextField、UITextView 使用有效 设置富文本，原内容将清除
 
 @param attribute block description
 */
- (void)rz_colorfulConfer:(void(^)( RZColorfulConferrer * _Nonnull  confer))attribute state:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
