//
//  RZShadow.h
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RZColorfulAttribute;

@interface RZShadow : NSObject

@property (nonatomic, strong) RZColorfulAttribute *colorfulsAttr;
@property (nonatomic, strong) NSShadow *shadow;

/**
 连接词，如果阴影属性设置完了，还想继续设置其他text的属性，请使用and，with，或者end，之后可以继续设置其他属性

 @return <#return value description#>
 */
- (RZColorfulAttribute *)and;
- (RZColorfulAttribute *)with;
- (RZColorfulAttribute *)end;

- (RZShadow *(^)(CGSize offset))offset;

- (RZShadow *(^)(CGFloat radius))radius;

- (RZShadow *(^)(UIColor *color))color;

@end
