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
    }
    return _shadow;
}

- (RZShadow *(^)(CGSize offSet))offset {
    __weak typeof(self)weakSelf = self;
    return ^id (CGSize offset) {
        weakSelf.offset = offset;
        return self;
    };
}

- (void)setOffset:(CGSize)offset {
    self.shadow.shadowOffset = offset;
    _colorfulsAttr.rzShadow = self.shadow.copy;
}

- (RZShadow *(^)(CGFloat radius))radius {
    __weak typeof(self)weakSelf = self;
    return ^id (CGFloat radius) {
        weakSelf.radius = radius;
        return self;
    };
}

- (void)setRadius:(CGFloat)radius {
    self.shadow.shadowBlurRadius = radius;
    _colorfulsAttr.rzShadow = self.shadow.copy;
}

- (RZShadow *(^)(UIColor *color))color {
    __weak typeof(self)weakSelf = self;
    return ^id (UIColor *color) {
        weakSelf.color = color;
        return self;
    };
}

- (void)setColor:(UIColor *)color {
    UIColor *_color = color.copy;
    if (!_color) {
        _color = [UIColor clearColor];
    }
    self.shadow.shadowColor = _color;
    _colorfulsAttr.rzShadow = self.shadow.copy;
}

@end
