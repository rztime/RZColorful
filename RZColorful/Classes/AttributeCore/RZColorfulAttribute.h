//
//  RZAttribute.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

// 普通文本的所有属性的设置集合


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RZShadow.h"
#import "RZParagraphStyle.h"

#define RZWARNING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

/** 删除线样式 */
//typedef NS_OPTIONS(NSInteger, RZLineStyle) {
//    RZLineStyleNone = NSUnderlineStyleNone,     // 不设置删除线
//    RZLineStyleSignl = NSUnderlineStyleSingle,  // 删除线为细单实线
//    RZLineStyleThick = NSUnderlineStyleThick,   // 为粗单实线
//    RZLineStyleDouble = NSUnderlineStyleDouble  // 细双实线
//};
// 替换成 NSUnderlineStyle，（NSUnderlineStyleSingle | NSUnderlineStylePatternDot ）组合使用可以设置虚线、破折号等
typedef NSUnderlineStyle RZLineStyle;

typedef NS_ENUM(NSInteger, RZWriteDirection) { // 书写方向
    LRE,
    LRO,
    RLE,
    RLO,
    
    RZWDLeftToRight = LRO,   // 从左到右
    RZWDRightToLeft = RLO,   // 从右到左 
};
/// 给label添加一个点击事件的key，不用NSLink，是因为NSLink会默认加蓝色及下划线
UIKIT_EXTERN NSAttributedStringKey const _Nonnull NSTapActionByLabelAttributeName;

@interface RZColorfulAttribute : NSObject

@property (nonatomic, assign, readonly) BOOL hadShadow;
@property (nonatomic, assign, readonly) BOOL hadParagraphStyle;

- (NSDictionary *_Nonnull)code;

#pragma mark - 文本属性设置内容

#pragma mark - 连接词
/** 方便阅读用的连接词  */
- (RZColorfulAttribute *_Nonnull)and;
- (RZColorfulAttribute *_Nonnull)with;

#pragma mark - 基本属性设置
/** 设置字体 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(UIFont *__nullable))font;
/** 设置文本颜色 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(UIColor * __nullable))textColor;
/** 当前文字的所在区域的背景颜色 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(UIColor *__nullable))backgroundColor;
/** 设置连体字，value = 0,没有连体， =1，有连体 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber *__nullable))ligature;
/** 字间距 >0 加宽  < 0减小间距 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber *__nullable))wordSpace;
/** 删除线
 取值为 0 - 7时，效果为单实线，随着值得增加，单实线逐渐变粗，
 取值为 9 - 15时，效果为双实线，取值越大，双实线越粗。
 替换成 NSUnderlineStyle，(NSUnderlineStyleSingle | NSUnderlineStylePatternDot )组合使用可以设置虚线、破折号等
*/
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(RZLineStyle))strikeThrough;
/** 删除线颜色 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(UIColor *__nullable))strikeThroughColor;
/** 下划线样式  取值参照删除线，位置不同罢了
 取值为 0 - 7时，效果为单实线，随着值得增加，单实线逐渐变粗，
 取值为 9 - 15时，效果为双实线，取值越大，双实线越粗。
 替换成 NSUnderlineStyle，（NSUnderlineStyleSingle | NSUnderlineStylePatternDot ）组合使用可以设置虚线、破折号等
 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(RZLineStyle))underLineStyle;
/** 下划线颜色 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(UIColor * __nullable))underLineColor;
/** 描边的颜色 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(UIColor * __nullable))strokeColor;
/** 描边的笔画宽度 为3时，空心  负值填充效果，正值中空效果 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber * __nullable))strokeWidth;
/** 基准偏移 为正:上偏移（上标） 为负：下偏移（下标） */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber * __nullable))baselineOffset;
/** 斜体字 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber * __nullable))italic;
/** 扩张，即拉伸文字 >0 拉伸 <0压缩 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber * __nullable))expansion;
/** 书写方向 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(RZWriteDirection))writingDirection;
/** 横竖排版 0：横版 1：竖版 (iOS中1竖版无效)*/
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber * __nullable))verticalGlyphForm;
/** 特殊效果 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSTextEffectStyle __nullable))textEffect;
/** 自定义属性和值 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSAttributedStringKey _Nonnull, id __nullable))custom;

@end
#pragma mark - 富文本 url，仅UITextViewd点击有效
@interface RZColorfulAttribute (UILabel)
/* 给文本添加点击事件的id, 仅UILabel有效，需要实现label.rz_tapAction方法 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSString * __nullable))tapActionByLable;
@end

@interface RZColorfulAttribute (Other)
#pragma mark - 设置文本段落样式
/** 段落样式，具体设置请看 RZParagraphStyle.h  */
- (RZParagraphStyle * _Nonnull )paragraphStyle; 
#pragma mark -阴影设置
/** 阴影 给文本设置阴影，直接在shadow后添加阴影属性，
 如阴影颜色confer.text(@"text").shadow.color(color);
 如果需要继续添加text的属性，请使用and\with\end相连
 如confer.text(@"text").shadow.color(color).and.textColor(tColor)...  */
