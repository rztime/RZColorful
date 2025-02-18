//
//  UILabel+RZColorful.h
//  RZColorfulExample
//
//  Created by 若醉 on 2018/7/6.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZColorfulConferrer.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (RZColorful)

/**
 仅UILabel、UITextField、UITextView 使用有效 设置富文本，原内容将清除
 
 @param attribute block description
 */
- (void )rz_colorfulConfer:(void(^)( RZColorfulConferrer * _Nonnull  confer))attribute;

/**
 仅UILabel、UITextField、UITextView 使用有效 追加新的富文本，原内容仍在
 
 @param attribute block description
 */
- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute RZWARNING("请使用rz_colorfulConferInsetTo: append:方法");

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

/// 设置富文本（超过行数后，自动追加“展开” “收起”）
/// @param attr 原文
/// @param line 最大显示行数
/// @param width 最大显示宽度，这个宽度用于计算文本行
/// @param fold 当前是否折叠
/// @param allText 超过了行数之后，折叠状态显示的文本 如”展开“  需要给文本设置NSTapActionByLabel属性  (tapActionByLable)
/// @param foldText 超过行数之后，全部展开状态显示的文本  如”收起“  需要给文本设置NSTapActionByLabel属性 (tapActionByLable)
- (void)rz_setAttributedString:(NSAttributedString * _Nullable)attr maxLine:(NSInteger)line maxWidth:(CGFloat)width isFold:(BOOL)fold showAllText:(NSAttributedString *_Nullable)allText showFoldText:(NSAttributedString *_Nullable)foldText;

typedef void(^RZLabelTapAction)(UILabel *_Nonnull label, NSString * _Nonnull tapActionId, NSRange range);
/// 给label的富文本添加文本点击事件
/// 注意：NSAttributedString里的每一个字，都需要设置字体，否则无法准确点击位置（内部使用UITextView计算位置，无字体时，默认给的11号字体，会导致位置计算错误）
/// @param tapAction ，tapActionId 即tapActionByLable里的内容
- (void)rz_tapAction:(RZLabelTapAction _Nullable)tapAction;
@end
NS_ASSUME_NONNULL_END
