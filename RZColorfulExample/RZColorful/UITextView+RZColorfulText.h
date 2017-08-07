//
//  UITextView+RZColorfulText.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZColorfulConferrer.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (RZColorfulText)

/**
 设置富文本，原内容将清除

 @param attribute <#block description#>
 */
- (void )rz_colorfulConfer:(void(^)( RZColorfulConferrer * _Nonnull  confer))attribute;

/**
 追加新的富文本，原内容仍在

 @param attribute <#block description#>
 */
- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;

/**
 设置段落样式
 在attribute中设置的所有文本都遵循此paragraphStyle样式，且confer.text().paragraph.属性(值) 设置将无效

 @param paragraph 段落样式
 @param attribute 属性文本
 */
- (void)rz_colorfulWithParagraphStyle:(void(^)(RZParagraphStyle * _Nullable paragraph))paragraph confer:(void(^)(RZColorfulConferrer * _Nonnull confer))attribute;


/**
 追加段落样式

 @param paragraph 段落样式
 @param attribute 属性文本
 */
- (void)rz_colorfulWithParagraphStyleAppend:(void (^)(RZParagraphStyle * _Nullable paragraph))paragraph confer:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;
@end
NS_ASSUME_NONNULL_END
