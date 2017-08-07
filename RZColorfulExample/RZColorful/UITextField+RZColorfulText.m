//
//  UITextField+RZColorfulText.m
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "UITextField+RZColorfulText.h"

@implementation UITextField (RZColorfulText)

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

- (void)rz_colorfulWithParagraphStyle:(void (^)(RZParagraphStyle *))paragraph confer:(void (^)(RZColorfulConferrer *))attribute {
    RZParagraphStyle *paragraphStyle = nil;
    if (paragraph) {
        paragraphStyle = [[RZParagraphStyle alloc] init];
        paragraph(paragraphStyle);
    }
    if(!attribute) {
        return ;
    }
    RZColorfulConferrer *confferer = [[RZColorfulConferrer alloc] init];
    attribute(confferer);
    NSMutableAttributedString *string = [confferer confer].mutableCopy;
    if(paragraphStyle){
        NSDictionary *dict = @{NSParagraphStyleAttributeName : paragraphStyle.paragraph};
        [string addAttributes:dict range:NSMakeRange(0, string.length)];
    }
    self.attributedText = string.copy;
}

- (void)rz_colorfulWithParagraphStyleAppend:(void (^)(RZParagraphStyle *))paragraph confer:(void (^)(RZColorfulConferrer *))attribute {
    RZParagraphStyle *paragraphStyle = nil;
    if (paragraph) {
        paragraphStyle = [[RZParagraphStyle alloc] init];
        paragraph(paragraphStyle);
    }
    if(!attribute) {
        return ;
    }
    RZColorfulConferrer *confferer = [[RZColorfulConferrer alloc] init];
    attribute(confferer);
    NSMutableAttributedString *string = [confferer confer].mutableCopy;
    if(paragraphStyle){
        NSDictionary *dict = @{NSParagraphStyleAttributeName : paragraphStyle.paragraph};
        [string addAttributes:dict range:NSMakeRange(0, string.length)];
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attr appendAttributedString:string];

    self.attributedText = attr.copy;
}
#pragma clang diagnostic pop

@end
