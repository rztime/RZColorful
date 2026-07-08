//
//  RZTextLayout.m
//  RZColorful
//
//  Created by rztime on 2026/7/6.
//

#import "RZTextLayout.h"

@implementation RZTextLine

- (instancetype)initWithRect:(CGRect)rect range:(NSRange)range {
    self = [super init];
    if (self) {
        _rect = rect;
        _range = range;
    }
    return self;
}

@end


@interface RZTextLayout ()

@end

@implementation RZTextLayout

#pragma mark - 初始化方法

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText
                                  size:(CGSize)size
                   maximumNumberOfLines:(NSInteger)maximumNumberOfLines
                         lineBreakMode:(NSLineBreakMode)lineBreakMode {
    self = [super init];
    if (self) {
        _attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
        _textStorage = [[NSTextStorage alloc] initWithAttributedString:_attributedString];
        _layoutManager = [[NSLayoutManager alloc] init];
        _textContainer = [[NSTextContainer alloc] initWithSize:size];
        _textContainer.maximumNumberOfLines = maximumNumberOfLines;
        _textContainer.lineBreakMode = lineBreakMode;
        _textContainer.lineFragmentPadding = 0;
        
        [_textStorage addLayoutManager:_layoutManager];
        [_layoutManager addTextContainer:_textContainer];
    }
    return self;
}
/// 全局共享实例（单例）
+ (instancetype)shared {
    static RZTextLayout *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RZTextLayout alloc] initWithAttributedText:[[NSAttributedString alloc] init]
                                                         size:CGSizeZero
                                         maximumNumberOfLines:0
                                                lineBreakMode:NSLineBreakByWordWrapping];
    });
    return instance;
}

- (instancetype)initWithTextView:(UITextView *)textView {
    self = [super init];
    if (self) {
        _attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
        _textStorage = textView.textStorage;
        _layoutManager = textView.layoutManager;
        _textContainer = textView.textContainer;
    }
    return self;
}

#pragma mark - 更新配置

- (void)updateByLabel:(UILabel *)label {
    [self updateAttributedString:label.attributedText];
    [self updateSize:label.bounds.size];
    [self updateNumberOfLines:label.numberOfLines];
}

- (void)updateLineFragmentPadding:(CGFloat)padding {
    if (self.textContainer.lineFragmentPadding != padding) {
        self.textContainer.lineFragmentPadding = padding;
    }
}

- (void)updateAttributedString:(NSAttributedString *)attr {
    NSAttributedString *newAttr = attr ?: [[NSAttributedString alloc] init];
    if (![newAttr isEqualToAttributedString:self.attributedString]) {
        [self.attributedString setAttributedString:newAttr];
        [self.textStorage setAttributedString:self.attributedString];
    }
}

- (void)updateSize:(CGSize)size {
    if (!CGSizeEqualToSize(self.textContainer.size, size)) {
        self.textContainer.size = size;
    }
}

- (void)updateNumberOfLines:(NSInteger)numberOfLines {
    if (self.textContainer.maximumNumberOfLines != numberOfLines) {
        self.textContainer.maximumNumberOfLines = numberOfLines;
    }
}

#pragma mark - 布局计算

- (CGRect)usedRect {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    return [self.layoutManager usedRectForTextContainer:self.textContainer];
}

- (CGRect)textBoundsRect {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    return [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
}

- (CGRect)rectForCharacterRange:(NSRange)characterRange {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSRange glyphRange = [self.layoutManager glyphRangeForCharacterRange:characterRange actualCharacterRange:NULL];
    return [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
}

- (CGRect)rectForCharacterAtIndex:(NSInteger)index {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSRange glyphRange = NSMakeRange(index, 1);
    return [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
}

- (NSArray<NSValue *> *)rectsForRange:(NSRange)range {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSRange glyphRange = [self.layoutManager glyphRangeForCharacterRange:range actualCharacterRange:NULL];
    
    NSMutableArray<NSValue *> *rects = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    [self.layoutManager enumerateLineFragmentsForGlyphRange:glyphRange usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange lineGlyphRange, BOOL *stop) {
        NSRange intersection = NSIntersectionRange(lineGlyphRange, glyphRange);
        if (intersection.length > 0) {
            CGRect characterRect = [weakSelf.layoutManager boundingRectForGlyphRange:intersection inTextContainer:weakSelf.textContainer];
            [rects addObject:[NSValue valueWithCGRect:characterRect]];
        }
    }];
    return [rects copy];
}

- (NSNumber *)characterIndexAtPoint:(CGPoint)point {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSUInteger index = [self.layoutManager characterIndexForPoint:point inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    if (index >= self.textStorage.length) {
        return nil;
    }
    CGRect rect = [self rectForCharacterAtIndex:index];
    return CGRectContainsPoint(rect, point) ? @(index) : nil;
}

#pragma mark - 行信息

- (NSInteger)lengthByMaxLines:(NSInteger)maxLines {
    [self updateNumberOfLines:maxLines];
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    return glyphRange.length;
}

- (BOOL)moreThanLines:(NSInteger)maxLines {
    return self.layoutManager.numberOfGlyphs > [self lengthByMaxLines:maxLines];
}

- (NSInteger)numberOfLines {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    __block NSInteger count = 0;
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    [self.layoutManager enumerateLineFragmentsForGlyphRange:glyphRange usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange lineGlyphRange, BOOL *stop) {
        count++;
    }];
    return count;
}

- (NSArray<RZTextLine *> *)lineFragments {
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    NSMutableArray<RZTextLine *> *result = [NSMutableArray array];
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    
    [self.layoutManager enumerateLineFragmentsForGlyphRange:glyphRange usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange lineGlyphRange, BOOL *stop) {
        NSRange charRange = [self.layoutManager characterRangeForGlyphRange:lineGlyphRange actualGlyphRange:NULL];
        RZTextLine *line = [[RZTextLine alloc] initWithRect:rect range:charRange];
        [result addObject:line];
    }];
    return [result copy];
}

@end
