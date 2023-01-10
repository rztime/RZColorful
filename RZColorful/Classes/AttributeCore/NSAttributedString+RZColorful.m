//
//  NSAttributedString+RZColorful.m
//  RZColorfulExample
//
//  Created by rztime on 2017/11/15.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "NSAttributedString+RZColorful.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
#import "NSAttributedString+RZHtml.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation NSAttributedString (RZColorful)

+ (NSAttributedString *)rz_colorfulConfer:(void(^)(RZColorfulConferrer *confer))attribute {
    if(!attribute) {
        return [NSAttributedString new];
    }
    RZColorfulConferrer *conferrer = [[RZColorfulConferrer alloc]init];
    attribute(conferrer);
    NSAttributedString *attr = [conferrer confer];
    return attr;
}

- (NSAttributedString *)attributedStringByAppend:(NSAttributedString *)attributedString {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [attr appendAttributedString:attributedString];
    return attr.copy;
}

/**
 固定宽度，计算高
 
 @param width 固定宽度
 @return <#return value description#>
 */
- (CGSize)sizeWithConditionWidth:(CGFloat)width {
    CGSize size = [self sizeWithCondition:CGSizeMake(width, CGFLOAT_MAX)];
    size.width = width;
    return size;
}


/**
 固定高度，计算宽
 
 @param height 固定高度
 @return <#return value description#>
 */
- (CGSize)sizeWithConditionHeight:(CGFloat)height {
    CGSize size = [self sizeWithCondition:CGSizeMake(CGFLOAT_MAX, height)];
    size.height = height;
    return size;
}
/**
 计算富文本的size
 如需计算高度 size = CGSizeMake(300, CGFLOAT_MAX)
 如需计算宽度 size = CGSizeMake(CGFLOAT_MAX, 18)
 
 @param size 约定的size，以宽高做条件，定宽时，计算得到高度（此时忽略宽度）
 定高时，计算得到宽度 （此时忽略高度）
 @return <#return value description#>
 */
- (CGSize)sizeWithCondition:(CGSize)size {
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}


// 获取富文本中的图片
- (NSArray <UIImage *> *)rz_images {
    NSMutableArray *arrays = [NSMutableArray new];
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSTextAttachment class]]) {
            NSTextAttachment *imageMent = value;
            if (imageMent.image) {
                [arrays addObject:imageMent.image];
            } else if(imageMent.fileWrapper.regularFileContents) {
                UIImage *image = [UIImage imageWithData:imageMent.fileWrapper.regularFileContents];
                if (image) {
                    [arrays addObject:image];
                }
            }
        }
    }];
    return arrays.copy;
}


- (NSArray <RZAttributedStringInfo *> *)rz_attributedStringByAttributeName:(NSAttributedStringKey)attrName {
    if (self.length == 0) {
        return nil;
    }
    NSMutableArray *attris = [NSMutableArray new];
    __weak typeof (self) weakSelf = self;
    [self enumerateAttribute:attrName inRange:NSMakeRange(0, self.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            RZAttributedStringInfo *info = [RZAttributedStringInfo new];
            info.attributedString = [weakSelf attributedSubstringFromRange:range].mutableCopy;
            info.range = range;
            info.value = value;
            info.attrName = attrName;
            [attris addObject:info];
        }
    }];
    return attris;
}

/// 绘制在rect范围内时， 获取每一行的文本信息，
/// @param rect 绘制范围
- (NSArray <RZAttributedStringInfo *> *)rz_linesIfDrawInRect:(CGRect)rect {
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines =  (__bridge NSArray *)CTFrameGetLines(frame);
    
    NSMutableArray <RZAttributedStringInfo *> *infos = [NSMutableArray new];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        RZAttributedStringInfo *info = [RZAttributedStringInfo new];
        info.attributedString = [self attributedSubstringFromRange:range].mutableCopy;
        info.range = range;
        [infos addObject:info];
    }
    return infos.copy;
}

/// 将attr追加到当前文本上 ，只有在rect上绘制，小于（等于或大于）line时，才将attr追加到self之后
/// @param attr 要追加的文本
/// @param condition 满足的条件
/// @param line 行数
/// @param rect 要绘制的rect
- (NSAttributedString *)rz_appendAttributedString:(NSAttributedString *)attr when:(RZAttributedStringAppendCondition)condition line:(NSInteger)line inRect:(CGRect)rect {
    if (!attr) {
        attr = [NSAttributedString new];
    }
    NSMutableAttributedString *tempAttr = self.mutableCopy;
    NSArray <RZAttributedStringInfo *> *lines = [tempAttr rz_linesIfDrawInRect:rect];
    NSComparisonResult result = [@(lines.count) compare:@(line)];
    if ((RZAttributedStringAppendCondition)result == condition) {
        for (NSInteger lineNum = MIN(lines.count, line) - 1; lineNum >= 0; lineNum--) {
            BOOL flag = NO;
            RZAttributedStringInfo *lastLineInfo = lines[lineNum];
            for (NSInteger row = lastLineInfo.range.length; row >= 0; row--) {
                NSInteger length = lastLineInfo.range.location + row;
                
                NSMutableAttributedString *temp = [tempAttr attributedSubstringFromRange:NSMakeRange(0, length)].mutableCopy;
                [temp appendAttributedString:attr];
                NSArray <RZAttributedStringInfo *> *tempLines = [temp rz_linesIfDrawInRect:rect];
                if (tempLines.count <= line) {
                    RZAttributedStringInfo *tempLast = tempLines.lastObject;
                    CGSize size = [tempLast.attributedString sizeWithConditionHeight:CGFLOAT_MAX];
                    if (size.width <= rect.size.width) {
                        flag = YES;
                        
                        if ([temp.string hasSuffix:@"\n"]) {
                            [temp replaceCharactersInRange:NSMakeRange(temp.length - 1, 1) withString:@""];
                        }
                        tempAttr = temp.copy;
                        break;
                    }
                }
            }
            if (flag) {
                break;
            }
        }
    }
    return tempAttr.copy;
}

