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

@end

@implementation RZColorfulConferrer

- (NSAttributedString *)confer {
     NSMutableAttributedString *string = [[NSMutableAttributedString alloc]init];

    for (int i = 0; i < _texts.count; i++) {
        id text = _texts[i];
        id colorful = _colorfuls[i];
        if ([text isKindOfClass:[NSString class]]) {
            RZColorfulAttribute * colorfulTmp = (RZColorfulAttribute *)colorful;

            NSURL *url = [colorfulTmp.colorfuls objectForKey:@"NSLink"];
            if (url) {
                [colorfulTmp.colorfuls removeObjectForKey:@"NSLink"];
            }
            if (colorfulTmp.rzShadow) {
                [colorfulTmp.colorfuls setObject:colorfulTmp.rzShadow forKey:NSShadowAttributeName];
            }
            NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text attributes:colorfulTmp.colorfuls];
            if (url) {
                [attrText addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, attrText.length)];
            }

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

@end
