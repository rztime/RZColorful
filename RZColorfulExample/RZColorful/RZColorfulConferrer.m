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
        NSString *text = _texts[i];
        NSMutableDictionary *colorful = ((RZColorfulAttribute *)_colorfuls[i]).colorfuls.copy;
        NSAttributedString *textattr = [[NSAttributedString alloc]initWithString:text attributes:colorful];
        if ([colorful.allKeys containsObject:@"NSLink"]) {
            NSMutableAttributedString *urlString = [[NSMutableAttributedString alloc]initWithAttributedString:textattr];
            [urlString addAttribute:NSLinkAttributeName value:[colorful objectForKey:@"NSLink"] range:NSMakeRange(0, urlString.length)];
            textattr = urlString.copy;
        }
        [string appendAttributedString:textattr];
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
