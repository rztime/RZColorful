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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored"-Wunused-variable"

#define RZTapActionId   @"RZTapActionId"
#define RZTapActionFunc @"RZTapActionFunc"

@interface RZImageAttachment ()

/** 设置段落样式  */
@property (nonatomic, strong) RZParagraphStyle *paragraphStyle;
/** 阴影 */
@property (nonatomic, strong) RZShadow *shadow;

@property (nonatomic, copy) id URL;

@end

@implementation RZImageAttachment

- (NSDictionary *)code {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if (_hadParagraphStyle) {
        dict[NSParagraphStyleAttributeName] = [_paragraphStyle code];
    }
    if (_hadShadow) {
        dict[NSShadowAttributeName] = [_shadow code];
    }
    if (_URL) {
        dict[NSLinkAttributeName] = _URL;
    }
    return dict;
}

- (RZImageAttachment *(^)(CGRect bounds))bounds {
    __weak typeof(self)weakSelf = self;
    return ^id (CGRect bounds) {
        weakSelf.imageBounds = bounds;
        return weakSelf;
    };
}

/**
 设置点击
 */
- (RZImageAttachment *(^)(NSURL *url))url {
    __weak typeof(self)weakSelf = self;
    return ^id (NSURL *url) {
        weakSelf.URL = url;
        return weakSelf;
    };
}
/*
 给属性文本添加点击事件  只有UITextView可以用，且UITextView需要实现block  didTapTextView
 */
- (RZImageAttachment *(^)(NSString *tapId))tapAction {
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *tapId) {
        weakSelf.URL = tapId.rz_encodedString;
        return weakSelf;
    };
}
/**
 水平对齐方式
 align 上，中，下
 refer 对齐的参考系 （前后的字体）
 */
- (RZImageAttachment *(^)(CGSize size, RZImageAttachmentHorizontalAlign align, UIFont *font))size {
    __weak typeof(self)weakSelf = self;
    return ^id (CGSize size, RZImageAttachmentHorizontalAlign align, UIFont *font) {
        CGFloat y = 0;
        CGFloat fontHeight = font.ascender - font.descender;
        switch (align) {
            case RZHorizontalAlignTop: {
                y = -(size.height - fontHeight) + font.descender;
                break;
            }
            case RZHorizontalAlignCenter: {
                y = -(size.height - fontHeight)/2.f + font.descender;
                break;
            }
            case RZHorizontalAlignBottom: {
                y = font.descender;
                break;
            }
            default:
                break;
        }
        weakSelf.imageBounds = CGRectMake(0, y, size.width, size.height);
        return weakSelf;
    };
}
/**
 y轴偏移量，在某些情况下，在对齐之后需要做上下偏移时，用此方法，请在设置size之后或者bounds之后使用
 */
- (RZImageAttachment *(^)(CGFloat yOffset))yOffset {
    __weak typeof(self) weakSelf = self;
    return ^id (CGFloat yOffset) {
        weakSelf.imageBounds = ({
            CGRect bounds = weakSelf.imageBounds;
            bounds.origin.y -= yOffset;
            bounds;
        });
        return weakSelf;
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
        _paragraphStyle = [[RZParagraphStyle alloc] init];
        _paragraphStyle.imageAttach = self;
        _hadParagraphStyle = YES;
    }
    return _paragraphStyle;
}

- (RZShadow *)shadow {
    if (!_shadow) {
        _shadow = [[RZShadow alloc] init];
        _shadow.imageAttach = self;
        _hadShadow = YES;
    }
    return _shadow;
}
#pragma clang diagnostic pop
@end
