//
//  UITextField+RZColorfulText.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZColorfulConferrer.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (RZColorfulText)
/**
 设置富文本，原内容将清除

 @param attribute <#block description#>
 */
- (void )rz_colorfulConfer:(void(^)(RZColorfulConferrer * _Nonnull confer))attribute;

/**
 追加新的富文本，原内容仍在

 @param attribute <#block description#>
 */
- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer * _Nonnull confer))attribute;

@end
NS_ASSUME_NONNULL_END
