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
#import "RZShadow.h"
#import "RZColorfulAttribute.h"

#define RZWARNING(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

typedef NS_ENUM(NSInteger, RZImageAttachmentHorizontalAlign) {
    RZHorizontalAlignBottom = 0,
    RZHorizontalAlignCenter = 1,
    RZHorizontalAlignTop = 2,
};

@interface RZImageAttachment : NSObject

@property (nonatomic, assign) CGRect imageBounds RZWARNING("该属性不可使用，请使用bounds(CGRectMake(...))方法");

@property (nonatomic, assign, readonly) BOOL hadParagraphStyle;
@property (nonatomic, assign, readonly) BOOL hadShadow;

- (NSDictionary *_Nonnull)code;

/**
 将bounds数据转换成html格式的语句 
 */
- (NSString *_Nonnull)toHTMLStringWithImageUrl:(NSString *_Nonnull)imageUrl;

#pragma mark - 可以设置的属性
/** 段落样式 */
- (RZParagraphStyle *_Nonnull)paragraphStyle;
/** 阴影 */
- (RZShadow *_Nonnull)shadow;
/// 需要添加更多的属性，用这个,如underline等
-(RZColorfulAttribute *_Nonnull)more;
/**
  设置图片bounds时,origin.x 设置无效 size.width height 可以设置与前后排文字字体大小一样，且适当调整origin.y为负值，可以让图片文本对齐
 如果是通过url设置bounds时，宽设置为0：则宽按照高度自动等比显示，高设置为0亦如此
 */
- (RZImageAttachment *_Nonnull(^_Nonnull)(CGRect bounds))bounds;
/**
 水平对齐方式
 align 上，中，下
 refer 对齐的参考系 （前后的字体）
 */
- (RZImageAttachment *_Nonnull(^_Nonnull)(CGSize size, RZImageAttachmentHorizontalAlign align, UIFont *_Nonnull font))size;

/**
 y轴偏移量，在某些情况下，在对齐之后需要做上下偏移时，用此方法，请在设置size之后或者bounds之后使用
 > 0 时，向下移动位置
 < 0 时，向上移动位置
 */
- (RZImageAttachment *_Nonnull(^_Nonnull)(CGFloat yOffset))yOffset;

#pragma mark - 下边附加属性也可以通过.more去调用，
/** 自定义属性和值 */
- (RZImageAttachment *_Nonnull(^_Nonnull)(NSAttributedStringKey _Nonnull key, id _Nullable value))custom;

/// 添加link属性
- (RZImageAttachment *_Nonnull(^_Nonnull)(NSURL * _Nullable url))url;

/// 添加可点击
- (RZImageAttachment *_Nonnull(^_Nonnull)(NSString * _Nullable tapId))tapAction;
/* 添加点击事件(block方式)*/
- (RZImageAttachment * _Nonnull(^_Nonnull)(ColorfulClickedRZ __nullable))clicked;
/* 添加一个backgroundView
 UIlabel中，backgroundView是在文本上面
 UITextView中，backgroundView是在文本下面 */
- (RZImageAttachment * _Nonnull(^_Nonnull)(ColorfulBackgroundViewRZ __nullable))backgroundView;
@end

@interface NSTextAttachment (RZCustomView)

/// 自定义视图（通过关联对象实现）
@property (nonatomic, strong, nullable) UIView *customView;

@end
@interface UIImage (RZEmptyImage)

/// 获取1x1透明图片（缓存的单例）
+ (UIImage *_Nonnull)rz_transparentImage;

@end
