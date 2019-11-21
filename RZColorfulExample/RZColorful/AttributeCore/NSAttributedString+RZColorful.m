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

// 将html转换成 NSAttributedString
+ (NSAttributedString *)htmlString:(NSString *)html {
    if (!html) {
        return [NSAttributedString new];
    }
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    NSError *error;
    NSMutableAttributedString *htmlString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:&error].mutableCopy;
    if (!error) {
        // 修复URL在未设置http时，会自动添加如 “applewebdata://BF307C6C-5A2C-4F76-B3A0-6FD67E66CF82/”
        NSArray <RZAttributedStringInfo *> *fixURL = [htmlString rz_attributedStringByAttributeName:NSLinkAttributeName];
        [fixURL enumerateObjectsUsingBlock:^(RZAttributedStringInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSURL *url = obj.value;
            if ([url isKindOfClass:[NSString class]]) {
                url = [NSURL URLWithString:((NSString *)url)];
            }
            if ([url isKindOfClass:[NSURL class]]) {
                if ([url.scheme isEqualToString:@"applewebdata"]) {
                      NSString *tempUrl = url.absoluteString;
                      NSString *originUrl = [tempUrl stringByReplacingOccurrencesOfString:@"^(?:applewebdata://[0-9A-Z-]*/?)" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, tempUrl.length)];
                      if (originUrl.length > 0) {
                          url = [NSURL URLWithString:originUrl];
                          [obj.attributedString setAttributes:@{NSLinkAttributeName:url} range:NSMakeRange(0, obj.attributedString.length)];
                          [htmlString replaceCharactersInRange:obj.range withAttributedString:obj.attributedString];
                      }
                } 
            }
        }];
        return htmlString.copy;
    } else {
        NSLog(@"__%s__\n 富文本html转换有误:\n%@", __FUNCTION__, error);
        return [NSAttributedString new];
    }
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

/**
 将富文本编码成html标签，如果有图片，用此方法
 
 @param urls 图片的url，url需要先获取图片，然后自行上传到服务器，最后按照【- (NSArray <UIImage *> *)images;】此方法得到的图片顺序排列url
 @return HTML标签
 */
- (NSString *)rz_codingToHtmlWithImagesURLSIfHad:(NSArray <NSString *> *)urls {
    NSMutableAttributedString *tempAttr = self.mutableCopy;
    // 先将图片占位，等替换完成html标签之后，在将图片url替换回准确的
    __block NSInteger idx = 0;
    NSMutableArray *tempPlaceHolders = [NSMutableArray new];
    [tempAttr enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, tempAttr.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSTextAttachment class]]) {
            NSString *placeHolder = [NSString stringWithFormat:@"rz_attributed_image_placeHolder_index_%lu", (unsigned long)idx];
            idx++;
            [tempAttr replaceCharactersInRange:range withString:placeHolder];
            [tempPlaceHolders addObject:placeHolder];
        }
    }];
    NSString *html = [tempAttr rz_codingToCompleteHtml];
    NSInteger index = 0;
    for (NSInteger i = tempPlaceHolders.count - 1; i >= 0; i--) {
        NSString *placeholder = tempPlaceHolders[i];
        NSString *url = index < urls.count? urls[index]:@"";
        NSString *img = [NSString stringWithFormat:@"<img style=\"max-width:98%%;height:auto;\" src=\"%@\" alt=\"图片缺失\">", url];
        index++; 
        html = [html stringByReplacingOccurrencesOfString:placeholder withString:img];
    }
    return html;
}

- (NSString *)rz_codingToCompleteHtml {
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSData *htmlData = [self dataFromRange:NSMakeRange(0, self.length) documentAttributes:exportParams error:nil];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"pt;" withString:@"px;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"pt}" withString:@"px}"];
    return htmlString;
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
 
- (void)setHadTapAction:(BOOL)hadTapAction {
    objc_setAssociatedObject(self, @"hadTapAction", @(hadTapAction), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hadTapAction {
    return [objc_getAssociatedObject(self, @"hadTapAction") boolValue];
}
@end

@implementation RZAttributedStringInfo

@end

#pragma clang diagnostic pop
