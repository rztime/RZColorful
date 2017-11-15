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
- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute RZWARNING("请使用rz_colorfulConferInsetTo: append:方法");

/**
 插入文本

 @param position 插入的位置
 @param attribute 新的内容
 */
- (void )rz_colorfulConferInsetTo:(rzConferInsertPosition)position append:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;


/**
 添加到指定位置

 @param location <#location description#>
 @param attribute <#attribute description#>
 */
- (void )rz_colorfulConferInsetToLocation:(NSUInteger)location append:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;
@end
NS_ASSUME_NONNULL_END
