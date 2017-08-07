//
//  UITextView+RZColorfulText.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "UITextView+RZColorfulText.h"

@implementation UITextView (RZColorfulText)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (void )rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute {
    if(!attribute) {
        return ;
    }
    RZColorfulConferrer *conferrer = [[RZColorfulConferrer alloc]init];
    attribute(conferrer);
    self.attributedText = [conferrer confer];
}

- (void )rz_colorfulConferAppend:(void (^)(RZColorfulConferrer *confer))attribute {
    if(!attribute) {
        return ;
    }
    RZColorfulConferrer *conferrer = [[RZColorfulConferrer alloc]init];
    attribute(conferrer);
    NSAttributedString *conferrerColorful = [conferrer confer];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attr appendAttributedString:conferrerColorful];
    self.attributedText = attr.copy;
}

#pragma clang diagnostic pop
@end