@end

@implementation NSAttributedString(RZLines)

- (BOOL)rz_moreThan:(NSInteger)line maxWidth:(CGFloat)width {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.attributedText = self;
    CGSize tempSize = CGSizeMake(width, CGFLOAT_MAX);
    CGFloat allHeight = [label textRectForBounds:CGRectMake(0, 0, tempSize.width, tempSize.height) limitedToNumberOfLines:0].size.height;
    CGFloat lineHeight = [label textRectForBounds:CGRectMake(0, 0, tempSize.width, tempSize.height) limitedToNumberOfLines:line].size.height;
    return ceil(allHeight) > ceil(lineHeight);
}

- (NSAttributedString *)rz_attributedStringBy:(NSInteger)maxLine maxWidth:(CGFloat)width isFold:(BOOL)fold showAllText:(NSAttributedString *)allText showFoldText:(NSAttributedString *)foldText {
    if (self.length == 0 || maxLine == 0) {
        return self;
    }
    if (![self rz_moreThan:maxLine maxWidth:width]) {
        return self;
    }
    if (!fold) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
        if (foldText != nil) {
            [attr appendAttributedString:foldText];
        }
        return attr;
    }
    NSAttributedString *showAll = allText == nil ? [NSAttributedString new] : allText;
    NSInteger min = 0;
    NSInteger max = self.length;
    NSInteger end = 0;
    while (true) {
        end = (min + max) / 2;
        NSAttributedString *sub = [self attributedSubstringFromRange:NSMakeRange(0, end)];
        NSMutableAttributedString *tempAttr = [[NSMutableAttributedString alloc] initWithAttributedString:sub];
        [tempAttr appendAttributedString:showAll];
        Boolean more = [tempAttr rz_moreThan:maxLine maxWidth:width];
        if (more) {
            max = end;
        } else {
            min = end;
        }
        NSInteger tempEnd = (min + max) / 2;
        if (tempEnd == end) {
            return tempAttr;
        }
    }
}
/// 对富文本进行截断处理
/// - Parameters:
///   - maxLine: 设置超过多少截断
///   - width: 显示的最大宽度
///   - model: 截断方式
///   - placeHolder: 截断时占位的"..."文字
- (NSAttributedString * _Nullable)rz_attributedStringBy:(NSInteger)maxLine maxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)model placeHolder:(NSAttributedString *_Nullable)placeHolder {
    if (self.length == 0 || maxLine == 0) {
        return self;
    }
    if (![self rz_moreThan:maxLine maxWidth:width]) {
        return self;
    }

    NSAttributedString *holder = placeHolder == nil ? [NSAttributedString new] : placeHolder;
    NSInteger min = 0;
    NSInteger max = self.length;
    NSInteger end = 0;
    while (true) {
        end = (min + max) / 2;
        NSAttributedString *sub = [self attributedSubstringFromRange:NSMakeRange(0, end)];
        NSMutableAttributedString *tempAttr = [[NSMutableAttributedString alloc] initWithAttributedString:sub];
        switch (model) {
            case NSLineBreakByWordWrapping: { break; }
            case NSLineBreakByCharWrapping: { break; }
            case NSLineBreakByClipping: { break; }
            case NSLineBreakByTruncatingHead: {
                [tempAttr insertAttributedString:holder atIndex:0];
                break;
            }
            case NSLineBreakByTruncatingTail: {
                [tempAttr appendAttributedString:holder];
                break;
            }
            case NSLineBreakByTruncatingMiddle: {
                [tempAttr insertAttributedString:holder atIndex:(tempAttr.length / 2)];
                break;
            }
            default:
                break;
        }
        BOOL more = [tempAttr rz_moreThan:maxLine maxWidth:width];
        if (more) {
            max = end;
        } else {
            min = end;
        }
        NSInteger tempEnd = (min + max) / 2;
        if (tempEnd == end) {
            return tempAttr;
        }
    }
}
/// 给text 关键字 标记属性（如对关键字进行标红显示）
- (NSAttributedString *_Nonnull)rz_markText:(NSString *_Nullable)text attribute:(NSDictionary<NSAttributedStringKey, id> *_Nonnull)attribute {
    if ((text == nil) || (text.length == 0)) {
        return  self;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    NSString *t = self.string;
    NSRange range = NSMakeRange(0, t.length);
    while (range.length > 0) {
        NSRange r = [t rangeOfString:text options:NSCaseInsensitiveSearch range:range];
        if (r.location != NSNotFound) {
            [attr addAttributes:attribute range:r];
            NSInteger location = r.location + r.length;
            range = NSMakeRange(location, (t.length - location));
        } else {
            break;
        }
    }
    return attr;
}
/// 取self的属性，设置在text上
- (NSAttributedString *_Nonnull)rz_copyAttributeToText:(NSString *_Nonnull)text {
    NSDictionary *dict = [self attributesAtIndex:0 effectiveRange:nil];
    if (!dict) {
        dict = NSDictionary.new;
    }
    return  [[NSAttributedString alloc] initWithString:text attributes:dict];
}

@end

@implementation RZAttributedStringInfo

@end


#pragma clang diagnostic pop
