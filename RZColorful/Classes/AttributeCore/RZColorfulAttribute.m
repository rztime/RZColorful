//
//  RZAttribute.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulAttribute.h"
#import "NSString+RZCode.h"
 
@interface RZColorfulAttribute ()

@property (nonatomic, strong) NSMutableDictionary *colorfuls;
@property (nonatomic, strong) RZShadow *shadow;
@property (nonatomic, strong) RZParagraphStyle *paragraphStyle;

@end

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
- (NSDictionary *)code {
    if (_hadShadow) {
        [self.colorfuls setObject:[_shadow code] forKey:NSShadowAttributeName];
    }
    if (_hadParagraphStyle) {
        [self.colorfuls setObject:[_paragraphStyle code] forKey:NSParagraphStyleAttributeName];
    }
    return _colorfuls.copy;
}
/** 设置文本颜色 */
- (RZColorfulAttribute * (^) (UIColor *)) textColor {
    return ^id(UIColor *textColor) {
        self.colorfuls[NSForegroundColorAttributeName] = textColor;
        return self;
    };
}
/** 设置字体 */
- (RZColorfulAttribute *(^)(UIFont *))font {
    return ^id(UIFont *font) {
        self.colorfuls[NSFontAttributeName] = font;
        return self;
    };
}
/** 设置文字背景颜色 */
- (RZColorfulAttribute *(^)(UIColor *))backgroundColor {
    return ^id (UIColor *backgroundColor) {
        self.colorfuls[NSBackgroundColorAttributeName] = backgroundColor;
        return self;
    };
}
/** 设置连体字，value = 0,没有连体， =1，有连体 */
- (RZColorfulAttribute *(^)(NSNumber *))ligature {
    return ^id (NSNumber *ligature) {
        self.colorfuls[NSLigatureAttributeName] = ligature;
        return self;
    };
}
/** 字间距 >0 加宽  < 0减小间距 */
- (RZColorfulAttribute *(^)(NSNumber *))wordSpace {
    return ^id (NSNumber *wordSpace) {
        self.colorfuls[NSKernAttributeName] = wordSpace;
        return self;
    };
}
/** 删除线 */
- (RZColorfulAttribute *(^)(RZLineStyle))strikeThrough {
    return ^id (RZLineStyle strikeThrough) {
        self.colorfuls[NSStrikethroughStyleAttributeName] = @(strikeThrough);
        return self;
    };
}
/**  删除线颜色 */
- (RZColorfulAttribute *(^)(UIColor *))strikeThroughColor {
    return ^id (UIColor *strikeThroughColor) {
        self.colorfuls[NSStrikethroughColorAttributeName] = strikeThroughColor;
        return self;
    };
}
/** 下划线样式 */
- (RZColorfulAttribute *(^)(RZLineStyle))underLineStyle {
    return ^id (RZLineStyle underLineStyle) {
        self.colorfuls[NSUnderlineStyleAttributeName] = @(underLineStyle);
        return self;
    };
}
/** 下划线颜色  */
- (RZColorfulAttribute *(^)(UIColor *))underLineColor {
    return ^id (UIColor *underLineColor) {
        self.colorfuls[NSUnderlineColorAttributeName] = underLineColor;
        return self;
    };
}
/** 描边的颜色 */
- (RZColorfulAttribute *(^)(UIColor *))strokeColor {
    return ^id (UIColor *strokeColor) {
        self.colorfuls[NSStrokeColorAttributeName] = strokeColor;
        return self;
    };
}
/** 描边的笔画宽度 为3时，空心 */
- (RZColorfulAttribute *(^)(NSNumber *))strokeWidth {
    return ^id (NSNumber *strokeWidth) {
        self.colorfuls[NSStrokeWidthAttributeName] = strokeWidth;
        return self;
    };
}
/** 横竖排版 0：横版 1：竖版 */
- (RZColorfulAttribute *(^)(NSNumber *))verticalGlyphForm {
    return ^id (NSNumber *verticalGlyphForm) {
        self.colorfuls[NSVerticalGlyphFormAttributeName] = verticalGlyphForm;
        return self;
    };
}
/** 斜体字  */
- (RZColorfulAttribute *(^)(NSNumber *))italic {
    return ^id (NSNumber *italic) {
        self.colorfuls[NSObliquenessAttributeName] = italic;
        return self;
    };
}
/** 扩张，即拉伸文字 >0 拉伸 <0压缩 */
- (RZColorfulAttribute *(^)(NSNumber *))expansion {
    return ^id (NSNumber *expansion) {
        self.colorfuls[NSExpansionAttributeName] = expansion;
        return self;
    };
}
/** 上下标 */
- (RZColorfulAttribute *(^)(NSNumber *))baselineOffset {
    return ^id (NSNumber *baselineOffset) {
        self.colorfuls[NSBaselineOffsetAttributeName] = baselineOffset;
        return self;
    };
}
/** 书写方向 */
- (RZColorfulAttribute *(^)(RZWriteDirection))writingDirection {
    return ^id (RZWriteDirection rzwriteDirection) {
        NSInteger O = 0;
        NSInteger E = 0;
        if (@available(iOS 9.0, *)) {
            O = NSWritingDirectionOverride;
            E = NSWritingDirectionEmbedding;
        } else {
            O = NSTextWritingDirectionOverride;
            E = NSTextWritingDirectionEmbedding; 
        }
        id value;
        switch (rzwriteDirection) {
            case LRE:{
                value = @[@(NSWritingDirectionLeftToRight | E)];
                break;
            }
            case LRO:{
                value = @[@(NSWritingDirectionLeftToRight | O)];
                break;
            }
            case RLE:{
                value = @[@(NSWritingDirectionRightToLeft | E)];
                break;
            }
            case RLO:{
                value = @[@(NSWritingDirectionRightToLeft | O)];
                break;
            }
        } 
        self.colorfuls[NSWritingDirectionAttributeName] = value;
        return self;
    };
}
/** 特殊效果 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSTextEffectStyle))textEffect {
    return ^id (NSTextEffectStyle style) {
        self.colorfuls[NSTextEffectAttributeName] = style;
        return self;
    };
}
/** 自定义属性和值 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSAttributedStringKey _Nonnull, id __nullable))custom {
    return  ^id (NSAttributedStringKey key, id value) {
        self.colorfuls[key] = value;
        return self;
    };
}

/** 给文本添加链接，并且可点击跳转浏览器打开 */
- (RZColorfulAttribute *(^)(NSURL *))url {
    return ^id (NSURL *url) {
        self.colorfuls[NSLinkAttributeName] = url;
        return self;
    };
}
/* 给属性文本添加点击事件  只有UITextView可以用，且UITextView需要实现block  didTapTextView  */
- (RZColorfulAttribute *(^)(NSString *))tapAction {
    return ^id(NSString *tapId) {
        self.colorfuls[NSLinkAttributeName] = tapId.rz_encodedString;
        return self;
    };
}

