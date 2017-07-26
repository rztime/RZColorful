//
//  RZAttribute.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RZWARMING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/**
 删除线样式
 */
typedef NS_ENUM(NSInteger, RZLineStyle) {
    RZLineStyleNone = NSUnderlineStyleNone,     // 不设置删除线
    RZLineStyleSignl = NSUnderlineStyleSingle,  // 删除线为细单实线
    RZLineStyleThick = NSUnderlineStyleThick,   // 为粗单实线
    RZLineStyleDouble = NSUnderlineStyleDouble  // 细双实线
};

@interface RZColorfulAttribute : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *colorfuls;

/**
 方便阅读用的连接词

 @return <#return value description#>
 */
- (RZColorfulAttribute *)and;
- (RZColorfulAttribute *)with;

/**
 设置文本颜色
 */
- (RZColorfulAttribute *(^)(UIColor *textColor))textColor;

/**
 当前文字的所在区域的背景颜色
 */
- (RZColorfulAttribute *(^)(UIColor *backgroundColor))backgroundColor;

/**
 设置字体
 */
- (RZColorfulAttribute *(^)(UIFont *font))font;

/**
 设置连体字，value = 0,没有连体， =1，有连体
 */
- (RZColorfulAttribute *(^)(NSNumber *ligature))ligature;

/**
 字间距 >0 加宽  < 0减小间距
 */
- (RZColorfulAttribute *(^)(NSNumber *wordSpace))wordSpace;

/**
 删除线  
 取值为 0 - 7时，效果为单实线，随着值得增加，单实线逐渐变粗，
 取值为 9 - 15时，效果为双实线，取值越大，双实线越粗。
 */
- (RZColorfulAttribute *(^)(RZLineStyle strikeThrough))strikeThrough;

/**
 删除线颜色
 */
- (RZColorfulAttribute *(^)(UIColor *strikeThroughColor))strikeThroughColor;

/**
 下划线样式  取值参照删除线，位置不同罢了
 */
- (RZColorfulAttribute *(^)(RZLineStyle underLineStyle))underLineStyle;

/**
 下划线颜色
 */
- (RZColorfulAttribute *(^)(UIColor *underLineColor))underLineColor;

/**
 描边的颜色
 */
- (RZColorfulAttribute *(^)(UIColor *strokeColor))strokeColor;

/**
 描边的笔画宽度 为3时，空心  负值填充效果，正值中空效果   
 */
- (RZColorfulAttribute *(^)(NSNumber *strokeWidth))strokeWidth;

/**
 横竖排版 0：横版 1：竖版
 */
- (RZColorfulAttribute *(^)(NSNumber *verticalGlyphForm))verticalGlyphForm;

/**
 斜体字
 */
- (RZColorfulAttribute *(^)(NSNumber *italic))italic;

/**
 扩张，即拉伸文字 >0 拉伸 <0压缩
 */
- (RZColorfulAttribute *(^)(NSNumber *expansion))expansion;

/** FIXME:阴影未完成
 阴影
 */
- (RZColorfulAttribute *(^)(NSShadow *shadow))shadow RZWARMING("该方法暂未实现，等稍后完善");

/** FIXME:附加属性还未完成
 附件，比如图片，等
 */
- (RZColorfulAttribute *(^)(NSTextAttachment *attachment))attachment RZWARMING("该方法暂未实现，等稍后完善");
@end

#pragma mark - 富文本 url，仅UITextViewd点击有效
@interface RZColorfulAttribute (UITextView)

/**
 给文本添加链接，并且可点击跳转浏览器打开  仅UITextView点击有效
 */
- (RZColorfulAttribute *(^)(NSURL *url))url;

@end

#pragma mark - 设置文本段落样式
@interface RZColorfulAttribute (ParagraphStyle)
/**  FIXME:段落样式还未完成
 设置段落样式
 */
- (RZColorfulAttribute *(^)(NSMutableParagraphStyle *paragraphStyle))paragraphStyle RZWARMING("该方法暂未实现，等稍后完善");

@end
