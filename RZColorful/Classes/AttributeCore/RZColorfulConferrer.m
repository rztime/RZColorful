//
//  RZAttributedMaker.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulConferrer.h"
#import "NSAttributedString+RZColorful.h"
#import "NSAttributedString+RZHtml.h"

#import <CoreGraphics/CGBase.h>

#define rzColorPlainText        @"rzColorPlainText"  // 普通文本
#define rzColorImageText        @"rzColorImageText"  // 图片文本
#define rzColorHTMLText         @"rzColorHTMLText"    // 网页文本
#define rzColorImageUrlText     @"rzColorImageUrlText"  // 只有url的图片

typedef NS_ENUM(NSInteger, RZColorfulAttributeBoxType) {
    RZColorfulAttributeBoxTypePlainText,
    RZColorfulAttributeBoxTypeImage,
    RZColorfulAttributeBoxTypeHTMLText,
    RZColorfulAttributeBoxTypeImageURL,
};

@interface RZColorfulAttributeBox : NSObject

@property (nonatomic, assign) RZColorfulAttributeBoxType type;
@property (nonatomic, copy)   NSString *text;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) RZImageAttachment *attach;
@property (nonatomic, strong) RZColorfulAttribute *attribute;

- (NSAttributedString *)package:(RZParagraphStyle *)para shadow:(RZShadow *)shadow;

@end

@implementation RZColorfulAttributeBox
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (NSAttributedString *)package:(RZParagraphStyle *)para shadow:(RZShadow *)shadow {
    NSMutableDictionary *dict = [self.attribute code].mutableCopy;
    if (!dict) {
        dict = NSMutableDictionary.new;
    }
    if (shadow && !self.attribute.hadShadow) {
        [dict setObject:[shadow code].copy forKey:NSShadowAttributeName];
    }
    if (para && !self.attribute.hadParagraphStyle) {
        [dict setObject:[para code].copy forKey:NSParagraphStyleAttributeName];
    }
    NSMutableAttributedString *text = NSMutableAttributedString.new;
    switch (self.type) {
        case RZColorfulAttributeBoxTypePlainText: {
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:self.text]];
            break;
        }
        case RZColorfulAttributeBoxTypeImage: {
            NSTextAttachment *attchment = [[NSTextAttachment alloc] init];
            attchment.image = self.image;
            attchment.bounds = self.attach.imageBounds;
            NSDictionary *c = [self.attach code];
            if (c) {
                [dict addEntriesFromDictionary:c];
            }
            [text appendAttributedString: [NSAttributedString attributedStringWithAttachment:attchment]];
            break;
        }
        case RZColorfulAttributeBoxTypeHTMLText: {
            [text appendAttributedString: [NSAttributedString htmlString:self.text]];
            break;
        }
        case RZColorfulAttributeBoxTypeImageURL: {
            NSString *html = [self.attach toHTMLStringWithImageUrl:self.text];
            NSAttributedString *imageString = [NSAttributedString htmlString:html].copy;
            NSDictionary *c = [self.attach code];
            if (c) {
                [dict addEntriesFromDictionary:c];
            }
            [text appendAttributedString:imageString];
            break;
        }
        default:
            break;
    }
    if (dict != nil) {
        [text addAttributes:dict range:NSMakeRange(0, text.length)];
    }
    return text;
}

@end

RZColorfulAttributeBox *RZ_ATTRIBUTEBOXBY(id content, RZColorfulAttributeBoxType type) {
    RZColorfulAttributeBox *box = [RZColorfulAttributeBox new];
    box.type = type;
    if (type == RZColorfulAttributeBoxTypePlainText || type == RZColorfulAttributeBoxTypeHTMLText) {
        box.attribute = [[RZColorfulAttribute alloc] init];
    } else {
        box.attach = [[RZImageAttachment alloc] init];
    }
    if ([content isKindOfClass:[NSString class]]) {
        box.text = content;
    } else if ([content isKindOfClass:[UIImage class]]) {
        box.image = content;
    }
    return box;
}

@interface RZColorfulConferrer()

@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) RZParagraphStyle *paragraphStyle;
@property (nonatomic, strong) RZShadow       *shadow;
 
@end

@implementation RZColorfulConferrer

- (NSAttributedString *)confer {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]init];
    for (RZColorfulAttributeBox *box in self.contents) {
        NSAttributedString *text = [box package:_paragraphStyle shadow:_shadow];
        RZMutableParagraphStyle *style = [text attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        if ([style isKindOfClass:[RZMutableParagraphStyle class]]) {
            if (style.numberOfLines > 0 && style.textDrawMaxWidth > 0) {
                NSAttributedString *placeholder = style.truncateText;
                if (!placeholder) {
                    placeholder = [text rz_copyAttributeToText:@"..."];
                }
                NSLineBreakMode mode = style.lineBreakMode;
                style.lineBreakMode = NSLineBreakByWordWrapping;
                NSAttributedString *temp = [text rz_attributedStringBy:style.numberOfLines maxWidth:style.textDrawMaxWidth lineBreakMode:mode placeHolder:placeholder];
                [string appendAttributedString:temp];
                continue;
            }
        }
        [string appendAttributedString:text];
    }
    return string.copy;
}

- (RZColorfulAttribute *(^)(NSString *))text{
    return ^id(NSString *text) {
        if (!text) {
            text = @"";
        }
        RZColorfulAttributeBox *box = RZ_ATTRIBUTEBOXBY(text, RZColorfulAttributeBoxTypePlainText);
        [self.contents addObject:box];
        return box.attribute;
    };
}

/**
 添加html格式的内容
 */
- (RZColorfulAttribute *(^)(NSString *))htmlText {
    return ^id (NSString *htmlText) {
        if (!htmlText) {
            htmlText = @"";
        }
        RZColorfulAttributeBox *box = RZ_ATTRIBUTEBOXBY(htmlText, RZColorfulAttributeBoxTypeHTMLText);
        [self.contents addObject:box];
        return box.attribute;
    };
}

- (RZImageAttachment *(^)(UIImage *))image {
    return ^id (UIImage *image){
        if (!image) {
            image = [[UIImage alloc] init];
        }
        RZColorfulAttributeBox *box = RZ_ATTRIBUTEBOXBY(image, RZColorfulAttributeBoxTypeImage);
        [self.contents addObject:box];
        return box.attach;
    };
}
/**
 通过url添加图片
 */
- (RZImageAttachment *(^)(NSString * _Nullable))imageByUrl {
    return ^id (NSString *imageUrl){
        if (!imageUrl) {
            imageUrl = @"";
        }
        RZColorfulAttributeBox *box = RZ_ATTRIBUTEBOXBY(imageUrl, RZColorfulAttributeBoxTypeImageURL);
        [self.contents addObject:box];
        return box.attach;
    };
}
/**
 设置当前控件对象统一段落样式
 */
- (RZParagraphStyle * _Nullable)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[RZParagraphStyle alloc] init];
    }
    return _paragraphStyle;
}


/**
 设置统一阴影对象

 @return <#return value description#>
 */
- (RZShadow * _Nullable)shadow {
    if (!_shadow) {
        _shadow = [[RZShadow alloc] init];
    }
    return _shadow;
}

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents = [NSMutableArray new];
    }
    return _contents;
}
#pragma clang diagnostic pop
@end
