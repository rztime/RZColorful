//
//  RZParagraphStyle.h
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/31.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RZColorfulAttribute;

@interface RZParagraphStyle : NSObject

@property (nonatomic, strong) RZColorfulAttribute *colorfulsAttr;
@property (nonatomic, strong) NSMutableParagraphStyle *paragraph;

/**
 连接词，如果阴影属性设置完了，还想继续设置其他text的属性，请使用and，with，或者end，之后可以继续设置其他属性

 @return <#return value description#>
 */
- (RZColorfulAttribute *)and;
- (RZColorfulAttribute *)with;
- (RZColorfulAttribute *)end;

- (RZParagraphStyle *(^)(CGFloat lineSpacing))lineSpacing;
- (RZParagraphStyle *(^)(CGFloat paragraphSpacing))paragraphSpacing;
- (RZParagraphStyle *(^)(NSTextAlignment alignment))alignment;

- (RZParagraphStyle *(^)(CGFloat firstLineHeadIndent))firstLineHeadIndent;
- (RZParagraphStyle *(^)(CGFloat headIndent))headIndent;

- (RZParagraphStyle *(^)(CGFloat tailIndent))tailIndent;

- (RZParagraphStyle *(^)(NSLineBreakMode lineBreakMode))lineBreakMode;
- (RZParagraphStyle *(^)(CGFloat minimumLineHeight))minimumLineHeight;

- (RZParagraphStyle *(^)(CGFloat maximumLineHeight))maximumLineHeight;
- (RZParagraphStyle *(^)(NSWritingDirection baseWritingDirection))baseWritingDirection;

- (RZParagraphStyle *(^)(CGFloat lineHeightMultiple))lineHeightMultiple;
- (RZParagraphStyle *(^)(CGFloat paragraphSpacingBefore))paragraphSpacingBefore;
- (RZParagraphStyle *(^)(float hyphenationFactor))hyphenationFactor;

- (RZParagraphStyle *(^)(CGFloat defaultTabInterval))defaultTabInterval NS_AVAILABLE(10_0, 7_0);
- (RZParagraphStyle *(^)(BOOL allowsDefaultTighteningForTruncation))allowsDefaultTighteningForTruncation NS_AVAILABLE(10_11, 9_0);


@end
