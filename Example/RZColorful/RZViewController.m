//
//  RZViewController.m
//  RZColorful
//
//  Created by rztime on 01/14/2022.
//  Copyright (c) 2022 rztime. All rights reserved.
//

#import "RZViewController.h"
#import <RZColorful/RZColorful.h>
#import <Masonry/Masonry.h>

@interface RZViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@end

@implementation RZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _items = @[@{@"富文本常规使用": @"AttributedStringUseDemoVC"},
               @{@"显示折叠展开的label": @"RZFoldLabelVC"},
               @{@"UITextView常规使用": @"RZTextViewVC"},];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = item.allKeys.firstObject;
    cell.detailTextLabel.text = item.allValues.firstObject;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    NSDictionary *item = self.items[indexPath.row];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(item.allValues.firstObject) alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