NSAttributedStringKey const NSTapActionByLabelAttributeName = @"NSTapActionByLabel";

/* 给文本添加点击事件的id, 仅UILabel有效，需要实现label.rz_tapAction方法 */
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSString * __nullable))tapActionByLable {
    return  ^id (NSString *tapId) {
        self.colorfuls[NSTapActionByLabelAttributeName] = tapId.rz_encodedString;;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(NSInlinePresentationIntent))inlinePresentationIntent API_AVAILABLE(ios(15.0)) {
    return ^id(NSInlinePresentationIntent intent) {
        self.colorfuls[NSInlinePresentationIntentAttributeName] = @(intent);
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))alternateDescription API_AVAILABLE(ios(15.0)) {
    return ^id(id alternateDescription) {
        self.colorfuls[NSAlternateDescriptionAttributeName] = alternateDescription;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))imageURL API_AVAILABLE(ios(15.0)) {
    return ^id(id imageURL) {
        self.colorfuls[NSImageURLAttributeName] = imageURL;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))languageIdentifier API_AVAILABLE(ios(15.0)) {
    return ^id(id languageIdentifier) {
        self.colorfuls[NSLanguageIdentifierAttributeName] = languageIdentifier;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))replacementIndex API_AVAILABLE(ios(15.0)) {
    return ^id(id replacementIndex) {
        self.colorfuls[NSReplacementIndexAttributeName] = replacementIndex;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))morphology API_AVAILABLE(ios(15.0)) {
    return ^id(id morphology) {
        self.colorfuls[NSMorphologyAttributeName] = morphology;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))inflectionRule API_AVAILABLE(ios(15.0)) {
    return ^id(id inflectionRule) {
        self.colorfuls[NSInflectionRuleAttributeName] = inflectionRule;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))inflectionAlternative API_AVAILABLE(ios(15.0)) {
    return ^id(id inflectionAlternative) {
        self.colorfuls[NSInflectionAlternativeAttributeName] = inflectionAlternative;
        return self;
    };
}
- (RZColorfulAttribute * _Nonnull(^_Nonnull)(id __nullable))presentationIntentAttributeName API_AVAILABLE(ios(15.0)) {
    return ^id(id presentationIntentAttributeName) {
        self.colorfuls[NSPresentationIntentAttributeName] = presentationIntentAttributeName;
        return self;
    };
}

// 阴影
- (RZShadow *)shadow {
    if (!_shadow) { 
        _shadow = [[RZShadow alloc] initWithAttr:self];
        _hadShadow = YES;
    }
    return _shadow;
}
/** 段落样式，具体设置请看 RZParagraphStyle.h  */
- (RZParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[RZParagraphStyle alloc] initWithAttr:self]; 
        _hadParagraphStyle = YES;
    }
    return _paragraphStyle;
}

#pragma clang diagnostic pop
@end
