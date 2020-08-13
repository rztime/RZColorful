//
//  NSAttributedString+RZHtml.h
//  RZColorfulExample
//
//  Created by rztime on 2020/8/12.
//  Copyright © 2020 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAttributedString+RZColorful.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (RZHtml)
    // 将html转换成 NSAttributedString
+ (NSAttributedString *)htmlString:(NSString *)html;
/**
 将富文本完整的code成html标签，（此方法如果富文本中有图片，则图片将被丢失）  有图片时，请用[rz_codingToHtmlWithImagesURLSIfHad]方法   （备注 使用系统方法，某些标签将不能转换）
 @return HTML标签语言
 */
- (NSString *)rz_codingToCompleteHtml;

/// 将富文本转换为web可用的html
/// 备注 ：1将系统不能转换的标签，通过外部方法写入style，转换成web可用的html
///      2  通过htmlString还原成NSAttributedString，部分属性也有可能丢失 如下划线删除线的颜色（转换时，系统取得是<style type="text/css">里的数据，没有时，将取用文本颜色）
/*
    部分属性需要修改的如下： NSBackgroundColorAttributeName 背景色
                        NSStrikethroughStyleAttributeName NSUnderlineStyleAttributeName NSStrikethroughColorAttributeName NSUnderlineColorAttributeName  下划线（删除线） 及其颜色
                        NSObliquenessAttributeName 斜体
                        NSExpansionAttributeName 扩展
                        NSStrokeWidthAttributeName 描边 及其颜色
                        NSWritingDirectionAttributeName 书写方向
 **/
- (NSString *)rz_codingToCompleteHtmlByWeb;
/**
 将富文本编码成html标签，如果有图片，用此方法 (系统方法，某些标签将不能转换)
 
 @param urls 图片的url，url需要先获取图片，然后自行上传到服务器，最后按照【- (NSArray <UIImage *> *)images;】此方法得到的图片顺序排列url
 @return HTML标签
 */
- (NSString *)rz_codingToHtmlWithImagesURLSIfHad:(NSArray <NSString *> *)urls;
/// 将富文本转换为web可用的html
- (NSString *)rz_codingToHtmlByWebWithImagesURLSIfHad:(NSArray <NSString *> *)urls;

@end


#define RZHTMLWebLabels RZHtmlTransform.share.webLabels
// 需要将富文本属性转换为web的辅助类
@interface RZHtmlTransform : NSObject

typedef NSString *_Nullable(^RZStyleConfigure)(id value, NSDictionary *attr);

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSArray <NSString *> *keys;
@property (nonatomic, copy) RZStyleConfigure styleConfigure;


@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *style;


+ (instancetype)share;
// iOS 不支持的标签，需要转换为web标签的配置 可以通过单例添加
@property (nonatomic, strong) NSMutableArray <RZHtmlTransform *> *webLabels;
// webLabels 自定义配置的标签方法
- (instancetype)initWith:(NSString *)key styleConfigure:(RZStyleConfigure)conf;
    // 需要组合的属性
- (instancetype)initWithArray:(NSArray <NSString *> *)keys styleConfigure:(RZStyleConfigure)conf;
// 将url和style合并，成为新的url，将写入到html的href中
- (NSString *)mergeUrlAndStyle;
// 将mergeUrlAndStyle过的url还原
- (NSString *)creatHtmlLabelWith:(NSString *)html;

/// 将iOS系统的斜体转换为web对应的角度
+ (float)italicTrans:(float)value;
/// 将iOS系统的扩展倍数转换为web对应的倍数 官方的拉伸压缩比例，暂未找到资料，下边的数据，仅做相似参考，如果你知道，请反馈给我吧，谢谢
+ (float)expansionTrans:(float)value;
/// 书写方向转换
+ (RZWriteDirection)directionTrans:(NSNumber *)value;
@end
@interface UIColor (RZColorful)
- (NSString *)rz_hexString;
@end

@interface NSArray (RZColorful)
// 数组是否包含数组
- (BOOL)rz_containsArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
