//
//  RZShadow.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZShadow.h"
#import "RZColorfulAttribute.h"

@interface RZShadow ()

@property (nonatomic, strong) NSShadow *shadow;
@property (nonatomic, weak) RZColorfulAttribute *colorfulsAttr;
@property (nonatomic, weak) RZImageAttachment *imageAttach;

@end

@implementation RZShadow

- (instancetype)initWithAttr:(RZColorfulAttribute *)attr {
    if (self = [super init]) {
        self.colorfulsAttr = attr;
    }
    return self;
}

- (instancetype)initWithAttach:(RZImageAttachment *)attach {
    if (self = [super init]) {
        self.imageAttach = attach;
    }
    return self;
}

- (RZColorfulAttribute *)and {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)with {
    return _colorfulsAttr;
}
- (RZColorfulAttribute *)end {
    return _colorfulsAttr;
}

- (RZImageAttachment *)andAttach {
    return _imageAttach;
}
- (RZImageAttachment *)withAttach {
    return _imageAttach;
}
- (RZImageAttachment *)endAttach {
    return _imageAttach;
}

- (NSShadow *)code {
    return _shadow;
}

- (NSShadow *)shadow {
    if (!_shadow) {
        _shadow = [[NSShadow alloc] init];
    }
    return _shadow;
}

- (RZShadow *(^)(CGSize))offset {
    return ^id (CGSize offset) {
        self.shadow.shadowOffset = offset;
        return self;
    };
}

- (RZShadow *(^)(CGFloat))radius {
    return ^id (CGFloat radius) {
        self.shadow.shadowBlurRadius = radius;
        return self;
    };
}

- (RZShadow *(^)(UIColor *))color {
    return ^id (UIColor *color) {
        self.shadow.shadowColor = color;
        return self;
    };
}
@end
