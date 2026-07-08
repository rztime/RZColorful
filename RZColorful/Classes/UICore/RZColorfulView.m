//
//  RZColorfulView.m
//  RZColorful
//
//  Created by rztime on 2026/7/7.
//

#import "RZColorfulView.h"
#import "RZTextLayout.h"
#import <objc/runtime.h>
#import "RZColorfulAttribute.h"
#import "NSString+RZCode.h"
#import "RZImageAttachment.h"

@implementation RZColorfulTapCache

- (instancetype)initWithAttr:(NSAttributedString *)attr
                        size:(CGSize)size
                       point:(CGPoint)point
                       range:(NSRange)range
                        dict:(NSDictionary<NSAttributedStringKey,id> *)dict {
    self = [super init];
    if (self) {
        _attr = attr;
        _size = size;
        _point = point;
        _range = range;
        _dict = dict;
    }
    return self;
}

@end

@implementation RZColorfulTextViewHelper

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.infoView == nil) {
        return nil;
    }
    UIView *v = [self.infoView hitTest:point withEvent:event];
    return v;
}

@end

@interface RZColorfulView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end


@implementation RZColorfulView

- (instancetype)initWithTarget:(UIView *)target {
    /// target 必须是 UILabel 或 UITextView
    NSParameterAssert([target isKindOfClass:[UILabel class]] || [target isKindOfClass:[UITextView class]]);
    
    self = [super initWithFrame: target.bounds];
    if (self) {
        self.layer.masksToBounds = YES;
        self.target = target;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.needReload = YES;
        
        // 添加KVO监听
        [target addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [target addObserver:self forKeyPath:@"attributedText" options:NSKeyValueObservingOptionNew context:nil];
        [target addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [target addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        // 处理UITextView的通知
        if ([target isKindOfClass:[UITextView class]]) {
            UITextView *textView = (UITextView *)target;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textViewDidChanged)
                                                         name:UITextViewTextDidChangeNotification
                                                       object:textView];
            // textView因为一些原因，不能将self直接添加到最顶层，所以这里用一个helper
            [target insertSubview:self atIndex:0];
            
            RZColorfulTextViewHelper *helper = [[RZColorfulTextViewHelper alloc] init];
            helper.hidden = YES;
            helper.infoView = self;
            [target addSubview:helper];
            self.textViewHelper = helper;
        } else {
            [target addSubview:self];
        }
        
        // 添加点击手势
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self addGestureRecognizer:self.tapGesture];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_target removeObserver:self forKeyPath:@"text"];
    [_target removeObserver:self forKeyPath:@"attributedText"];
    [_target removeObserver:self forKeyPath:@"bounds"];
    [_target removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - Actions

- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    if (!self.cache.dict || self.cache.range.location == NSNotFound) {
        return;
    }
    
    NSDictionary *attributed = self.cache.dict;
    NSRange range = self.cache.range;
    
    // 检查各种点击事件
    NSString *tapAction = attributed[RZTapActionAttributeName];
    if (tapAction) {
        NSString *actionId = [tapAction stringByRemovingPercentEncoding] ?: tapAction;
        if (self.tapAction) {
            self.tapAction(self.target, actionId, range);
        }
        return;
    }
    
    // 检查link
    id link = attributed[NSLinkAttributeName];
    if (link) {
        NSString *actionId = nil;
        if ([link isKindOfClass:[NSString class]]) {
            actionId = [(NSString *)link rz_decodedString] ?: link;
        } else if ([link isKindOfClass:[NSURL class]]) {
            actionId = [(NSURL *)link absoluteString];
            actionId = [actionId rz_decodedString] ?: actionId;
        }
        if (actionId && self.tapAction) {
            self.tapAction(self.target, actionId, range);
        }
        return;
    }
    
    // 检查rzclicked
    ColorfulClickedRZ clicked = attributed[RZClickedActionAttributeName];
    if (clicked) {
        clicked(self.target, range);
    }
}

- (void)textViewDidChanged {
    self.needReload = YES;
    [self setNeedsLayout];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"text"] || [keyPath isEqualToString:@"attributedText"]) {
        self.needReload = YES;
    } else if ([keyPath isEqualToString:@"bounds"] || [keyPath isEqualToString:@"frame"]) {
        CGRect oldRect = [change[NSKeyValueChangeOldKey] CGRectValue];
        CGRect newRect = [change[NSKeyValueChangeNewKey] CGRectValue];
        if (!CGRectEqualToRect(oldRect, newRect)) {
            self.needReload = YES;
        }
    }
    [self setNeedsLayout];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [NSException raise:@"RZColorfulView" format:@"init(coder:) has not been implemented"];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.target && !CGRectEqualToRect(self.frame, self.target.bounds)) {
        self.frame = self.target.bounds;
        self.needReload = YES;
    }
    
    self.textViewHelper.frame = self.frame;
    
    if (self.needReload) {
        self.needReload = NO;
        self.textLayout = [self.target textLayout];
        [self reload];
    }
}

