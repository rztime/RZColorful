//
//  RZImageAttachment.h
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//
// 仅添加图片的附件
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RZWARNING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

@interface RZImageAttachment : NSObject

@property (nonatomic, assign, readonly) CGRect imageBounds RZWARNING("该属性不可使用，请使用bounds(CGRectMake(...))方法");

/**
  设置图片bounds时,origin.x 设置无效 size.width height 可以设置与前后排文字字体大小一样，且适当调整origin.y为负值，可以让图片文本对齐
 */
- (RZImageAttachment *(^)(CGRect bounds))bounds;

@end
