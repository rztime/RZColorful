//
//  RZColorfulDemoViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/8/4.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "RZColorfulDemoViewController.h"
#import "common.h"
#import "RZColorful.h"

@interface RZColorfulDemoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;

}

@end

@implementation RZColorfulDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(255, 255, 255);
    self.title = @"实战演练";

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
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
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
    }

    [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"姓名: ").textColor(RGB(152, 152, 152)).font(FONT(15));
//        confer.text(@"%@", indexPath.row).textColor(RGB(51, 51, 51)).font(FONT(17));
//        confer.text(@"当前行:%@", indexPath.row);
    }];
    return cell;
}

@end
