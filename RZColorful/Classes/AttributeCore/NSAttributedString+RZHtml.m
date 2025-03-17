    //
    //  NSAttributedString+RZHtml.m
    //  RZColorfulExample
    //
    //  Created by rztime on 2020/8/12.
    //  Copyright © 2020 rztime. All rights reserved.
    //

#import "NSAttributedString+RZHtml.h"

@implementation NSAttributedString (RZHtml)
    // 将html转换成 NSAttributedString
+ (NSAttributedString *)htmlString:(NSString *)html {
    if (!html) {
        return [NSAttributedString new];
    }
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    NSError *error;
    NSMutableAttributedString *htmlString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:&error].mutableCopy;
    if (!error) {
        // 修复URL在未设置http时，会自动添加如 “applewebdata://BF307C6C-5A2C-4F76-B3A0-6FD67E66CF82/”
        [htmlString enumerateAttribute:NSLinkAttributeName inRange:NSMakeRange(0, htmlString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
            NSURL *url;
            if ([value isKindOfClass:[NSString class]]) {
                url = [NSURL URLWithString:((NSString *)value)];
            } else if ([value isKindOfClass:[NSURL class]]) {
                url = (NSURL *)value;
            }
            if ([url.scheme isEqualToString:@"applewebdata"]) {
                NSString *tempUrl = url.absoluteString;
                NSString *originUrl = [tempUrl stringByReplacingOccurrencesOfString:@"^(?:applewebdata://[0-9A-Z-]*/?)" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, tempUrl.length)];
                if (originUrl.length > 0) {
                    url = [NSURL URLWithString:originUrl];
                    [htmlString addAttribute:NSLinkAttributeName value:url range:range];
                }
            }
        }];
        return htmlString.copy;
    } else {
        NSLog(@"__%s__\n 富文本html转换有误:\n%@", __FUNCTION__, error);
        return [NSAttributedString new];
    }
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
- (NSString *)rz_codingToHtmlByWebWithImagesURLSIfHad:(NSArray <NSString *> *)urls {
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
    NSString *html = [tempAttr rz_codingToCompleteHtmlByWeb];
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
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    NSData *htmlData = [self dataFromRange:NSMakeRange(0, self.length) documentAttributes:exportParams error:nil];
    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"pt;" withString:@"px;"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"pt}" withString:@"px}"];
    return htmlString;
}

- (NSString *)rz_codingToCompleteHtmlByWeb {
    NSMutableAttributedString *tempAttr = self.mutableCopy;
    NSArray <RZHtmlTransform *> *labels = RZHTMLWebLabels;
    
    NSMutableArray <RZHtmlTransform *> *temparray = NSMutableArray.new; // 记录转换了多少个标签，最后需要还原
    // 循环遍历每一个块，将iOS不支持转换为web标签的属性，替换成web标签
    [self enumerateAttributesInRange:NSMakeRange(0, tempAttr.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        // 当前遍历的文本
        NSMutableAttributedString *tempAttributed = [tempAttr attributedSubstringFromRange:range].mutableCopy;
        NSMutableDictionary *tempAttrDict = attrs.mutableCopy;
        
        RZHtmlTransform *form = [[RZHtmlTransform alloc] init];
        // 记录其url
        form.url = tempAttrDict[NSLinkAttributeName];
        if ([form.url isKindOfClass:[NSURL class]]) {
            form.url = ((NSURL *)form.url).absoluteString;
        }
        // 遍历所有需要转换的标签（可以自定义添加）
        [labels enumerateObjectsUsingBlock:^(RZHtmlTransform * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 如果当前文本包含了需要替换的标签，则将其转换为style，并移除文本中当前的属性
            if (obj.keys.count > 0 && [tempAttrDict.allKeys rz_containsArray:obj.keys]) { // 优先处理要组合的
                NSString *style = obj.styleConfigure(@"", tempAttrDict);
                form.style = [NSString stringWithFormat:@"%@%@", (form.style == nil ? @"" : form.style), style ];
                [obj.keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                    [tempAttributed removeAttribute:key range:NSMakeRange(0, tempAttributed.length)];
                }];
                [tempAttrDict removeObjectsForKeys:obj.keys];
            } else if ([tempAttrDict.allKeys containsObject:obj.key]) {
                id value = tempAttrDict[obj.key];
                NSString *style = obj.styleConfigure(value, tempAttrDict);
                form.style = [NSString stringWithFormat:@"%@%@", (form.style == nil ? @"" : form.style), style ];
                [tempAttributed removeAttribute:obj.key range:NSMakeRange(0, tempAttributed.length)];
                [tempAttrDict removeObjectForKey:obj.key];
            }
        }];
        
        NSString *newUrl = form.mergeUrlAndStyle;
        if (newUrl.length > 0) {// 合并url和style，将其写入到NSLink中，
            [tempAttributed addAttribute:NSLinkAttributeName value:newUrl range:NSMakeRange(0, tempAttributed.length)];
            [tempAttr replaceCharactersInRange:range withAttributedString:tempAttributed];
            [temparray addObject:form];
        }
    }];
    __block NSString *text = tempAttr.rz_codingToCompleteHtml;
        // url 和 style 合并到href中了，这里需要还原， href="url" style=""....
    [temparray enumerateObjectsUsingBlock:^(RZHtmlTransform * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        text = [obj creatHtmlLabelWith:text];
    }];
    return text;
}

