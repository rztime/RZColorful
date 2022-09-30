//
//  LabelFoldHelper.m
//  RZColorful
//
//  Created by rztime on 2022/1/25.
//

#import "LabelFoldHelper.h"
#import <objc/runtime.h>
#import "UITextView+RZColorful.h"
#import "NSString+RZCode.h"

@interface TapPointRes : NSObject
@property (nonatomic, assign) BOOL isInTarget;
@property (nonatomic, copy) NSString *textLink;
@property (nonatomic, assign) NSRange range;
- (instancetype)initWith:(BOOL)inTarget link:(NSString *)link range:(NSRange)range;
@end
@implementation TapPointRes
- (instancetype)initWith:(BOOL)inTarget link:(NSString *)link range:(NSRange)range {
    if (self = [super init]) {
        self.isInTarget = inTarget;
        self.textLink = link;
        self.range = range;
    }
    return self;
}
@end
 
@interface LabelFoldHelper ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, weak) UILabel *target;
@property (nonatomic, copy) RZLabelTapAction tapAction;

@end
@implementation LabelFoldHelper

- (instancetype)initWithtarget:(UILabel *)target tapAction:(RZLabelTapAction)tapAction {
    if (self = [super init]) {
        self.target = target;
        self.tapAction = tapAction;
        self.translatesAutoresizingMaskIntoConstraints = false;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)];
        [self addGestureRecognizer:tap];
        [UILabel rz_swizzedSelected];
    }
    return self;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.alpha = 0;
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.scrollEnabled = false;
        _textView.editable = false;
        _textView.textContainer.lineFragmentPadding = 0;
        _textView.showsVerticalScrollIndicator = false;
        _textView.showsHorizontalScrollIndicator = false;
        _textView.linkTextAttributes = @{};
        _textView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _textView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _textView.frame = self.bounds;
}

- (void)tapGesAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self];
    TapPointRes *res = [self  tapPoint:point];
    if (res.isInTarget && self.target != nil && self.tapAction) {
        self.tapAction(self.target, res.textLink, res.range);
    }
}

- (TapPointRes *)tapPoint:(CGPoint)point {
    if (self.target == nil) {
        return [[TapPointRes alloc] initWith:false link:@"" range: NSMakeRange(0, 0)];
    }
    CGRect textRect = self.target.rz_drawTextRect;
    CGRect rect = [self.target textRectForBounds:textRect limitedToNumberOfLines:0];
    CGFloat offsetY = (textRect.size.height - rect.size.height) / 2.0 + textRect.origin.y;
    point.y -= offsetY;
    point.x -= textRect.origin.x;
    self.textView.frame = self.bounds;
    [self.textView systemLayoutSizeFittingSize:textRect.size];
    _textView.attributedText = self.target.attributedText;
    TapPointRes *res = [[TapPointRes alloc] init];

    [self.target.attributedText enumerateAttribute:NSTapActionByLabelAttributeName inRange:NSMakeRange(0, self.target.attributedText.length) options:(NSAttributedStringEnumerationLongestEffectiveRangeNotRequired) usingBlock:^(id _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value == nil) {
            return;
        }
        NSArray *rects = [self.textView rz_rectFors:range];
        [rects enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect rect = obj.CGRectValue;
            if (CGRectContainsPoint(rect, point)) {
                if ([value isKindOfClass:[NSString class]]) {
                    res.textLink = [value rz_decodedString];
                } else if ([value isKindOfClass:[NSURL class]]){
                    res.textLink = [((NSURL *)value).absoluteString rz_decodedString];
                }
                res.isInTarget = true;
                res.range = range;
                *stop = true;
            }
        }];
    }];
    return res;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    TapPointRes *res = [self tapPoint:point];
    if (res.isInTarget) {
        return self;
    }
    return nil;
}
@end

@implementation UILabel(DrawText)

- (void)setRz_drawTextRect:(CGRect)rz_drawTextRect {
    objc_setAssociatedObject(self, @"rz_drawTextRect", [NSValue valueWithCGRect:rz_drawTextRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGRect)rz_drawTextRect {
    NSValue *value = (NSValue *)objc_getAssociatedObject(self, @"rz_drawTextRect");
    return [value CGRectValue];
}

+ (void)rz_swizzedSelected {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"------------UILabel drawTextInRect 方法交换 rz_drawTextInRect--------------");
        Method origin = class_getInstanceMethod([UILabel class], @selector(drawTextInRect:));
        Method swizee = class_getInstanceMethod([UILabel class], @selector(rz_drawTextInRect:));
        method_exchangeImplementations(origin, swizee);
    });
}
- (void)rz_drawTextInRect:(CGRect)rect {
    [self rz_drawTextInRect: rect];
    self.rz_drawTextRect = rect;
}
@end
