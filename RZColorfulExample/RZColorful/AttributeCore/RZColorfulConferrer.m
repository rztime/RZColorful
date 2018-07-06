//
//  RZAttributedMaker.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulConferrer.h"
#import "NSAttributedString+RZColorful.h"

#define rzColorPlainText        @"rzColorPlainText"  // 普通文本
#define rzColorImageText        @"rzColorImageText"  // 图片文本
#define rzColorHTMLText         @"rzColorHTMLText"    // 网页文本
#define rzColorImageUrlText     @"rzColorImageUrlText"  // 只有url的图片

@interface RZColorfulConferrer()

@property (nonatomic, strong) NSMutableArray *texts;
@property (nonatomic, strong) NSMutableArray *colorfuls;
@property (nonatomic, strong) RZParagraphStyle *paragraphStyle;
@property (nonatomic, strong) RZShadow       *shadow;
@end

@implementation RZColorfulConferrer

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (NSAttributedString *)confer {
     NSMutableAttributedString *string = [[NSMutableAttributedString alloc]init];

    for (int i = 0; i < _texts.count; i++) {
        id text = _texts[i];
        id colorful = _colorfuls[i];
        NSString *key = [[(NSDictionary *)text allKeys] firstObject];
        id value = [text objectForKey:key];
        if ([key isEqualToString:rzColorPlainText]) {  // 普通文本
            if ([value length] == 0) {
                continue;
            }
            RZColorfulAttribute * colorfulTmp = (RZColorfulAttribute *)colorful;
            if (colorfulTmp.rzShadow) {
                [colorfulTmp.colorfuls setObject:colorfulTmp.rzShadow forKey:NSShadowAttributeName];
            } else if (_shadow) {
                [colorfulTmp.colorfuls setObject:_shadow.shadow forKey:NSShadowAttributeName];
            }

            if (colorfulTmp.rzParagraph) {
                [colorfulTmp.colorfuls setObject:colorfulTmp.rzParagraph forKey:NSParagraphStyleAttributeName];
            } else if(_paragraphStyle){
                [colorfulTmp.colorfuls setObject:_paragraphStyle.paragraph forKey:NSParagraphStyleAttributeName];
            }

            NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:value attributes:colorfulTmp.colorfuls];
            [string appendAttributedString:attrText];
        } else if ([key isEqualToString:rzColorImageText]) { // 图片文本
            if (!value) {
                continue;
            }
            NSTextAttachment *attchment = [[NSTextAttachment alloc] init];
            attchment.image = value;
            attchment.bounds = ((RZImageAttachment *)colorful).imageBounds;
            NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:attchment].mutableCopy;
            
            RZParagraphStyle *style = [(RZImageAttachment *)colorful rz_paragraphStyle];
            if (style) {
                [imageString addAttributes:@{NSParagraphStyleAttributeName:style.paragraph} range:NSMakeRange(0, imageString.length)];
            } else if(_paragraphStyle){
                [imageString addAttributes:@{NSParagraphStyleAttributeName:_paragraphStyle.paragraph} range:NSMakeRange(0, imageString.length)];
            }
            
            [string appendAttributedString:imageString];
        } else if ([key isEqualToString:rzColorHTMLText]) { // 网页文本
            if ([value length] == 0) {
                continue;
            }
            [string appendAttributedString:[NSAttributedString htmlString:value]];
        } else if ([key isEqualToString:rzColorImageUrlText]) {  // 通过url添加图片
            if ([value length] == 0) {
                continue;
            }
            NSString *html = [((RZImageAttachment *)colorful) toHTMLStringWithImageUrl:value];
            NSMutableAttributedString *imageString = [NSAttributedString htmlString:html].mutableCopy;
            
            RZParagraphStyle *style = [(RZImageAttachment *)colorful rz_paragraphStyle];
            if (style) {
                [imageString addAttributes:@{NSParagraphStyleAttributeName:style.paragraph} range:NSMakeRange(0, imageString.length)];
            } else if(_paragraphStyle){
                [imageString addAttributes:@{NSParagraphStyleAttributeName:_paragraphStyle.paragraph} range:NSMakeRange(0, imageString.length)];
            }
            [string appendAttributedString:imageString];
        }
    }
    [self.texts removeAllObjects];
    [self.colorfuls removeAllObjects];

    return string.copy;
}

- (RZColorfulAttribute *(^)(NSString *text))text{
    __weak typeof(self) weakSelf = self;
    return ^id(NSString *text) {
        weakSelf.text = text;
        RZColorfulAttribute *colorful = [[RZColorfulAttribute alloc]init];
        [weakSelf.colorfuls addObject:colorful];
        return colorful;
    };
}

- (void)setText:(NSString *)text {
    NSString *_text = text.copy;
    if (!_text || _text.length == 0) {
        _text = @"";
    }
    [self.texts addObject:@{rzColorPlainText: _text}];
}

/**
 添加html格式的内容
 */
- (void (^)(NSString *htmlText))htmlText {
    __weak typeof(self) weakSelf = self;
    return ^void (NSString *htmlText) {
        weakSelf.htmlText = htmlText;
        [weakSelf.colorfuls addObject:@{rzColorHTMLText:@"htmlText"}];
        return ;
    };
}
- (void)setHtmlText:(NSString *)htmlText {
    NSString *html = htmlText.copy;
    if (!html || html.length == 0) {
        html = @"";
    }
    [self.texts addObject:@{rzColorHTMLText:html}];
}

- (RZImageAttachment *(^)(UIImage *appendImage))appendImage {
    __weak typeof(self) weakSelf = self;
    return ^id (UIImage *appendImage){
        weakSelf.appendImage = appendImage;
        RZImageAttachment *imageAttachement = [[RZImageAttachment alloc]init];
        [weakSelf.colorfuls addObject:imageAttachement];
        return imageAttachement;
    };
}

- (void)setAppendImage:(UIImage *)appendImage {
    UIImage *image = appendImage.copy;
    if (!image) {
        image = [UIImage new];
    }
    [self.texts addObject:@{rzColorImageText: image}];
}

/**
 通过url添加图片
 */
- (RZImageAttachment *(^)(NSString * _Nullable imageUrl))appendImageByUrl {
    __weak typeof(self) weakSelf = self;
    return ^id (NSString *imageUrl){
        weakSelf.appendImageByUrl = imageUrl;
        RZImageAttachment *imageAttachement = [[RZImageAttachment alloc]init];
        [weakSelf.colorfuls addObject:imageAttachement];
        return imageAttachement;
    };
}

- (void)setAppendImageByUrl:(NSString *)imageUrl {
    if (imageUrl.length == 0) {
        imageUrl = @"";
    }
    [self.texts addObject:@{rzColorImageUrlText: imageUrl}];
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

- (NSMutableArray *)texts {
    if (!_texts) {
        _texts = [NSMutableArray new];
    }
    return _texts;
}

- (NSMutableArray *)colorfuls {
    if (!_colorfuls) {
        _colorfuls = [NSMutableArray new];
    }
    return _colorfuls;
}

#pragma clang diagnostic pop

@end
