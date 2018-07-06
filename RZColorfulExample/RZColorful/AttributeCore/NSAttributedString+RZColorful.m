//
//  NSAttributedString+RZColorful.m
//  RZColorfulExample
//
//  Created by rztime on 2017/11/15.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "NSAttributedString+RZColorful.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation NSAttributedString (RZColorful)

+ (NSAttributedString *)rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute {
    if(!attribute) {
        return [NSAttributedString new];
    }
    RZColorfulConferrer *conferrer = [[RZColorfulConferrer alloc]init];
    attribute(conferrer);
    return [conferrer confer].copy;
}

- (NSAttributedString *)attributedStringByAppend:(NSAttributedString *)attributedString {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [attr appendAttributedString:attributedString];
    return attr.copy;
}

/**
 固定宽度，计算高
 
 @param width 固定宽度
 @return <#return value description#>
 */
- (CGSize)sizeWithConditionWidth:(CGFloat)width {
    CGSize size = [self sizeWithCondition:CGSizeMake(width, CGFLOAT_MAX)];
    size.width = width;
    return size;
}


/**
 固定高度，计算宽
 
 @param height 固定高度
 @return <#return value description#>
 */
- (CGSize)sizeWithConditionHeight:(CGFloat)height {
    CGSize size = [self sizeWithCondition:CGSizeMake(CGFLOAT_MAX, height)];
    size.height = height;
    return size;
}
/**
 计算富文本的size
 如需计算高度 size = CGSizeMake(300, CGFLOAT_MAX)
 如需计算宽度 size = CGSizeMake(CGFLOAT_MAX, 18)
 
 @param size 约定的size，以宽高做条件，定宽时，计算得到高度（此时忽略宽度）
 定高时，计算得到宽度 （此时忽略高度）
 @return <#return value description#>
 */
- (CGSize)sizeWithCondition:(CGSize)size {
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    tempLabel.numberOfLines = 0;
    tempLabel.attributedText = self;
    [tempLabel sizeToFit];
    CGSize tempSize = tempLabel.frame.size;
    return tempSize;
}


// 将html转换成 NSAttributedString
+ (NSAttributedString *)htmlString:(NSString *)html {
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    NSError *error;
    NSAttributedString *htmlString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:&error];
    if (!error) {
        return htmlString;
    } else {
        NSLog(@"__%s__\n 富文本html转换有误:\n%@", __FUNCTION__, error);
        return [NSAttributedString new];
    }
}
@end

#pragma clang diagnostic pop
