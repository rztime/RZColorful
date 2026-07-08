//
//  RZImageAttachment.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZImageAttachment.h"
#import "NSAttributedString+RZColorful.h"
#import "NSString+RZCode.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored"-Wunused-variable"
  
@interface RZImageAttachment ()

/** 设置段落样式  */
@property (nonatomic, strong) RZParagraphStyle *paragraphStyle;
/** 阴影 */
@property (nonatomic, strong) RZShadow *shadow;
/**  */
@property (nonatomic, strong) RZColorfulAttribute *more;

@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation RZImageAttachment

- (NSMutableDictionary *)dict {
    if (!_dict) {
        _dict = [NSMutableDictionary new];
    }
    return _dict;
}

- (NSDictionary *)code {
    if (_hadParagraphStyle) {
        self.dict[NSParagraphStyleAttributeName] = [_paragraphStyle code];
    }
    if (_hadShadow) {
        self.dict[NSShadowAttributeName] = [_shadow code];
    }
    if (_more) {
        [self.dict addEntriesFromDictionary:[_more code]];
    }
    return self.dict.copy;
}

- (RZImageAttachment *(^)(CGRect bounds))bounds {
    return ^id (CGRect bounds) {
        self.imageBounds = bounds;
        return self;
    };
}

/**
 设置点击
 */
- (RZImageAttachment *(^)(NSURL *url))url {
    return ^id (NSURL *url) {
        self.dict[NSLinkAttributeName] = url;
        return self;
    };
}
/*
 给属性文本添加点击事件  只有UITextView可以用，且UITextView需要实现block  didTapTextView
 */
- (RZImageAttachment *(^)(NSString *tapId))tapAction {
    return ^id(NSString *tapId) {
        self.dict[RZTapActionAttributeName] = tapId.rz_encodedString;
        return self;
    };
}
/* 给属性文本添加点击事件  只有UITextView可以用，且UITextView需要实现block  didTapTextView  */
- (RZImageAttachment *(^)(ColorfulClickedRZ __nullable))clicked {
    return ^id(ColorfulClickedRZ clicked) {
        self.dict[RZClickedActionAttributeName] = clicked;
        return self;
    };
}
/* 给属性文本添加点击事件  只有UITextView可以用，且UITextView需要实现block  didTapTextView  */
- (RZImageAttachment *(^)(ColorfulBackgroundViewRZ __nullable))backgroundView {
    return ^id(ColorfulBackgroundViewRZ back) {
        self.dict[RZBackgroundViewAttributeName] = back;
        return self;
    };
}
/** 自定义属性和值 */
- (RZImageAttachment * (^)(NSAttributedStringKey key, id value))custom {
    return ^id(NSAttributedStringKey key, id value) {
        self.dict[key] = value;
        return self;
    };
}
/**
 水平对齐方式
 size(其中一个为0时，自适应)
 align 上，中，下
 refer 对齐的参考系 （前后的字体）
 */
- (RZImageAttachment *(^)(CGSize size, RZImageAttachmentHorizontalAlign align, UIFont *font))size {
    return ^id (CGSize size, RZImageAttachmentHorizontalAlign align, UIFont *font) {
        CGSize newSize = size;
        if (size.width == 0 && size.height == 0) {
            newSize = self.imageBounds.size;
        } else if (size.width == 0) {
            newSize.width = self.imageBounds.size.width / self.imageBounds.size.height * size.height;
        } else if (size.height == 0) {
            newSize.height = self.imageBounds.size.height * size.width / self.imageBounds.size.width;
        }
        CGFloat y = 0;
        CGFloat fontHeight = font.ascender - font.descender;
        switch (align) {
            case RZHorizontalAlignTop: {
                y = -(newSize.height - fontHeight) + font.descender;
                break;
            }
            case RZHorizontalAlignCenter: {
                y = -(newSize.height - fontHeight)/2.f + font.descender;
                break;
            }
            case RZHorizontalAlignBottom: {
                y = font.descender;
                break;
            }
            default:
                break;
        }
        self.imageBounds = CGRectMake(0, y, newSize.width, newSize.height);
        return self;
    };
}
/**
 y轴偏移量，在某些情况下，在对齐之后需要做上下偏移时，用此方法，请在设置size之后或者bounds之后使用
 */
- (RZImageAttachment *(^)(CGFloat yOffset))yOffset {
    return ^id (CGFloat yOffset) {
        self.imageBounds = ({
            CGRect bounds = self.imageBounds;
            bounds.origin.y -= yOffset;
            bounds;
        });
        return self;
    };
}
/**
 将bounds数据转换成html格式的语句
 
 @param imageUrl 图片url
 @return <#return value description#>
 */
- (NSString *)toHTMLStringWithImageUrl:(NSString *)imageUrl {
    NSString *width = @"";
    NSString *height = @"";
    if (_imageBounds.size.width > 0) {
        width = [NSString stringWithFormat:@"width:%fpx;", _imageBounds.size.width];
    }
    if (_imageBounds.size.height > 0) {
        height = [NSString stringWithFormat:@"height:%fpx;", _imageBounds.size.height];
    }
    NSString *html = [NSString stringWithFormat:@"<img style=\"%@%@\" src=\"%@\"/>", width, height, imageUrl];
    return html;
}

/**
 段落样式，具体设置请看 RZParagraphStyle.h
 
 @return <#return value description#>
 */
- (RZParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[RZParagraphStyle alloc] initWithAttach:self];
        _hadParagraphStyle = YES;
    }
    return _paragraphStyle;
}

- (RZShadow *)shadow {
    if (!_shadow) {
        _shadow = [[RZShadow alloc] initWithAttach:self];
        _hadShadow = YES;
    }
    return _shadow;
}
- (RZColorfulAttribute *)more {
    if (!_more) {
        _more = [[RZColorfulAttribute alloc] init];
    }
    return _more;
}
@end

@implementation NSTextAttachment (RZCustomView)

static const char *kCustomViewKey = "kCustomViewKey";

- (UIView *)customView {
    return objc_getAssociatedObject(self, kCustomViewKey);
}

- (void)setCustomView:(UIView *)customView {
    objc_setAssociatedObject(self, kCustomViewKey, customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIImage (RZEmptyImage)

+ (UIImage *)rz_transparentImage {
    static UIImage *transparentImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize size = CGSizeMake(1, 1);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        transparentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return transparentImage;
}

@end
#pragma clang diagnostic pop