@end


@implementation RZHtmlTransform
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static RZHtmlTransform *form = nil;
    dispatch_once(&onceToken, ^{
        form = [RZHtmlTransform.alloc init];
    });
    return form;
}
// 初始化，单个需要处理的属性
- (instancetype)initWith:(NSString *)key styleConfigure:(RZStyleConfigure)conf {
    if (self = [super init]) {
        self.key = key;
        self.styleConfigure = conf;
    }
    return self;
}
// 初始化，需要组合的属性
- (instancetype)initWithArray:(NSArray <NSString *> *)keys styleConfigure:(RZStyleConfigure)conf {
    if (self = [super init]) {
        self.keys = keys;
        self.styleConfigure = conf;
    }
    return self;
}

/// 将需要转换为web标签的key，记录下来，  多个key要组合的，需要放在数组前（优先级更高）循环遍历需要先处理
- (NSMutableArray <RZHtmlTransform *> *)webLabels {
    if (!_webLabels) {
        _webLabels = @[
            // 删除线  下划线 组合到一起  下划线和删除线 不支持单独设置颜色
            [RZHtmlTransform.alloc initWithArray:@[NSStrikethroughStyleAttributeName, NSUnderlineStyleAttributeName] styleConfigure:^NSString * _Nullable(id  _Nonnull value, NSDictionary * _Nonnull attrs) {
                UIColor *color = attrs[NSStrikethroughColorAttributeName]; // 取删除线或者下划线颜色
                if (!color) {
                    color = attrs[NSUnderlineColorAttributeName];
                }
                if (!color) {
                    color = attrs[NSForegroundColorAttributeName];
                }
                NSString *colorString = @"";
                if (color) {
                    colorString = [NSString stringWithFormat:@"%@", color.rz_hexString];
                }
                return [NSString stringWithFormat:@"text-decoration: line-through underline; text-decoration-color: %@;", colorString];
            }],
            // 斜体, 扩张 组合到一起
            [RZHtmlTransform.alloc initWithArray:@[NSObliquenessAttributeName, NSExpansionAttributeName] styleConfigure:^NSString * _Nullable(id  _Nonnull value, NSDictionary * _Nonnull attrs) {
                float i = ((NSNumber *)attrs[NSObliquenessAttributeName]).floatValue;
                float e = ((NSNumber *)attrs[NSExpansionAttributeName]).floatValue;
                float itemp = [RZHtmlTransform italicTrans:i];
                float etemp = [RZHtmlTransform expansionTrans:e];
                return [NSString stringWithFormat:@"transform:skew(%fdeg) scaleX(%f);transform-origin: 0 0; display:inline-block;", itemp, etemp];
            }],
            // 背景色
            [RZHtmlTransform.alloc initWith:NSBackgroundColorAttributeName styleConfigure:^NSString * _Nullable(UIColor * value, NSDictionary * _Nonnull attrs) {
                return [NSString stringWithFormat:@"background-color: %@;", value.rz_hexString];
            }],
            // 删除线
            [RZHtmlTransform.alloc initWith:NSStrikethroughStyleAttributeName styleConfigure:^NSString * _Nullable(id  _Nonnull value, NSDictionary * _Nonnull attrs) {
                UIColor *color = attrs[NSStrikethroughColorAttributeName];
                NSString *colorString = @"";
                if (!color) {
                    color = attrs[NSForegroundColorAttributeName];
                }
                if (color) {
                    colorString = [NSString stringWithFormat:@"%@", color.rz_hexString];
                }
                return [NSString stringWithFormat:@"text-decoration: line-through; text-decoration-color: %@;", colorString];
            }],
            // 下划线
            [RZHtmlTransform.alloc initWith:NSUnderlineStyleAttributeName styleConfigure:^NSString * _Nullable(id  _Nonnull value, NSDictionary * _Nonnull attrs) {
                UIColor *color = attrs[NSUnderlineColorAttributeName];
                NSString *colorString = @"";
                if (!color) {
                    color = attrs[NSForegroundColorAttributeName];
                }
                if (color) {
                    colorString = [NSString stringWithFormat:@"%@", color.rz_hexString];
                }
                return [NSString stringWithFormat:@"text-decoration: underline; text-decoration-color: %@;", colorString];
            }],
            // 描边
            [RZHtmlTransform.alloc initWith:NSStrokeWidthAttributeName styleConfigure:^NSString * _Nullable(NSNumber *  _Nonnull value, NSDictionary * _Nonnull attrs) {
                float v = value.floatValue;
                UIFont *font = attrs[NSFontAttributeName];
                UIColor *color = attrs[NSStrokeColorAttributeName];
                NSString *colorString = @"";
                if (color) {
                    colorString = [NSString stringWithFormat:@"%@", color.rz_hexString];
                }
                if (v <= 0) {
                    return [NSString stringWithFormat:@"-webkit-text-stroke: %fpx %@;", -v * (font.pointSize / 100.f), colorString];
                } else {
                    return [NSString stringWithFormat:@"-webkit-text-stroke: %fpx %@; color:#00000000;", v * (font.pointSize / 100.f), colorString]; // 大于0时，是中空，用透明色来模拟
                }
            }],
            // 斜体
            [RZHtmlTransform.alloc initWith:NSObliquenessAttributeName styleConfigure:^NSString * _Nullable(NSNumber *  _Nonnull value, NSDictionary * _Nonnull attrs) {
                float v = value.floatValue;
                float temp = [RZHtmlTransform italicTrans:v];
                return [NSString stringWithFormat:@"transform:skew(%fdeg); transform-origin: 10 0; display:inline-block;", temp];
            }],
            // 扩张，即拉伸文字
            [RZHtmlTransform.alloc initWith:NSExpansionAttributeName styleConfigure:^NSString * _Nullable(NSNumber *  _Nonnull value, NSDictionary * _Nonnull attrs) {
                float v = value.floatValue;
                float temp = [RZHtmlTransform expansionTrans:v];
                return [NSString stringWithFormat:@"transform:scaleX(%f); transform-origin: 0 0; display:inline-block;", temp];
            }],
            // 书写方向
            [RZHtmlTransform.alloc initWith:NSWritingDirectionAttributeName styleConfigure:^NSString * _Nullable(NSArray *  _Nonnull value, NSDictionary * _Nonnull attrs) {
                RZWriteDirection dir = [RZHtmlTransform directionTrans:value.firstObject];
                switch (dir) {
                    case LRE: {
                        return @"direction: ltr; unicode-bidi: embed";
                    }
                    case LRO: {
                        return @"direction: ltr; unicode-bidi: bidi-override";
                    }
                    case RLE: {
                        return @"direction: rtl; unicode-bidi: embed";
                    }
                    case RLO: {
                        return @"direction: rtl; unicode-bidi: bidi-override";
                    }
                }
                return @"";
            }],
        ].mutableCopy;
    }
    return _webLabels;
}
 
