//
//  RZImageAttachment.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/28.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZImageAttachment.h"

@implementation RZImageAttachment
- (RZImageAttachment *(^)(CGRect bounds))bounds {
    __weak typeof(self)weakSelf = self;
    return ^id (CGRect bounds) {
        weakSelf.bounds = bounds;
        return self;
    };
}

- (void)setBounds:(CGRect)bounds {
    _imageBounds = bounds;
}

@end
