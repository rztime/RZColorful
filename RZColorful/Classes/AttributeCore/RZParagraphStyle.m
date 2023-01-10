//
//  RZParagraphStyle.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/31.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZParagraphStyle.h"
#import "RZColorfulAttribute.h"

@interface RZMutableParagraphStyle()

@end

@implementation RZMutableParagraphStyle

+ (RZMutableParagraphStyle *)copyWith:(RZMutableParagraphStyle *)para {
    RZMutableParagraphStyle *style = [[RZMutableParagraphStyle alloc] init];
    [style setParagraphStyle:para];
    style.numberOfLines = para.numberOfLines;
    style.textDrawMaxWidth = para.textDrawMaxWidth;
    style.truncateText = para.truncateText;
    return style;
}
@end

@interface RZParagraphStyle ()

@property (nonatomic, strong) RZMutableParagraphStyle *paragraph;
@property (nonatomic, weak) RZColorfulAttribute *colorfulsAttr;
@property (nonatomic, weak) RZImageAttachment *imageAttach;

@end

@implementation RZParagraphStyle

- (instancetype)initWithAttr:(RZColorfulAttribute *)attr {
    if (self = [super init]) {
        self.colorfulsAttr = attr;
    }
    return self;
}

- (instancetype)initWithAttach:(RZImageAttachment *)attach {
    if (self = [super init]) {
        self.imageAttach = attach;
    }
    return self;
}
 
- (RZColorfulAttribute *)and {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)with {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)end {
    return _colorfulsAttr;
}

/**
 连接词 如果阴影设置完毕，还想继续设置其他图片附件的信息，请使用andAttach，withAttach，endAttach，之后可以连接设置其他属性
 
 @return <#return value description#>
 */
- (RZImageAttachment *)andAttach {
    return _imageAttach;
}
- (RZImageAttachment *)withAttach {
    return _imageAttach;
}
- (RZImageAttachment *)endAttach {
    return _imageAttach;
}
- (RZMutableParagraphStyle *)code {
    if (_paragraph) {
        RZMutableParagraphStyle *p = [RZMutableParagraphStyle copyWith:_paragraph];
        return p;
    }
    return nil;
}

- (RZMutableParagraphStyle *)paragraph {
    if (!_paragraph) {
        _paragraph = [[RZMutableParagraphStyle alloc] init]; 
    }
    return _paragraph;
}

- (RZParagraphStyle *(^)(CGFloat))lineSpacing {
    return ^id (CGFloat lineSpacing) {
        self.paragraph.lineSpacing = lineSpacing;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))paragraphSpacing {
    return ^id (CGFloat paragraphSpacing) {
        self.paragraph.paragraphSpacing = paragraphSpacing;
        return self;
    };
}

- (RZParagraphStyle *(^)(NSTextAlignment))alignment {
    return ^id (NSTextAlignment alignment) {
        self.paragraph.alignment = alignment;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))firstLineHeadIndent {
    return ^id (CGFloat firstLineHeadIndent) {
        self.paragraph.firstLineHeadIndent = firstLineHeadIndent;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))headIndent {
    return ^id (CGFloat headIndent) {
        self.paragraph.headIndent = headIndent;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))tailIndent {
    return ^id (CGFloat tailIndent) {
        self.paragraph.tailIndent = tailIndent;
        return self;
    };
}

- (RZParagraphStyle *(^)(NSLineBreakMode))lineBreakMode {
    return ^id (NSLineBreakMode lineBreakMode) {
        self.paragraph.lineBreakMode = lineBreakMode;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))minimumLineHeight {
    return ^id (CGFloat minimumLineHeight) {
        self.paragraph.minimumLineHeight = minimumLineHeight;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))maximumLineHeight {
    return ^id (CGFloat maximumLineHeight) {
        self.paragraph.maximumLineHeight = maximumLineHeight;
        return self;
    };
}

- (RZParagraphStyle *(^)(NSWritingDirection))baseWritingDirection {
    return ^id (NSWritingDirection baseWritingDirection) {
        self.paragraph.baseWritingDirection = baseWritingDirection;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))lineHeightMultiple {
    return ^id (CGFloat lineHeightMultiple) {
        self.paragraph.lineHeightMultiple = lineHeightMultiple;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))paragraphSpacingBefore {
    return ^id (CGFloat paragraphSpacingBefore) {
        self.paragraph.paragraphSpacingBefore = paragraphSpacingBefore;
        return self;
    };
}

- (RZParagraphStyle *(^)(float))hyphenationFactor {
    return ^id (float hyphenationFactor) {
        self.paragraph.hyphenationFactor = hyphenationFactor;
        return self;
    };
}

- (RZParagraphStyle *(^)(CGFloat))defaultTabInterval {
    return ^id (CGFloat defaultTabInterval) {
        self.paragraph.defaultTabInterval = defaultTabInterval;
        return self;
    };
}

- (RZParagraphStyle *(^)(BOOL))allowsDefaultTighteningForTruncation {
    return ^id (BOOL allowsDefaultTighteningForTruncation) {
        self.paragraph.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation;
        return self;
    };
}
- (RZParagraphStyle *(^)(NSInteger numberOfLines, CGFloat maxWidth, NSAttributedString *truncateText))numberOfLines {
    return ^id (NSInteger numberOfLines, CGFloat maxWidth, NSAttributedString *truncateText) {
        self.paragraph.numberOfLines = numberOfLines;
        self.paragraph.textDrawMaxWidth = maxWidth;
        self.paragraph.truncateText = truncateText;
        return self;
    };
}
@end
