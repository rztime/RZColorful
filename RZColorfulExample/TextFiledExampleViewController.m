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

    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath =[resourcePath stringByAppendingPathComponent:@"test.html"];
    NSString*htmlstring=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [textFiled rz_colorfulConferInsetTo:rzConferInsertPositionDefault append:^(RZColorfulConferrer * _Nonnull confer) {
        confer.htmlText(htmlstring);
        // 不能添加图片即 appendImage 和 appendImageUrl无效
        confer.text(@"具体的使用方法，相信看完UILabel,UITextView，就已经了解了，url的可点击属性只能在UITextView中有效").textColor(RGB(255, 0, 0));
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"追加到光标处" style:0 target:self action:@selector(add)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)add {
    [textFiled rz_colorfulConferInsetTo:rzConferInsertPositionCursor append:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"\n2222222222").textColor([UIColor redColor]);
    }];
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
