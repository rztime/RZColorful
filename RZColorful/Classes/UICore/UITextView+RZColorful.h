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

/**
 点击textView里的可以点击的字符串，
 tapObj：为tapId或者NSURL
  return: NO: 不跳转到浏览器， YES：跳转到浏览器
 如果tapAction()或url()中包含了有中文,URL将会进行编码，所以请将tapObj，rz_decodedString解码
 */
@property (nonatomic, copy) BOOL(^rzDidTapTextView)(id __nullable tapObj);

/// 获取range所在文本的位置
- (CGRect)rz_rectFor:(NSRange)range;

@end
NS_ASSUME_NONNULL_END
