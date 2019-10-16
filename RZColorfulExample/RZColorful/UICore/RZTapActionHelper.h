//
//  RZTapActionHelper.h
//  RZColorfulExample
//
//  Created by xk_mac_mini on 2019/9/29.
//  Copyright © 2019 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZTapActionHelper : NSObject<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) id tagert;

@end

NS_ASSUME_NONNULL_END
