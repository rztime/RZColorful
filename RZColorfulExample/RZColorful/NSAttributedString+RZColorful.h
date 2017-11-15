//
//  NSAttributedString+RZColorful.h
//  RZColorfulExample
//
//  Created by rztime on 2017/11/15.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZColorfulConferrer.h"

@interface NSAttributedString (RZColorful)


/**
 快捷创建富文本

 @param attribute <#attribute description#>
 @return <#return value description#>
 */
+ (NSAttributedString *)rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute;

/**
 固定宽度，计算高

 @param width 固定宽度
 @return <#return value description#>
 */
- (CGSize)sizeWithConditionWidth:(CGFloat)width;


/**
 固定高度，计算宽

 @param height 固定高度
 @return <#return value description#>
 */
- (CGSize)sizeWithConditionHeight:(CGFloat)height;


- (NSAttributedString *)attributedStringByAppend:(NSAttributedString *)attributedString;


// 将html转换成 NSAttributedString
+ (NSAttributedString *)htmlString:(NSString *)html;

@end

