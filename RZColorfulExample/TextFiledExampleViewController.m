//
//  TextFiledExampleViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/26.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "TextFiledExampleViewController.h"
#import "common.h"
#import "RZColorful.h"

@interface TextFiledExampleViewController ()
{
    UITextField *textFiled;
}
@end

@implementation TextFiledExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 40)];
    [self.view addSubview:textFiled];

    [textFiled rz_colorfulConfer:^(RZColorfulConferrer *confer) {
        confer.text(@"具体的使用方法，相信看完UILabel,UITextView，就已经了解了，url的可点击属性只能在UITextView中有效").textColor(RGB(255, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
