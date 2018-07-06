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
#import "RZParagraphStyle.h"

#define RZWARNING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

@interface RZImageAttachment : NSObject

@property (nonatomic, assign) CGRect imageBounds RZWARNING("该属性不可使用，请使用bounds(CGRectMake(...))方法");
- (RZParagraphStyle *)rz_paragraphStyle RZWARNING("该方法不可使用");



/**
 设置段落样式
 */
@property (nonatomic, strong) RZParagraphStyle *paragraphStyle;
/**
  设置图片bounds时,origin.x 设置无效 size.width height 可以设置与前后排文字字体大小一样，且适当调整origin.y为负值，可以让图片文本对齐
 如果是通过url设置bounds时，宽设置为0：则宽按照高度自动等比显示，高设置为0亦如此
 
 */
- (RZImageAttachment *(^)(CGRect bounds))bounds;


/**
 将bounds数据转换成html格式的语句

 @param imageUrl <#imageUrl description#>
 @return <#return value description#>
 */
- (NSString *)toHTMLStringWithImageUrl:(NSString *)imageUrl;

@end
