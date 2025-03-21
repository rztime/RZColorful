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
+ (NSAttributedString *_Nullable)rz_colorfulConfer:(void(^_Nullable)(RZColorfulConferrer *_Nullable confer))attribute;
// 追加
- (NSAttributedString *_Nullable)attributedStringByAppend:(NSAttributedString *_Nullable)attributedString;
// 获取富文本中的图片 用于上传服务器
- (NSArray <UIImage *> *_Nullable)rz_images;
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

#pragma mark - 其他方法
/**
 获取attrName对应的NSAttributedString
 */
- (NSArray <RZAttributedStringInfo *> *_Nullable)rz_attributedStringByAttributeName:(NSAttributedStringKey _Nonnull)attrName;

/// 绘制在rect范围内时， 获取每一行的文本信息，
/// @param rect 绘制范围
- (NSArray <RZAttributedStringInfo *> *_Nullable)rz_linesIfDrawInRect:(CGRect)rect;

/// 将attr追加到当前文本上 ，只有在rect上绘制，小于（等于或大于）line时，才将attr追加到self之后 ,如果将attr追加上去之后，行数大于line，则会对self的字符串截取
/// @param attr 要追加的文本
/// @param condition 满足的条件
/// @param line 行数
/// @param rect 要绘制的rect
- (NSAttributedString *_Nullable)rz_appendAttributedString:(NSAttributedString *_Nullable)attr when:(RZAttributedStringAppendCondition)condition line:(NSInteger)line inRect:(CGRect)rect;
@end

@interface NSAttributedString (RZLines)

/// 计算NSAttributedString的文本在width限制条件下， 是否超过line行
- (BOOL)rz_moreThan:(NSInteger)line maxWidth:(CGFloat)width;

/// 通过限制宽度，行数，获取内容，
/// 如果未超过 line 行数，返回原字符串
/// 超过行数，折叠时，将追加showAllText(如显示全文)， 全部展开时，显示showFoldText(如收起)
/// - Parameters:
///   - maxline: 最大显示的行数,
///   - maxWidth: 最大显示宽度
///   - isFold: 当前是否折叠
///   - showAllText: 如 “...显示全文” fold = true时，将追加在字符串后
///   - showFoldText: 如 “收起全文” flod = FALSE，表示已全部展开，将追加在后边
/// - Returns: 字符串
- (NSAttributedString * _Nullable)rz_attributedStringBy:(NSInteger)maxLine maxWidth:(CGFloat)width isFold:(BOOL)fold showAllText:(NSAttributedString *_Nullable)allText showFoldText:(NSAttributedString *_Nullable)foldText;

/// 对富文本进行截断处理
/// - Parameters:
///   - maxLine: 设置超过多少截断
///   - width: 显示的最大宽度
///   - model: 截断方式
///   - placeHolder: 截断时占位的"..."文字
- (NSAttributedString * _Nullable)rz_attributedStringBy:(NSInteger)maxLine maxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)model placeHolder:(NSAttributedString *_Nullable)placeHolder;
/// 头部截断（逆向）从最后一个字反向往前保留最后maxLine行数的文字
/// - Parameters:
///   - maxline: 最大行数
///   - maxWidth: 最大宽度
///   - lineBreakMode: placeholder插入的方式
///   - placeHolder: 截断时占位的"..."文字
///   - 区别于方法（A）的byTruncatingHead：func attributedStringBy(maxline: Int, maxWidth: CGFloat, lineBreakMode: NSLineBreakMode, placeHolder: NSAttributedString?) -> NSAttributedString?
///   - 方法（A）抛弃前半部分，在最前边插入placeholder
///   - headxxx抛弃前半部分，然后根据mode再不同位置插入placeholder
- (NSAttributedString * _Nullable)rz_headTruncatingAttributedStringBy:(NSInteger)maxline  maxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)model placeHolder:(NSAttributedString *_Nullable)placeHolder;
@end

@interface NSAttributedString (RZAttr)
/// 给text 关键字 标记属性（如对关键字进行标红显示）
- (NSAttributedString *_Nonnull)rz_markText:(NSString *_Nullable)text attribute:(NSDictionary<NSAttributedStringKey, id> *_Nonnull)attribute;
/// 取self的属性，设置在text上
- (NSAttributedString *_Nonnull)rz_copyAttributeToText:(NSString *_Nonnull)text;

@end

// 要获取的attrName对应的信息
@interface RZAttributedStringInfo : NSObject
/** 对应的attributedString */
@property (nonatomic, strong) NSMutableAttributedString * _Nullable attributedString;
/** 所在的range */
@property (nonatomic, assign) NSRange range;
/** 对应可以的值 */
@property (nonatomic, strong) id _Nullable value;
/** 所要查询的attrName */
@property (nonatomic, copy) NSAttributedStringKey _Nullable attrName;

@end

