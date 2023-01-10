//
//  RZParagraphStyle.h
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/31.
//  Copyright © 2017年 rztime. All rights reserved.
//

// 段落属性的设置集合


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RZColorfulAttribute;
@class RZImageAttachment;

#define RZWARNING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

@interface RZMutableParagraphStyle : NSMutableParagraphStyle
/// 行数
@property (nonatomic, assign) NSUInteger numberOfLines;
/// 计算时，绘制的文本的最大宽度
@property (nonatomic, assign) CGFloat textDrawMaxWidth;
/// 截断时，根据LineBreakMode方式，添加的文本
@property (nonatomic, strong) NSAttributedString * _Nullable truncateText;

+ (RZMutableParagraphStyle *_Nonnull)copyWith:(RZMutableParagraphStyle *_Nonnull)para;

@end

@interface RZParagraphStyle : NSObject

- (instancetype _Nonnull)initWithAttr:(RZColorfulAttribute *_Nonnull)attr;
- (instancetype _Nonnull)initWithAttach:(RZImageAttachment *_Nonnull)attach;

- (RZMutableParagraphStyle *_Nonnull)code;

/** 连接词 text、htmlText可使用*/
- (RZColorfulAttribute *_Nonnull)and;
/** 连接词 text、htmlText可使用 */
- (RZColorfulAttribute *_Nonnull)with;
/** 连接词 text、htmlText可使用 */
- (RZColorfulAttribute *_Nonnull)end;

/** 连接词 image、imageByUrl可使用*/
- (RZImageAttachment *_Nonnull)andAttach;
/** 连接词 image、imageByUrl可使用*/
- (RZImageAttachment *_Nonnull)withAttach;
/** 连接词 image、imageByUrl可使用*/
- (RZImageAttachment *_Nonnull)endAttach;
/** 段落行距 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))lineSpacing;
/** 段落后面的间距 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))paragraphSpacing;
/** 文本对齐方式 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(NSTextAlignment))alignment;
/** 首行文本缩进 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))firstLineHeadIndent;
/** 非首行文本缩进 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))headIndent;
/** 文本缩进  */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))tailIndent;
/** 文本折行方式 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(NSLineBreakMode))lineBreakMode;
/** 文本最小行距 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))minimumLineHeight;
/** 文本最大行距 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))maximumLineHeight;
/** 文本写入方式，即显示方式，从左至右，或从右到左 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(NSWritingDirection))baseWritingDirection;
/** 设置文本行间距是默认间距的倍数 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))lineHeightMultiple;
/** 段与段之间的间距 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))paragraphSpacingBefore;
/** 设置每行的最后单词是否截断，在0.0-1.0之间，默认为0.0，越接近1.0单词被截断的可能性越大， */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(float))hyphenationFactor;
/** 未知 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(CGFloat))defaultTabInterval NS_AVAILABLE(10_0, 7_0);
/** 未知 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(BOOL))allowsDefaultTighteningForTruncation NS_AVAILABLE(10_11, 9_0);
/** 给段落添加行数限制，搭配NSLineBreakModel，将在段落里添加...占位 */
- (RZParagraphStyle *_Nonnull(^_Nonnull)(NSInteger numberOfLines, CGFloat maxWidth, NSAttributedString *_Nullable truncateText))numberOfLines;
@end