- (void)reload {
    // 移除所有子视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (!self.target) return;
    
    NSAttributedString *attr = [self.target attrText];
    if (!attr || attr.length == 0) return;
    if (self.bounds.size.width <= 0 || self.bounds.size.height <= 0) return;
    
    RZTextLayout *textLayout = self.textLayout;
    CGFloat yoffset = [self yoffset];
    
    // 重置自定义视图
    [self resetCustomViewFrameWithAttr:attr textLayout:textLayout yoffset:yoffset];
    
    // 重置背景视图
    [self resetBackgroundViewWithAttr:attr textLayout:textLayout yoffset:yoffset];
}

- (void)resetCustomViewFrameWithAttr:(NSAttributedString *)attr
                          textLayout:(RZTextLayout *)textLayout
                             yoffset:(CGFloat)yoffset {
    NSMutableArray *items = [NSMutableArray array];
    
    [attr enumerateAttribute:NSAttachmentAttributeName
                     inRange:NSMakeRange(0, attr.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if ([value isKindOfClass:[NSTextAttachment class]]) {
                          NSTextAttachment *attach = (NSTextAttachment *)value;
                          if (attach.customView) {
                              [items addObject:@{@"attachment": attach, @"range": [NSValue valueWithRange:range]}];
                          }
                      }
                  }];
    
    if (items.count == 0) return;
    
    for (NSDictionary *item in items) {
        NSTextAttachment *attach = item[@"attachment"];
        NSRange range = [item[@"range"] rangeValue];
        UIView *view = attach.customView;
        
        if (view) {
            CGRect rect = [textLayout rectForCharacterRange:range];
            if (!CGRectIsNull(rect) && !CGRectIsEmpty(rect)) {
                CGRect frame = CGRectMake(rect.origin.x,
                                          rect.origin.y + yoffset,
                                          rect.size.width,
                                          rect.size.height);
                frame.size = attach.bounds.size;
                view.frame = frame;
                [self addSubview:view];
            }
        }
    }
}

- (void)resetBackgroundViewWithAttr:(NSAttributedString *)attr
                         textLayout:(RZTextLayout *)textLayout
                            yoffset:(CGFloat)yoffset {
    NSMutableArray *items = [NSMutableArray array];
    
    [attr enumerateAttribute:RZBackgroundViewAttributeName
                     inRange:NSMakeRange(0, attr.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value) {
                          [items addObject:@{@"background": value, @"range": [NSValue valueWithRange:range]}];
                      }
                  }];
    
    if (items.count == 0) return;
    
    for (NSDictionary *item in items) {
        ColorfulBackgroundViewRZ background = item[@"background"];
        NSRange range = [item[@"range"] rangeValue];
        
        if (background) {
            NSArray<NSValue *> *rects = [textLayout rectsForRange:range];
            if (rects && rects.count > 0) {
                NSMutableArray *adjustedRects = [NSMutableArray array];
                for (NSValue *rectValue in rects) {
                    CGRect rect = [rectValue CGRectValue];
                    CGRect adjustedRect = CGRectMake(rect.origin.x,
                                                     rect.origin.y + yoffset,
                                                     rect.size.width,
                                                     rect.size.height);
                    [adjustedRects addObject:[NSValue valueWithCGRect:adjustedRect]];
                }
                
                NSArray<UIView *> *views = background(adjustedRects);
                for (UIView *view in views) {
                    [self addSubview:view];
                }
            }
        }
    }
}

#pragma mark - Hit Test

