//
//  RZColorfulView.h
//  RZColorful
//
//  Created by rztime on 2026/7/7.
//

#import <UIKit/UIKit.h>
#import "RZTextLayout.h"
#import "RZColorfulAttribute.h"
#import "UITextView+RZColorful.h"

NS_ASSUME_NONNULL_BEGIN

@interface RZColorfulTapCache : NSObject

@property (nonatomic, strong, readonly) NSAttributedString *attr;
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) CGPoint point;
@property (nonatomic, assign, readonly) NSRange range;
@property (nonatomic, strong, readonly, nullable) NSDictionary<NSAttributedStringKey, id> *dict;

- (instancetype)initWithAttr:(NSAttributedString *)attr
                        size:(CGSize)size
                       point:(CGPoint)point
                       range:(NSRange)range
                        dict:(nullable NSDictionary<NSAttributedStringKey, id> *)dict;

@end

@interface RZColorfulTextViewHelper : UIView

@property (nonatomic, weak) UIView *infoView;

@end

@interface RZColorfulView : UIView

@property (nonatomic, copy, nullable) ColorfulTapActionRZ tapAction;
@property (nonatomic, weak, nullable) UIView *target;
@property (nonatomic, strong, nullable) RZTextLayout *textLayout;
@property (nonatomic, assign) BOOL needReload;
@property (nonatomic, strong, nullable) RZColorfulTapCache *cache;
@property (nonatomic, strong, nullable) RZColorfulTextViewHelper *textViewHelper;
/// 仅支持UILabel、UITextView
- (instancetype)initWithTarget:(UIView *)target;
- (void)textViewDidChanged;
- (nullable RZColorfulTapCache *)tapWithPoint:(CGPoint)point;
- (void)reload;

@end

@interface UIView(colofulView)

@property (nonatomic, strong) RZTextLayout *textLayout;
@property (nonatomic, readonly, nullable) NSAttributedString *attrText;
/// 激活Colorful功能(添加的自定义view、backgroundLayer, backgroundView的功能) 仅UILabel和UITextView有效
- (nullable RZColorfulView *)activeColorful:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
