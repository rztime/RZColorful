//
//  UITextView+RZColorfulText.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZColorfulConferrer.h"

@interface UITextView (RZColorfulText)

/**
 设置富文本，原内容将清除

 @param block <#block description#>
 */
- (void )rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))block;

/**
 追加新的富文本，原内容仍在

 @param block <#block description#>
 */
- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer *confer))block;
@end
