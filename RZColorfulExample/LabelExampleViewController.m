//
//  LabelExampleViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/26.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "LabelExampleViewController.h"
#import "common.h"
#import "RZColorful.h"

@interface LabelExampleViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation LabelExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 700;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer *confer) {
        confer.text(@"hello，大家好，先来默认数据\n");
        confer.text(@"先来个红色\n").textColor(RGB(255, 0 ,0));
        confer.text(@"继续看颜色加字体\n").textColor(RGB(255, 255 ,80)).font(FONT(25));
        confer.text(@"继续看颜色加字体,给字加个背景\n").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230));
        confer.text(@"flush 连体字效果没看出来\n").ligature(@1);
        confer.text(@"继续看颜色加字体,给字加个背景, 加点间距\n").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230)).wordSpace(@15);
        confer.text(@"限时特卖 加个删除线").strikeThrough(RZLineStyleSignl);
        confer.text(@"  删除线颜色修改\n").strikeThrough(RZLineStyleSignl).strikeThroughColor(RGB(51, 251, 251));
        confer.text(@"阴影测试").shadow.color(RGB(134, 230, 51)).offset(CGSizeMake(10, 10)).radius(5).and.font(FONT(40));
        confer.appendImage([UIImage imageNamed:@"flower"]).bounds(CGRectMake(10, -2, 15, 15));
        confer.text(@"阴影测试2").shadow.color(RGB(134, 230, 51)).offset(CGSizeMake(10, 10)).radius(5);
        confer.text(@"阴影测试3").shadow.color(RGB(234, 30, 51)).offset(CGSizeMake(10, 10)).radius(5);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
