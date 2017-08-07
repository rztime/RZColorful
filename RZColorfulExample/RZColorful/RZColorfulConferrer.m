//
//  RZAttributedMaker.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulConferrer.h"

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
        if ([text isKindOfClass:[NSString class]]) {
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

            NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text attributes:colorfulTmp.colorfuls];
            [string appendAttributedString:attrText];
        } else if ([text isKindOfClass:[UIImage class]]) {
            NSTextAttachment *attchment = [[NSTextAttachment alloc] init];
            attchment.image = text;
            attchment.bounds = ((RZImageAttachment *)colorful).imageBounds;
            [string appendAttributedString:[NSAttributedString attributedStringWithAttachment:attchment]];
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
    [self.texts addObject:_text];
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
    [self.texts addObject:image];
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
