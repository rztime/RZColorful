//
//  UIButton+RZColorful.m
//  RZColorful
//
//  Created by rztime on 2022/1/25.
//

#import "UIButton+RZColorful.h"

@implementation UIButton (RZColorful)

- (void)rz_colorfulConfer:(void (^)(RZColorfulConferrer * _Nonnull))attribute state:(UIControlState)state {
    NSAttributedString *string = [NSAttributedString rz_colorfulConfer:attribute];
    [self setAttributedTitle:string forState:state];
}

@end
