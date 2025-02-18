//
//  RZTestViewController.m
//  RZColorful_Example
//
//  Created by rztime on 2025/2/12.
//  Copyright © 2025 rztime. All rights reserved.
//

#import "RZTestViewController.h"
#import "Masonry.h"
#import "RZColorful.h"
@interface RZTestViewController ()
@property(nonatomic, strong) UILabel * label;
@end

@implementation RZTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).inset(20);
        make.top.equalTo(self.view).inset(100);
    }];
    NSString * text = @"壹贰叁\n肆伍陆柒捌玖拾壹拾壹壹拾贰壹拾叁壹拾肆壹拾伍壹拾陆壹拾柒壹拾捌壹拾玖1\n贰拾贰拾壹贰拾贰贰拾叁贰拾肆贰拾伍贰拾陆贰拾柒贰拾捌贰拾玖\n叁拾叁拾壹叁拾贰叁拾叁叁拾肆叁拾伍叁拾陆叁拾柒叁拾捌叁拾玖\n肆拾肆拾壹肆拾贰肆拾叁肆拾肆肆拾伍肆拾陆肆拾柒肆拾捌肆拾玖伍拾。";
    NSAttributedString * place = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(@"...").font([UIFont systemFontOfSize:30]).textColor([UIColor  redColor]).tapActionByLable(@"1");
    }];
    NSAttributedString * test =  [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
        confer.text(text).font([UIFont systemFontOfSize:30]).textColor([UIColor blackColor]).tapActionByLable(@"1");
    }];
    _label.attributedText = [test rz_attributedStringBy:2 maxWidth:self.view.frame.size.width - 40 lineBreakMode:NSLineBreakByClipping placeHolder:place];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
