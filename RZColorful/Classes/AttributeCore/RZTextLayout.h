//
//  RZTextLayout.h
//  RZColorful
//
//  Created by rztime on 2026/7/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZTextLine : NSObject

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) NSRange range;

- (instancetype)initWithRect:(CGRect)rect range:(NSRange)range;

@end

/// TextKit 富文本的布局计算
/// 注意：TextKit和UITextView一样，当 lineBreakMode 不等于0和1时，那么每一段只能显示一行，此时计算的位置会出错
@interface RZTextLayout : NSObject

@property (nonatomic, strong) NSMutableAttributedString *attributedString;
@property (nonatomic, strong, readonly) NSTextStorage *textStorage;
@property (nonatomic, strong, readonly) NSLayoutManager *layoutManager;
@property (nonatomic, strong, readonly) NSTextContainer *textContainer;

/// 全局共享实例（单例）
+ (instancetype)shared;

/// 初始化方法
/// @param attributedText 富文本
/// @param size 容器大小
/// @param maximumNumberOfLines 最大行数，0表示不限制
/// @param lineBreakMode 换行模式
- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText
                                  size:(CGSize)size
                   maximumNumberOfLines:(NSInteger)maximumNumberOfLines
                         lineBreakMode:(NSLineBreakMode)lineBreakMode;

/// UITextView时，可直接使用textView的textStorage、layoutManager、textContainer
/// @param textView UITextView实例
- (instancetype)initWithTextView:(UITextView *)textView;

/// 根据UILabel更新配置
- (void)updateByLabel:(UILabel *)label;

/// 更新两边边距
- (void)updateLineFragmentPadding:(CGFloat)padding;

// MARK: - 更新配置
/// 更新富文本
- (void)updateAttributedString:(nullable NSAttributedString *)attr;

/// 更新容器大小
- (void)updateSize:(CGSize)size;

/// 更新最大行数
- (void)updateNumberOfLines:(NSInteger)numberOfLines;

// MARK: - 布局计算
/// 文本实际位置
- (CGRect)usedRect;

/// 文本总区域位置
- (CGRect)textBoundsRect;

/// range字符位置（如果跨行，则是完全包围的位置）
- (CGRect)rectForCharacterRange:(NSRange)characterRange;

/// index对应的文本的位置
- (CGRect)rectForCharacterAtIndex:(NSInteger)index;

/// range（跨行）的实际位置，返回CGRect数组
- (NSArray<NSValue *> *)rectsForRange:(NSRange)range;

/// point位置对应的文本的index (NSRange.location)
- (nullable NSNumber *)characterIndexAtPoint:(CGPoint)point;

// MARK: - 行信息
/// 计算指定行数时的内容长度
/// 需注意最后一个字符为"\n"的情况
/// 因为这里计算的是maxLines时，textContainer包含的所有的字符串，那么\n也将被包含
/// 如：
/// 123\n
/// 456\n
/// 789\n
/// 那么3行的情况下，这里的所有的内容都将被包含在textContainer中，返回的length=12包含了最后的"\n"，这样的结果会导致实际显示的是4行
/// 解决方案是判断最后一个为\n时，在后面随机加一个字符串
- (NSInteger)lengthByMaxLines:(NSInteger)maxLines;

/// 是否超过行数
- (BOOL)moreThanLines:(NSInteger)maxLines;

/// 总行数
- (NSInteger)numberOfLines;

/// 每一行的信息
- (NSArray<RZTextLine *> *)lineFragments;

@end

NS_ASSUME_NONNULL_END
