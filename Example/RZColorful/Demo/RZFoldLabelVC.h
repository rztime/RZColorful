//
//  RZFoldLabelVC.h
//  RZColorful_Example
//
//  Created by rztime on 2022/1/26.
//  Copyright © 2022 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoldModel : NSObject
@property (nonatomic, strong) NSAttributedString *text;
@property (nonatomic, strong) NSAttributedString *showAll;
@property (nonatomic, strong) NSAttributedString *showFold;
@property (nonatomic, assign) BOOL isFold;
@end

@interface RZFoldLabelVC : UIViewController

@end

@interface RZFoldTestCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