- (nullable RZColorfulTapCache *)tapWithPoint:(CGPoint)point {
    if (!self.target) return nil;
    
    NSAttributedString *attr = [self.target attrText];
    if (!attr || attr.length == 0) return nil;
    if (self.bounds.size.width <= 0 || self.bounds.size.height <= 0) return nil;
    UIView *v = (UIView *)self.target;
    // 检查缓存
    if (self.cache) {
        CGPoint cachePoint = self.cache.point;
        CGFloat dx = fabs(point.x - cachePoint.x);
        CGFloat dy = fabs(point.y - cachePoint.y);
        CGFloat minDiff = 1.0;
        if (dx <= minDiff && dy <= minDiff &&
            [self.cache.attr isEqualToAttributedString:attr] &&
            CGSizeEqualToSize(self.cache.size, v.bounds.size)) {
            return self.cache;
        }
    }
    
    RZTextLayout *textLayout = self.textLayout;
    CGFloat yoffset = [self yoffset];
    CGPoint tapPoint = CGPointMake(point.x, point.y - yoffset);
    
    NSNumber *indexNumber = [textLayout characterIndexAtPoint:tapPoint];
    if (!indexNumber) {
        return nil;
    }
    NSInteger index = [indexNumber integerValue];
    
    NSRange range = NSMakeRange(index, 1);
    NSDictionary *attributed = [attr attributesAtIndex:index longestEffectiveRange:nil inRange:range];
    
    RZColorfulTapCache *cache = nil;
    if (attributed[RZClickedActionAttributeName]) {
        cache = [[RZColorfulTapCache alloc] initWithAttr:attr
                                                    size:v.bounds.size
                                                   point:point
                                                   range:range
                                                    dict:attributed];
    } else if ((attributed[RZTapActionAttributeName] || attributed[NSLinkAttributeName]) && self.tapAction) {
        cache = [[RZColorfulTapCache alloc] initWithAttr:attr
                                                    size:v.bounds.size
                                                   point:point
                                                   range:range
                                                    dict:attributed];
    } else {
        cache = [[RZColorfulTapCache alloc] initWithAttr:attr
                                                    size:v.bounds.size
                                                   point:point
                                                   range:range
                                                    dict:nil];
    }
    
    self.cache = cache;
    return cache;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *v = [super hitTest:point withEvent:event];
    if (v && v != self) {
        return v;
    }
    
    RZColorfulTapCache *cache = [self tapWithPoint:point];
    if (cache.dict) {
        return self;
    }
    
    return nil;
}

#pragma mark - Helper

- (CGFloat)yoffset {
    UIView *v = (UIView *)self.target;
    if ([v isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)self.target;
        return textView.contentInset.top + textView.textContainerInset.top;
    }
    
    if (!self.textLayout) return 0;
    
    CGRect textContainer = self.bounds;
    CGRect usedRect = [self.textLayout usedRect];
    CGFloat yoffset = (textContainer.size.height - usedRect.size.height) / 2.0;
    yoffset = MAX(0, yoffset);
    return yoffset;
}

@end

@implementation UIView(colofulView)

static const char *kLabelTextLayoutKey = "kLabelTextLayoutKey";

- (NSAttributedString *)attrText {
    if ([self isKindOfClass:[UITextView class]]) {
        return [(UITextView *)self attributedText];
    }
    if ([self isKindOfClass:[UILabel class]]) {
        return [(UILabel *)self attributedText];
    }
    return nil;
}
- (void)setTextLayout:(RZTextLayout *)textLayout {
    objc_setAssociatedObject(self, kLabelTextLayoutKey, textLayout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RZTextLayout *)textLayout {
    RZTextLayout *textLayout = objc_getAssociatedObject(self, kLabelTextLayoutKey);
    if (!textLayout) {
        if ([self isKindOfClass:[UITextView class]]) {
            textLayout = [[RZTextLayout alloc] initWithTextView: (UITextView *)self];
            self.textLayout = textLayout;
        } else if ([self isKindOfClass:[UILabel class]]) {
            textLayout = [[RZTextLayout alloc] initWithAttributedText:[[NSAttributedString alloc] init]
                                                                 size:self.bounds.size
                                                  maximumNumberOfLines:0
                                                        lineBreakMode:NSLineBreakByWordWrapping];
            self.textLayout = textLayout;
        }
    }
    
    if (self.attrText && self.attrText.length > 0) {
        if ([self isKindOfClass:[UITextView class]]) {
            return textLayout;
        } else if ([self isKindOfClass:[UILabel class]]) {
            [textLayout updateByLabel:(UILabel *)self];
            return textLayout;
        }
    }
    return nil;
}

- (nullable RZColorfulView *)activeColorful:(BOOL)enable {
    /// target 必须是 UILabel 或 UITextView
    NSParameterAssert([self isKindOfClass:[UILabel class]] || [self isKindOfClass:[UITextView class]]);
    
    if (!enable) {
        // 移除所有RZColorfulView
        NSArray *subviews = [self.subviews copy];
        for (UIView *subview in subviews) {
            if ([subview isKindOfClass:[RZColorfulView class]]) {
                [subview removeFromSuperview];
            }
        }
        return nil;
    } else {
        // 查找已存在的RZColorfulView
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:[RZColorfulView class]]) {
                return (RZColorfulView *)subview;
            }
        }
        self.userInteractionEnabled = YES;
        RZColorfulView * v = [[RZColorfulView alloc] initWithTarget:self];
        if ([self isKindOfClass:[UITextView class]]) {
            [(UITextView *)self disableLink:true];
            [(UITextView *)self disableAttachment:true];
        }
        return v;
    }
}

@end
