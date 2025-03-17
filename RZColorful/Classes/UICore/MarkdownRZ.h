//
//  MarkdownRZ.h
//  RZColorful
//
//  Created by rztime on 2025/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarkdownRZ : NSObject

/// 请提前调用此方法, 加载markedjs，用于解析markdown
/// - Parameter retry: 如果加载js出错，重试次数（如果加载出错，会有一个默认版本的js来处理）
+ (void)asyncInit:(NSInteger)retry;
/// 解析md文档
/// 有一些md文档正常解析中文会乱码，所以这里先将文档base64之后解析来解决中文乱码
/// - Parameter md: markdown文档
/// - Returns: 返回对应的html（解析md后的html，没有任何的样式，需要自行组装head里style：颜色、字号、列表、代码等等）
+ (NSString *)parse: (NSString *)md;
@end

NS_ASSUME_NONNULL_END
