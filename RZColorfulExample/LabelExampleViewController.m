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

    }];

    [cell.textLabel rz_colorfulConferAppend:^(RZColorfulConferrer *confer) {
        confer.text(@"此方法在原内容上增加文本\n");
        confer.text(@"空心描边\n").strokeColor(RGB(255, 0, 0)).strokeWidth(@3).font(FONT(30));
        confer.text(@"横竖排版好像iOS上并没有卵用\n").verticalGlyphForm(@1);
        confer.text(@"斜体字设置 > 0\n").italic(@1);
        confer.text(@"斜体字设置 < 0\n").italic(@(-1));
        confer.text(@"拉伸字体\n").expansion(@2);
        confer.text(@"【text】之后的属性添加方法具体可以查看RZColorfulAttribute.h").font(FONT(21)).textColor(RGB(255, 0, 0));
        confer.text(@"  还有几个方法还未实现，我会在稍后继续完善").font(FONT(21)).textColor(RGB(255, 0, 0));
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
