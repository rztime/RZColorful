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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


- (RZColorfulAttribute *)and {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)with {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)end {
    return _colorfulsAttr;
}

- (NSMutableParagraphStyle *)paragraph {
    if (!_paragraph) {
        _paragraph = [[NSMutableParagraphStyle alloc] init];
        _colorfulsAttr.rzParagraph = _paragraph;
    }
    return _paragraph;
}

- (RZParagraphStyle *(^)(CGFloat lineSpacing))lineSpacing {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat lineSpacing) {
        weakSelf.paragraph.lineSpacing = lineSpacing;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat paragraphSpacing))paragraphSpacing {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat paragraphSpacing) {
        weakSelf.paragraph.paragraphSpacing = paragraphSpacing;
        return self;
    };
}

- (RZParagraphStyle *(^)(NSTextAlignment alignment))alignment {
    __weak typeof(self)weakSelf = self;
    return ^id (NSTextAlignment alignment) {
        weakSelf.paragraph.alignment = alignment;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat firstLineHeadIndent))firstLineHeadIndent {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat firstLineHeadIndent) {
        weakSelf.paragraph.firstLineHeadIndent = firstLineHeadIndent;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat headIndent))headIndent {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat headIndent) {
        weakSelf.paragraph.headIndent = headIndent;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat tailIndent))tailIndent {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat tailIndent) {
        weakSelf.paragraph.tailIndent = tailIndent;
        return self;
    };
}

- (RZParagraphStyle *(^)(NSLineBreakMode lineBreakMode))lineBreakMode {
    __weak typeof(self)weakSelf = self;
    return ^id (NSLineBreakMode lineBreakMode) {
        weakSelf.paragraph.lineBreakMode = lineBreakMode;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat minimumLineHeight))minimumLineHeight {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat minimumLineHeight) {
        weakSelf.paragraph.minimumLineHeight = minimumLineHeight;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat maximumLineHeight))maximumLineHeight {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat maximumLineHeight) {
        weakSelf.paragraph.maximumLineHeight = maximumLineHeight;
        return self;
    };
}

- (RZParagraphStyle *(^)(NSWritingDirection baseWritingDirection))baseWritingDirection {
    __weak typeof(self)weakSelf = self;
    return ^id (NSWritingDirection baseWritingDirection) {
        weakSelf.paragraph.baseWritingDirection = baseWritingDirection;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat lineHeightMultiple))lineHeightMultiple {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat lineHeightMultiple) {
        weakSelf.paragraph.lineHeightMultiple = lineHeightMultiple;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat paragraphSpacingBefore))paragraphSpacingBefore {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat paragraphSpacingBefore) {
        weakSelf.paragraph.paragraphSpacingBefore = paragraphSpacingBefore;
        return self;
    };
}

- (RZParagraphStyle *(^)(float hyphenationFactor))hyphenationFactor {
    __weak typeof(self)weakSelf = self;
    return ^id (float hyphenationFactor) {
        weakSelf.paragraph.hyphenationFactor = hyphenationFactor;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat defaultTabInterval))defaultTabInterval {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat defaultTabInterval) {
        weakSelf.paragraph.defaultTabInterval = defaultTabInterval;
        return self;
    };
}

- (RZParagraphStyle *(^)(BOOL allowsDefaultTighteningForTruncation))allowsDefaultTighteningForTruncation {
    __weak typeof(self)weakSelf = self;
    return ^id (BOOL allowsDefaultTighteningForTruncation) {
        weakSelf.paragraph.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation;
        return self;
    };
}

#pragma clang diagnostic pop

@end