- (NSString *)mergeUrlAndStyle {
    NSString *text = @"";
    if (self.url.length > 0) {
        text = [text stringByAppendingString:self.url];
    }
    if (self.style.length > 0) {
        text = [text stringByAppendingString:self.style];
    }
    return text;
}
- (NSString *)creatHtmlLabelWith:(NSString *)html {
    NSString *mr = self.mergeUrlAndStyle;
    if (mr.length > 0) {
        NSString *href = [NSString stringWithFormat:@"href=\"%@\"", mr];
        NSString *u = @"";
        if (self.url.length > 0) {
            u = [NSString stringWithFormat:@"href=\"%@\"", self.url];
        }
        NSString *s = @"";
        if (self.style.length > 0) {
            s = [NSString stringWithFormat:@" style=\"%@\"", self.style];
        }
        html = [html stringByReplacingOccurrencesOfString:href withString:[NSString stringWithFormat:@"%@%@", u, s]];
    }
    return html;
}
    // 将iOS系统的斜体转换为web对应的角度
+ (float)italicTrans:(float)value {
    float temp = atanf(fabsf(value)) * 180 / M_PI;
    if (value > 0) {
        temp = -temp;
    }
    return temp;
}
    /// 将iOS系统的扩展倍数转换为web对应的倍数 官方的拉伸压缩比例，暂未找到资料，下边的数据，仅做相似参考，如果你知道，请反馈给我吧，谢谢