- (RZShadow *_Nonnull)shadow;
@end

#pragma mark - 富文本 url，仅UITextViewd点击有效
@interface RZColorfulAttribute (UITextView)
/** 给文本添加链接，并且可点击跳转浏览器打开  仅UITextView点击有效, 如果有实现点击事件， 可以替换成tapAction:
 设置url属性，要实现点击，需实现UITextView的delegate的url点击事件
 设置之后，url的文本会默认带蓝色下划线的样式，可以设置textView.linkTextAttributes = @{} 清除掉
 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSURL * __nullable))url;
/* 给属性文本添加点击事件  只有UITextView可以用，且UITextView需要实现block  didTapTextView */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSString * __nullable))tapAction;
@end

@interface RZColorfulAttribute (iOS14)
/// iOS 14
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSNumber * __nullable))tracking API_AVAILABLE(ios(14.0));
@end
@interface RZColorfulAttribute (iOS15)
/// 指定文本的展示意图
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSInlinePresentationIntent))inlinePresentationIntent API_AVAILABLE(ios(15.0));
/// 替代描述alter
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSString * __nullable))alternateDescription API_AVAILABLE(ios(15.0));
/// 与文本关联的图片的 URL
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSURL * __nullable))imageURL API_AVAILABLE(ios(15.0));
/// 标识文本的语言 如 zh-Hans
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSString * __nullable))languageIdentifier API_AVAILABLE(ios(15.0));
/// 文本替换的索引
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSInteger))replacementIndex API_AVAILABLE(ios(15.0));
/// 语法形态
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSMorphology * __nullable))morphology API_AVAILABLE(ios(15.0));
/// 变形规则，可搭配morphology使用
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSInflectionRule * __nullable))inflectionRule API_AVAILABLE(ios(15.0));
/// 指定替代的变体形式
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSString * __nullable))inflectionAlternative API_AVAILABLE(ios(15.0));
/// 标记文本的语义意图
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSPresentationIntent * __nullable))presentationIntentAttributeName API_AVAILABLE(ios(15.0));
@end
@interface RZColorfulAttribute (iOS16)
/// iOS 16
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSAttributedStringMarkdownSourcePosition * __nullable))markdownSourcePosition API_AVAILABLE(ios(16.0));
@end
@interface RZColorfulAttribute (iOS17)
/// iOS 17
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))agreeWithArgument API_AVAILABLE(ios(17.0));
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))agreeWithConcept API_AVAILABLE(ios(17.0));
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))referentConcept API_AVAILABLE(ios(17.0));
@end
@interface RZColorfulAttribute (iOS18)
/// iOS 18
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))localizedNumberFormat API_AVAILABLE(ios(18.0));
@end
