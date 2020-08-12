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
@class RZImageAttachment;
  
@interface RZShadow : NSObject
 
- (instancetype)initWithAttr:(RZColorfulAttribute *)attr;
- (instancetype)initWithAttach:(RZImageAttachment *)attach;

- (NSShadow *)code;

/** 连接词 text、htmlText可使用*/
- (RZColorfulAttribute *)and;
/** 连接词 text、htmlText可使用 */
- (RZColorfulAttribute *)with;
/** 连接词 text、htmlText可使用 */
- (RZColorfulAttribute *)end;

/** 连接词 appendImage、appendImageByUrl可使用*/
- (RZImageAttachment *)andAttach;
/** 连接词 appendImage、appendImageByUrl可使用*/
- (RZImageAttachment *)withAttach;
/** 连接词 appendImage、appendImageByUrl可使用*/
- (RZImageAttachment *)endAttach;


/** 阴影偏移量 */
- (RZShadow *(^)(CGSize offset))offset; 
/** // blur radius of the shadow in default user space units  // 值越大，越模糊 */
- (RZShadow *(^)(CGFloat radius))radius; 
/** 阴影颜色 */
- (RZShadow *(^)(UIColor *color))color;

@end
