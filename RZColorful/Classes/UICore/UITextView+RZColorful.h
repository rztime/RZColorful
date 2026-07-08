//
//  UITextView+RZColorful.h
//  RZColorfulExample
//
//  Created by 若醉 on 2018/7/6.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZColorfulConferrer.h"
#import "NSString+RZCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (RZColorful)

/**
 仅UILabel、UITextField、UITextView 使用有效 设置富文本，原内容将清除
 
 @param attribute block description
 */
- (void )rz_colorfulConfer:(void(^)( RZColorfulConferrer * _Nonnull  confer))attribute;

/**
 仅UILabel、UITextField、UITextView 使用有效  插入文本到头、尾、光标位置
 
 @param position 插入的位置
 @param attribute 新的内容
 */
- (void )rz_colorfulConferInsetTo:(rzConferInsertPosition)position append:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;

/**
 仅UILabel、UITextField、UITextView 使用有效  添加到指定位置
 
 @param location 位置
 @param attribute  attribute
 */
- (void )rz_colorfulConferInsetToLocation:(NSUInteger)location append:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;

/// 获取range所在文本的位置
- (CGRect)rz_rectFor:(NSRange)range;

/// 获取range所在文本的位置,可能涉及多行 NSValue: CGRect
- (NSArray<NSValue *> *)rz_rectFors:(NSRange)range;

/// 设置富文本（超过行数后，自动追加“展开” “收起”）
/// @param attr 原文
/// @param line 最大显示行数
/// @param width 最大显示宽度，这个宽度用于计算文本行
/// @param fold 当前是否折叠
/// @param allText 超过了行数之后，折叠状态显示的文本 如”展开“  需要给文本设置NSTapActionByLabel属性  (tapActionByLable)
/// @param foldText 超过行数之后，全部展开状态显示的文本  如”收起“  需要给文本设置NSTapActionByLabel属性 (tapActionByLable)
- (void)rz_setAttributedString:(NSAttributedString * _Nullable)attr maxLine:(NSInteger)line maxWidth:(CGFloat)width isFold:(BOOL)fold showAllText:(NSAttributedString *_Nullable)allText showFoldText:(NSAttributedString *_Nullable)foldText;

/// 设置富文本超行时自定义截断方式
/// @param attr 原文
/// @param line 最大行数
/// @param width 最大宽度
/// @param mode 截断方式
/// @param placeHolder 截断时占位内容 如原系统是"..."， 可改为其他自定义内容
- (void)rz_setAttributedString:(NSAttributedString * _Nullable)attr maxLine:(NSInteger)line maxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)mode placeHolder:(NSAttributedString *_Nullable)placeHolder;

- (void)rz_tapAction:(ColorfulTapActionRZ _Nullable)tapAction;
/// 禁用点击链接跳转到系统浏览器
- (void)disableLink:(BOOL)disable;
/// 禁用点击附件
- (void)disableAttachment:(BOOL)disable;
@end

/// UITextView 辅助类，用于控制链接和附件的交互
@interface RZTextViewHelper : NSObject <UITextViewDelegate>

/// 是否禁用链接交互，默认 NO
@property (nonatomic, assign) BOOL disableLink;

/// 是否禁用附件交互，默认 NO
@property (nonatomic, assign) BOOL disableAttachment;

@end

@interface UITextView (RZHelper)

/// 获取或创建 RZTextViewHelper 实例
/// 注意：设置此属性会自动将 delegate 设置为 helper
@property (nonatomic, strong) RZTextViewHelper *rzHelper;

@end
NS_ASSUME_NONNULL_END
