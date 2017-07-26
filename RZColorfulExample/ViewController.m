//
//  ViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "ViewController.h"
#import "LabelExampleViewController.h"
#import "TextViewExampleViewController.h"
#import "TextFiledExampleViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"富文本的简单使用";

    _dataArray = @[
                   @"UILabel     富文本使用",
                   @"UITextView  富文本使用",
                   @"UITextFiled 富文本使用"];

    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _dataArray[indexPath.section];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        LabelExampleViewController *vc = [[LabelExampleViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
        TextViewExampleViewController *vc = [[TextViewExampleViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        TextFiledExampleViewController *vc = [[TextFiledExampleViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
