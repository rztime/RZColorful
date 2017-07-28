//
//  RZAttributedMaker.h
//  RZAttributedStringText
//
//  Created by 乄若醉灬 on 2017/7/21.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZColorfulAttribute.h"
#import "RZImageAttachment.h"


@interface RZColorfulConferrer : NSObject

- (NSAttributedString *)confer;

- (RZColorfulAttribute *(^)(NSString *text))text;


/**
 添加图片，为使图片与前后排文字对齐，可设置其bounds的size高度和文字大小一样。且origin.y适当的取负值，即可对齐
 设置图片bounds时,origin.x 设置无效
 */
- (RZImageAttachment *(^)(UIImage *appendImage))appendImage;

@end
