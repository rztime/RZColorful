//
//  ViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "ViewController.h"
#import "RZColorful.h"
#import <CoreText/CoreText.h>
#define rzFont(font) [UIFont systemFontOfSize:font]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define GRAY(c) RGBA(c, c, c, 1)
@interface ViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>
/** <#bref#> */
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @{@"name":@"富文本的初始化", @"class": @"RZRichAttributedInitDemoViewController"},
            @{@"name":@"富文本的一些用法", @"class": @"RZAttributedStringDemoVC"},
            @{@"name":@"UITextView的图文混排", @"class": @"RZTextViewDemoVC"},  
        ].mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"富文本的简单使用";
     
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary *dict = self.dataSource[indexPath.row];
    UIViewController *vc = [NSClassFromString(dict[@"class"]) new];
    [self.navigationController pushViewController:vc animated:YES];
    vc.title = dict[@"name"];
    
}
@end
