//
//  RZAttribute.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulAttribute.h"

@implementation RZColorfulAttribute

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (instancetype)init {
    if (self = [super init]) {
        _colorfuls = [NSMutableDictionary new];
    }
    return self;
}

- (RZColorfulAttribute *)and {
    return self;
}
- (RZColorfulAttribute *)with {
    return self;
}

/**
 设置文本颜色
 */
- (RZColorfulAttribute * (^) (UIColor *)) textColor {
    __weak typeof(self) weakSelf = self;
    return ^id(UIColor *textColor) {
        if (!textColor) {
            textColor = [UIColor new];
        }
        [weakSelf.colorfuls setObject:textColor forKey:NSForegroundColorAttributeName];
        return self;
    };
}

/**
 设置字体
 */
- (RZColorfulAttribute *(^)(UIFont *font))font {
    __weak typeof(self) weakSelf = self;
    return ^id(UIFont *font) {
        if (!font) {
            font = [UIFont systemFontOfSize:17];
        }
        [weakSelf.colorfuls setObject:font forKey:NSFontAttributeName];
        return self;
    };
}

/**
 设置文字背景颜色
 */
- (RZColorfulAttribute *(^)(UIColor *backgroundColor))backgroundColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *backgroundColor) {
        if (!backgroundColor) {
            backgroundColor = [UIColor new];
        }
        [weakSelf.colorfuls setObject:backgroundColor forKey:NSBackgroundColorAttributeName];
        return self;
    };
}

/**
 设置连体字，value = 0,没有连体， =1，有连体
 */
- (RZColorfulAttribute *(^)(NSNumber *ligature))ligature {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *ligature) {
        [weakSelf.colorfuls setObject:ligature forKey:NSLigatureAttributeName];
        return self;
    };
}

/**
 字间距 >0 加宽  < 0减小间距
 */
- (RZColorfulAttribute *(^)(NSNumber *wordSpace))wordSpace {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *wordSpace) {
        [weakSelf.colorfuls setObject:wordSpace forKey:NSKernAttributeName];
        return self;
    };
}

/**
 删除线
 */
- (RZColorfulAttribute *(^)(RZLineStyle strikeThrough))strikeThrough {
    __weak typeof(self)weakSelf = self;
    return ^id (RZLineStyle strikeThrough) {
        [weakSelf.colorfuls setObject:@(strikeThrough) forKey:NSStrikethroughStyleAttributeName];
        return self;
    };
}

/**
 删除线颜色
 */
- (RZColorfulAttribute *(^)(UIColor *strikeThroughColor))strikeThroughColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *strikeThroughColor) {
        if (!strikeThroughColor) {
            strikeThroughColor = [UIColor clearColor];
        }
        [weakSelf.colorfuls setObject:strikeThroughColor forKey:NSStrikethroughColorAttributeName];
        return self;
    };
}

/**
 下划线样式
 */
- (RZColorfulAttribute *(^)(RZLineStyle underLineStyle))underLineStyle {
    __weak typeof(self)weakSelf = self;
    return ^id (RZLineStyle underLineStyle) {
        [weakSelf.colorfuls setObject:@(underLineStyle) forKey:NSUnderlineStyleAttributeName];
        return self;
    };
}

/**
 下划线颜色
 */
- (RZColorfulAttribute *(^)(UIColor *underLineColor))underLineColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *underLineColor) {
        if (!underLineColor) {
            underLineColor = [UIColor new];
        }
        [weakSelf.colorfuls setObject:underLineColor forKey:NSUnderlineColorAttributeName];
        return self;
    };
}

/**
 描边的颜色
 */
- (RZColorfulAttribute *(^)(UIColor *strokeColor))strokeColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *strokeColor) {
        if (!strokeColor) {
            strokeColor = [UIColor new];
        }
        [weakSelf.colorfuls setObject:strokeColor forKey:NSStrokeColorAttributeName];
        return self;
    };
}

/**
 描边的笔画宽度 为3时，空心
 */
- (RZColorfulAttribute *(^)(NSNumber *strokeWidth))strokeWidth {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *strokeWidth) {
        [weakSelf.colorfuls setObject:strokeWidth forKey:NSStrokeWidthAttributeName];
        return self;
    };
}

/**
 横竖排版 0：横版 1：竖版
 */
- (RZColorfulAttribute *(^)(NSNumber *verticalGlyphForm))verticalGlyphForm {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *verticalGlyphForm) {
        [weakSelf.colorfuls setObject:verticalGlyphForm forKey:NSVerticalGlyphFormAttributeName];
        return self;
    };
}

/**
 斜体字
 */
- (RZColorfulAttribute *(^)(NSNumber *italic))italic {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *italic) {
        [weakSelf.colorfuls setObject:italic forKey:NSObliquenessAttributeName];
        return self;
    };
}

/**
 扩张，即拉伸文字 >0 拉伸 <0压缩
 */
- (RZColorfulAttribute *(^)(NSNumber *expansion))expansion {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *expansion) {
        [weakSelf.colorfuls setObject:expansion forKey:NSExpansionAttributeName];
        return self;
    };
}
/**
 上下标
 */
- (RZColorfulAttribute *(^)(NSNumber *baselineOffset))baselineOffset {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *baselineOffset) {
        [weakSelf.colorfuls setObject:baselineOffset forKey:NSBaselineOffsetAttributeName];
        return self;
    };
}


/**
 书写方向
 */
- (RZColorfulAttribute *(^)(RZWriteDirection rzwriteDirection))writingDirection {
    __weak typeof(self)weakSelf = self;
    return ^id (RZWriteDirection rzwriteDirection) {
        id value;
        if (rzwriteDirection == RZWDLeftToRight) {
            if (@available(iOS 9.0, *)) {
                value = @[@(NSWritingDirectionLeftToRight | NSWritingDirectionOverride)];
            } else {
                // Fallback on earlier versions
                value = @[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionOverride)];
            }
        } else {
            if (@available(iOS 9.0, *)) {
                value = @[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)];
            } else {
                // Fallback on earlier versions
                value = @[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride)];
            }
        }
        [weakSelf.colorfuls setObject:value forKey:NSWritingDirectionAttributeName];
        return self;
    };
}
/**
 给文本添加链接，并且可点击跳转浏览器打开
 */
- (RZColorfulAttribute *(^)(NSURL *url))url {
    __weak typeof(self)weakSelf = self;
    return ^id (NSURL *url) {
        if (!url || url.absoluteString.length == 0) {
            url = [NSURL URLWithString:@""];
        }
        [weakSelf.colorfuls setObject:url forKey:NSLinkAttributeName];
        return self;
    };
}

// 阴影
- (RZShadow *)shadow {
    RZShadow * _shadow = [[RZShadow alloc]init];
    _shadow.colorfulsAttr = self;
    return _shadow;
}


/**
 段落样式，具体设置请看 RZParagraphStyle.h

 @return <#return value description#>
 */
- (RZParagraphStyle *)paragraphStyle {
    RZParagraphStyle *_paragraph = [[RZParagraphStyle alloc]init];
    _paragraph.colorfulsAttr = self;
    return _paragraph;
}
#pragma clang diagnostic pop
@end
