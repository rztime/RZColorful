//
//  RZShadow.h
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//

// 阴影的设置集合

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RZColorfulAttribute;

#define RZWARNING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)


@interface RZShadow : NSObject

@property (nonatomic, strong) RZColorfulAttribute *colorfulsAttr RZWARNING("该属性不可使用，设置富文本属性参照类中block方法内容");

@property (nonatomic, strong) NSShadow *shadow RZWARNING("该属性不可使用，设置富文本属性参照类中block方法内容");


/**
 连接词，如果阴影属性设置完了，还想继续设置其他text的属性，请使用and，with，或者end，之后可以继续设置其他属性

 @return <#return value description#>
 */
- (RZColorfulAttribute *)and;
- (RZColorfulAttribute *)with;
- (RZColorfulAttribute *)end;


/**
 阴影偏移量
 */
- (RZShadow *(^)(CGSize offset))offset;

/**
 // blur radius of the shadow in default user space units
 // 值越大，越模糊
 */
- (RZShadow *(^)(CGFloat radius))radius;

/**
 阴影颜色
 */
- (RZShadow *(^)(UIColor *color))color;

@end