+ (float)expansionTrans:(float)value {
    float v = value;
    float temp = v; // NSExpansionAttributeName
    if (v < -1) {
        temp = -1/(v * 2 * v + 1);
    } else if (v < 0) {
        temp = v/1.5 + 1;
    } else if (v <= 1) {
        temp = v * 1.5 + 1;
    } else if (v > 1) {
        temp = v * 2 * v + 1;
    }
    return temp;
}
+ (RZWriteDirection)directionTrans:(NSNumber *)value {
    if (!value) {
        return LRO;
    }
    NSInteger O = 0;
    NSInteger E = 0;
    if (@available(iOS 9.0, *)) {
        O = NSWritingDirectionOverride;
        E = NSWritingDirectionEmbedding;
    } else {
        O = NSTextWritingDirectionOverride;
        E = NSTextWritingDirectionEmbedding;
    }
    if ([value isEqualToNumber:@(NSWritingDirectionLeftToRight | E)]) {return LRE;}
    if ([value isEqualToNumber:@(NSWritingDirectionLeftToRight | O)]) {return LRO;}
    if ([value isEqualToNumber:@(NSWritingDirectionRightToLeft | E)]) {return RLE;}
    if ([value isEqualToNumber:@(NSWritingDirectionRightToLeft | O)]) {return RLO;}
    return LRO;
}
@end

@implementation UIColor (RZColorful)
- (NSString *)rz_hexString {
    //颜色值个数，rgb和alpha
    NSInteger component = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat red = components[0];//红色
    CGFloat green = components[1];//绿色
    if (component == 2) {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX", lroundf(red * 255), lroundf(red * 255), lroundf(red * 255), lroundf(green * 255)];;
    }
    CGFloat blue = components[2];//蓝色
    if (component == 4) {
        CGFloat alpha = components[3];//透明度
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255), lroundf(alpha * 255)];
    } else {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255)];
    }
}
@end
@implementation NSArray (RZColorful)
    // 数组是否包含数组
- (BOOL)rz_containsArray:(NSArray *)array {
    __block BOOL flag = false;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        flag = [self containsObject:obj];
        if (!flag) {
            *stop = true;
        }
    }];
    return flag;
}
@end

