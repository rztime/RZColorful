//
//  NSAttributedString+RZColorful.h
//  RZColorfulExample
//
//  Created by rztime on 2017/11/15.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZColorfulConferrer.h"
#import "NSAttributedString+RZHtml.h"

@class RZAttributedStringInfo;

typedef NS_ENUM(NSInteger, RZAttributedStringAppendCondition) {
    RZAttributedStringAppendConditionLess  = -1,   // 比 小
    RZAttributedStringAppendConditionEqual = 0,  // 相等
    RZAttributedStringAppendConditionMore  = 1,   // 比 大
};

@interface NSAttributedString (RZColorful)
/**
 快捷创建富文本

 @param attribute <#attribute description#>
 @return <#return value description#>
 */
+ (NSAttributedString *)rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute;

// 是否有点击事件 （是否存在NSLink）
@property (nonatomic, assign) BOOL hadTapAction;
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

#pragma mark - 其他方法

// 获取富文本中的图片 用于上传服务器
- (NSArray <UIImage *> *)rz_images;

/**
 获取attrName对应的NSAttributedString
 */
- (NSArray <RZAttributedStringInfo *> *)rz_attributedStringByAttributeName:(NSAttributedStringKey)attrName;

/// 绘制在rect范围内时， 获取每一行的文本信息，
/// @param rect 绘制范围
- (NSArray <RZAttributedStringInfo *> *)rz_linesIfDrawInRect:(CGRect)rect;

/// 将attr追加到当前文本上 ，只有在rect上绘制，小于（等于或大于）line时，才将attr追加到self之后 ,如果将attr追加上去之后，行数大于line，则会对self的字符串截取
/// @param attr 要追加的文本
/// @param condition 满足的条件
/// @param line 行数
/// @param rect 要绘制的rect
- (NSAttributedString *)rz_appendAttributedString:(NSAttributedString *)attr when:(RZAttributedStringAppendCondition)condition line:(NSInteger)line inRect:(CGRect)rect;
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

