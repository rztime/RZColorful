//
//  RZParagraphStyle.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/31.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZParagraphStyle.h"
#import "RZColorfulAttribute.h"

@implementation RZParagraphStyle

- (RZColorfulAttribute *)and {
    _colorfulsAttr.rzParagraph = self.paragraph.copy;
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)with {
    _colorfulsAttr.rzParagraph = self.paragraph.copy;
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)end {
    _colorfulsAttr.rzParagraph = self.paragraph.copy;
    return _colorfulsAttr;
}

- (NSMutableParagraphStyle *)paragraph {
    if (!_paragraph) {
        _paragraph = [[NSMutableParagraphStyle alloc] init];
    }
    return _paragraph;
}

- (RZParagraphStyle *(^)(CGFloat lineSpacing))lineSpacing {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat lineSpacing) {
        weakSelf.lineSpacing = lineSpacing;
        return self;
    };
}
- (void)setLineSpacing:(CGFloat)lineSpacing {
    self.paragraph.lineSpacing = lineSpacing;
}

- (RZParagraphStyle *(^)(CGFloat paragraphSpacing))paragraphSpacing {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat paragraphSpacing) {
        weakSelf.paragraphSpacing = paragraphSpacing;
        return self;
    };
}
- (void)setParagraphSpacing:(CGFloat)paragraphSpacing {
    self.paragraph.paragraphSpacing = paragraphSpacing;
}

- (RZParagraphStyle *(^)(NSTextAlignment alignment))alignment {
    __weak typeof(self)weakSelf = self;
    return ^id (NSTextAlignment alignment) {
        weakSelf.alignment = alignment;
        return self;
    };
}
- (void)setAlignment:(NSTextAlignment)alignment {
    self.paragraph.alignment = alignment;
}

- (RZParagraphStyle *(^)(CGFloat firstLineHeadIndent))firstLineHeadIndent {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat firstLineHeadIndent) {
        weakSelf.firstLineHeadIndent = firstLineHeadIndent;
        return self;
    };
}

- (void)setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent {
    self.paragraph.firstLineHeadIndent = firstLineHeadIndent;
}

- (RZParagraphStyle *(^)(CGFloat headIndent))headIndent {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat headIndent) {
        weakSelf.headIndent = headIndent;
        return self;
    };
}
- (void)setHeadIndent:(CGFloat)headIndent {
    self.paragraph.headIndent = headIndent;
}

- (RZParagraphStyle *(^)(CGFloat tailIndent))tailIndent {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat tailIndent) {
        weakSelf.tailIndent = tailIndent;
        return self;
    };
}

- (void)setTailIndent:(CGFloat)tailIndent {
    self.paragraph.tailIndent = tailIndent;
}

- (RZParagraphStyle *(^)(NSLineBreakMode lineBreakMode))lineBreakMode {
    __weak typeof(self)weakSelf = self;
    return ^id (NSLineBreakMode lineBreakMode) {
        weakSelf.lineBreakMode = lineBreakMode;
        return self;
    };
}
- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    self.paragraph.lineBreakMode = lineBreakMode;
}

- (RZParagraphStyle *(^)(CGFloat minimumLineHeight))minimumLineHeight {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat minimumLineHeight) {
        weakSelf.minimumLineHeight = minimumLineHeight;
        return self;
    };
}
- (void)setMinimumLineHeight:(CGFloat)minimumLineHeight {
    self.paragraph.minimumLineHeight = minimumLineHeight;
}

- (RZParagraphStyle *(^)(CGFloat maximumLineHeight))maximumLineHeight {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat maximumLineHeight) {
        weakSelf.maximumLineHeight = maximumLineHeight;
        return self;
    };
}

- (void)setMaximumLineHeight:(CGFloat)maximumLineHeight {
    self.paragraph.maximumLineHeight = maximumLineHeight;
}

- (RZParagraphStyle *(^)(NSWritingDirection baseWritingDirection))baseWritingDirection {
    __weak typeof(self)weakSelf = self;
    return ^id (NSWritingDirection baseWritingDirection) {
        weakSelf.baseWritingDirection = baseWritingDirection;
        return self;
    };
}
- (void)setBaseWritingDirection:(NSWritingDirection)baseWritingDirection {
    self.paragraph.baseWritingDirection = baseWritingDirection;
}

- (RZParagraphStyle *(^)(CGFloat lineHeightMultiple))lineHeightMultiple {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat lineHeightMultiple) {
        weakSelf.lineHeightMultiple = lineHeightMultiple;
        return self;
    };
}
- (void)setLineHeightMultiple:(CGFloat)lineHeightMultiple {
    self.paragraph.lineHeightMultiple = lineHeightMultiple;
}

- (RZParagraphStyle *(^)(CGFloat paragraphSpacingBefore))paragraphSpacingBefore {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat paragraphSpacingBefore) {
        weakSelf.paragraphSpacingBefore = paragraphSpacingBefore;
        return self;
    };
}
- (void)setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore {
    self.paragraph.paragraphSpacingBefore = paragraphSpacingBefore;
}

- (RZParagraphStyle *(^)(float hyphenationFactor))hyphenationFactor {
    __weak typeof(self)weakSelf = self;
    return ^id (float hyphenationFactor) {
        weakSelf.hyphenationFactor = hyphenationFactor;
        return self;
    };
}
- (void)setHyphenationFactor:(float)hyphenationFactor {
    self.paragraph.hyphenationFactor = hyphenationFactor;
}

- (RZParagraphStyle *(^)(CGFloat defaultTabInterval))defaultTabInterval {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat defaultTabInterval) {
        weakSelf.defaultTabInterval = defaultTabInterval;
        return self;
    };
}
- (void)setDefaultTabInterval:(CGFloat)defaultTabInterval {
    self.paragraph.defaultTabInterval = defaultTabInterval;
}

- (RZParagraphStyle *(^)(BOOL allowsDefaultTighteningForTruncation))allowsDefaultTighteningForTruncation {
    __weak typeof(self)weakSelf = self;
    return ^id (BOOL allowsDefaultTighteningForTruncation) {
        weakSelf.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation;
        return self;
    };
}

- (void)setAllowsDefaultTighteningForTruncation:(BOOL)allowsDefaultTighteningForTruncation {
    self.paragraph.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation;
}

@end
