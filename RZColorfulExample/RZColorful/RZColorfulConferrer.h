//
//  RZAttributedMaker.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZColorfulAttribute.h"


@interface RZColorfulConferrer : NSObject

- (NSAttributedString *)confer;

- (RZColorfulAttribute *(^)(NSString *text))text;

@end
