//
//  RZAttribute.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulAttribute.h"

@implementation RZColorfulAttribute

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
        weakSelf.textColor = textColor;
        return self;
    };
}

- (void)setTextColor:(UIColor *)textColor {
    UIColor *_textColor = textColor.copy;
    if (_textColor == nil) {
        _textColor = [UIColor clearColor];
    }
    [_colorfuls setObject:_textColor forKey:NSForegroundColorAttributeName];
}


/**
 设置字体
 */
- (RZColorfulAttribute *(^)(UIFont *font))font {
    __weak typeof(self) weakSelf = self;
    return ^id(UIFont *font) {
        weakSelf.font = font;
        return self;
    };
}
- (void)setFont:(UIFont *)font {
    UIFont *_font = font.copy;
    if (_font == nil) {
        return ;
    }
    [_colorfuls setObject:font forKey:NSFontAttributeName];
}


/**
 设置文字背景颜色
 */
- (RZColorfulAttribute *(^)(UIColor *backgroundColor))backgroundColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *backgroundColor) {
        weakSelf.backgroundColor = backgroundColor;
        return self;
    };
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    UIColor *bgColor = backgroundColor.copy;
    if (!bgColor) {
        bgColor = [UIColor clearColor];
    }
    [_colorfuls setObject:bgColor forKey:NSBackgroundColorAttributeName];
}

/**
 设置连体字，value = 0,没有连体， =1，有连体
 */
- (RZColorfulAttribute *(^)(NSNumber *ligature))ligature {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *ligature) {
        weakSelf.ligature = ligature;
        return self;
    };
}

- (void)setLigature:(NSNumber *)ligature {
    [_colorfuls setObject:ligature forKey:NSLigatureAttributeName];
}


/**
 字间距 >0 加宽  < 0减小间距
 */
- (RZColorfulAttribute *(^)(NSNumber *wordSpace))wordSpace {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *wordSpace) {
        weakSelf.wordSpace = wordSpace;
        return self;
    };
}
- (void)setWordSpace:(NSNumber *)wordSpace {
    [_colorfuls setObject:wordSpace forKey:NSKernAttributeName];
}

/**
 删除线
 */
- (RZColorfulAttribute *(^)(RZLineStyle strikeThrough))strikeThrough {
    __weak typeof(self)weakSelf = self;
    return ^id (RZLineStyle strikeThrough) {
        weakSelf.strikeThrough = strikeThrough;
        return self;
    };
}
- (void)setStrikeThrough:(RZLineStyle)strikeThrough {
    [_colorfuls setObject:@(strikeThrough) forKey:NSStrikethroughStyleAttributeName];
}

/**
 删除线颜色
 */
- (RZColorfulAttribute *(^)(UIColor *strikeThroughColor))strikeThroughColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *strikeThroughColor) {
        weakSelf.strikeThroughColor = strikeThroughColor;
        return self;
    };
}

- (void)setStrikeThroughColor:(UIColor *)strikeThroughColor {
    UIColor *_color = strikeThroughColor.copy;
    if (!_color) {
        _color = [UIColor clearColor];
    }
    [_colorfuls setObject:_color forKey:NSStrikethroughColorAttributeName];
}


/**
 下划线样式
 */
- (RZColorfulAttribute *(^)(RZLineStyle underLineStyle))underLineStyle {
    __weak typeof(self)weakSelf = self;
    return ^id (RZLineStyle underLineStyle) {
        weakSelf.underLineStyle = underLineStyle;
        return self;
    };
}

- (void)setUnderLineStyle:(RZLineStyle)underLineStyle {
    [_colorfuls setObject:@(underLineStyle) forKey:NSUnderlineStyleAttributeName];
}

/**
 下划线颜色
 */
- (RZColorfulAttribute *(^)(UIColor *underLineColor))underLineColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *underLineColor) {
        weakSelf.underLineColor = underLineColor;
        return self;
    };
}

- (void)setUnderLineColor:(UIColor *)underLineColor {
    [_colorfuls setObject:underLineColor forKey:NSUnderlineColorAttributeName];
}

/**
 描边的颜色
 */
- (RZColorfulAttribute *(^)(UIColor *strokeColor))strokeColor {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *strokeColor) {
        weakSelf.strokeColor = strokeColor;
        return self;
    };
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    UIColor *_color = strokeColor.copy;
    if (!_color) {
        _color = [UIColor clearColor];
    }
    [_colorfuls setObject:_color forKey:NSStrokeColorAttributeName];
}
/**
 描边的笔画宽度 为3时，空心
 */
- (RZColorfulAttribute *(^)(NSNumber *strokeWidth))strokeWidth {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *strokeWidth) {
        weakSelf.strokeWidth = strokeWidth;
        return self;
    };
}

- (void)setStrokeWidth:(NSNumber *)strokeWidth {
    [_colorfuls setObject:strokeWidth forKey:NSStrokeWidthAttributeName];
}

/**
 横竖排版 0：横版 1：竖版
 */
- (RZColorfulAttribute *(^)(NSNumber *verticalGlyphForm))verticalGlyphForm {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *verticalGlyphForm) {
        weakSelf.verticalGlyphForm = verticalGlyphForm;
        return self;
    };
}

- (void)setVerticalGlyphForm:(NSNumber *)verticalGlyphForm {
    [_colorfuls setObject:verticalGlyphForm forKey:NSVerticalGlyphFormAttributeName];
}

/**
 斜体字
 */
- (RZColorfulAttribute *(^)(NSNumber *italic))italic {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *italic) {
        weakSelf.italic = italic;
        return self;
    };
}
- (void)setItalic:(NSNumber *)italic {
    [_colorfuls setObject:italic forKey:NSObliquenessAttributeName];
}

/**
 扩张，即拉伸文字 >0 拉伸 <0压缩
 */
- (RZColorfulAttribute *(^)(NSNumber *expansion))expansion {
    __weak typeof(self)weakSelf = self;
    return ^id (NSNumber *expansion) {
        weakSelf.expansion = expansion;
        return self;
    };
}
- (void)setExpansion:(NSNumber *)expansion {
    [_colorfuls setObject:expansion forKey:NSExpansionAttributeName];
}

/**
 给文本添加链接，并且可点击跳转浏览器打开
 */
- (RZColorfulAttribute *(^)(NSURL *url))url {
    __weak typeof(self)weakSelf = self;
    return ^id (NSURL *url) {
        weakSelf.url = url;
        return self;
    };
}

- (void)setUrl:(NSURL *)url {
    NSURL *_url = url.copy;
    if (!_url || _url.absoluteString.length == 0) {
        _url = [NSURL URLWithString:@""];
    }
    [_colorfuls setObject:_url forKey:NSLinkAttributeName ];
}

// 阴影
- (RZShadow *)shadow {
    RZShadow * _shadow = [[RZShadow alloc]init];
    _shadow.colorfulsAttr = self;
    return _shadow;
}

/**  FIXME:段落样式还未完成
 设置段落样式
 */
- (RZColorfulAttribute *(^)(NSMutableParagraphStyle *paragraphStyle))paragraphStyle {
    __weak typeof(self)weakSelf = self;
    return ^id (NSMutableParagraphStyle *paragraphStyle) {
        weakSelf.paragraphStyle = paragraphStyle;
        return self;
    };
}

- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle {

}

@end
