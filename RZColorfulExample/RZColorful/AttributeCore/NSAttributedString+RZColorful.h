//
//  NSAttributedString+RZColorful.h
//  RZColorfulExample
//
//  Created by rztime on 2017/11/15.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZColorfulConferrer.h"

@class RZAttributedStringInfo;

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
// 追加
- (NSAttributedString *)attributedStringByAppend:(NSAttributedString *)attributedString;

#pragma mark - HTML 富文本互换
// 将html转换成 NSAttributedString
+ (NSAttributedString *)htmlString:(NSString *)html;
// 获取富文本中的图片 用于上传服务器
- (NSArray <UIImage *> *)rz_images;
/**
 将富文本编码成html标签，如果有图片，用此方法

 @param urls 图片的url，url需要先获取图片，然后自行上传到服务器，最后按照【- (NSArray <UIImage *> *)images;】此方法得到的图片顺序排列url
 @return HTML标签
 */
- (NSString *)rz_codingToHtmlWithImagesURLSIfHad:(NSArray <NSString *> *)urls;

/**
 将富文本完整的code成html标签，（此方法如果富文本中有图片，则图片将被丢失）  有图片时，请用[rz_codingToHtmlWithImagesURLSIfHad]方法

 @return HTML标签语言
 */
- (NSString *)rz_codingToCompleteHtml;

/**
 获取attrName对应的NSAttributedString
 */
- (NSArray <RZAttributedStringInfo *> *)rz_attributedStringByAttributeName:(NSAttributedStringKey)attrName;

@property (nonatomic, assign) BOOL hadTapAction;

@end

// 要获取的attrName对应的信息
@interface RZAttributedStringInfo : NSObject
/** 对应的attributedString */
@property (nonatomic, strong) NSMutableAttributedString *attributedString;
/** 所在的range */
@property (nonatomic, assign) NSRange range;
/** 对应可以的值 */
@property (nonatomic, strong) id value;
/** 所要查询的attrName */
@property (nonatomic, copy) NSAttributedStringKey attrName;

@end

