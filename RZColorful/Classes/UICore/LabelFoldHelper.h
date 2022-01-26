//
//  LabelFoldHelper.h
//  RZColorful
//
//  Created by rztime on 2022/1/25.
//

#import <UIKit/UIKit.h>
#import "UILabel+RZColorful.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(DrawText)

@property (nonatomic, assign) CGRect rz_drawTextRect;
+ (void)rz_swizzedSelected;
@end

@interface LabelFoldHelper : UIView

- (instancetype)initWithtarget:(UILabel *)target tapAction:(RZLabelTapAction)tapAction;

@end

NS_ASSUME_NONNULL_END
