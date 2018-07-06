//
//  RZShadow.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZShadow.h"
#import "RZColorfulAttribute.h"

@implementation RZShadow

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


- (RZColorfulAttribute *)and {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)with {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)end {
    return _colorfulsAttr;
}

- (NSShadow *)shadow {
    if (!_shadow) {
        _shadow = [[NSShadow alloc] init];
        _colorfulsAttr.rzShadow = _shadow;
    }
    return _shadow;
}

- (RZShadow *(^)(CGSize offSet))offset {
    __weak typeof(self)weakSelf = self;
    return ^id (CGSize offset) {
        weakSelf.shadow.shadowOffset = offset;
        return self;
    };
}

- (RZShadow *(^)(CGFloat radius))radius {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat radius) {
        weakSelf.shadow.shadowBlurRadius = radius;
        return self;
    };
}

- (RZShadow *(^)(UIColor *color))color {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *color) {
        weakSelf.shadow.shadowColor = color;
        return self;
    };
}
#pragma clang diagnostic pop
@end
