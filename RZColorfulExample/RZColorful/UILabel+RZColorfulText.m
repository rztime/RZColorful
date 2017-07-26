//
//  UILabel+RZColorfulText.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/23.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "UILabel+RZColorfulText.h"

@implementation UILabel (RZColorfulText)

- (void )rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))block {
    RZColorfulConferrer *conferrer = [[RZColorfulConferrer alloc]init];
    block(conferrer);
    self.attributedText = [conferrer confer];
}

- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer *confer))block {
    RZColorfulConferrer *conferrer = [[RZColorfulConferrer alloc]init];
    block(conferrer);
    NSAttributedString *conferrerColorful = [conferrer confer];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attr appendAttributedString:conferrerColorful];
    self.attributedText = attr.copy;
}

@end
