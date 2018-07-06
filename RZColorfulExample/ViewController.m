//
//  ViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/25.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "ViewController.h"
#import "RZColorful.h"

#define rzFont(font) [UIFont systemFontOfSize:font]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define GRAY(c) RGBA(c, c, c, 1)
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"富文本的简单使用";

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 500;
    }
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 0;
    }
    if (indexPath.row == 0) {
        [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
            confer.paragraphStyle.lineSpacing(5).paragraphSpacingBefore(5).alignment(NSTextAlignmentCenter); // 段落全局样式
            confer.shadow.color(RGBA(255, 0, 0, 0.3)).offset(CGSizeMake(1, 1));   // 阴影全局
            
            // 此部分显示全局样式的风格 （红色阴影，居中对齐，段落行距等）
            confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, -2, 15, 15));
            confer.text(@" 姓名: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11));
            confer.text(@"rztime").font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
            
            confer.text(@"\n");
            confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, -2, 15, 15));
            confer.text(@" 时间: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11));
            confer.text([NSString stringWithFormat:@"%@", [NSDate new]]).font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
            
            // 此部分显示全局样式的风格 （居中对齐，段落行距等）  阴影将被局部覆盖（灰色）
            confer.text(@"\n地址: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11)).paragraphStyle.paragraphSpacingBefore(20).and.shadow.color(GRAY(151)).offset(CGSizeMake(3, 3));;
            confer.text(@"成都-软件园").font(rzFont(15)).textColor(RGBA(51, 51, 51, 1)).shadow.color(GRAY(151)).offset(CGSizeMake(3, 3));
            
            // 此部分段落样式被局部覆盖  阴影显示全局的
            confer.text(@"\n爱好: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11)).paragraphStyle.paragraphSpacingBefore(20);
            confer.text(@"游山、").font(rzFont(15)).textColor(RGBA(151, 51, 51, 1));
            confer.text(@"玩水、").font(rzFont(10)).textColor(RGBA(51, 151, 51, 1));
            confer.text(@"听歌、").font(rzFont(18)).textColor(RGBA(51, 51, 151, 1));
            confer.text(@"美食、").font(rzFont(17)).textColor(RGBA(51, 151, 51, 1));
            confer.text(@"看电影、").font(rzFont(16)).textColor(RGBA(151, 51, 51, 1));
            confer.text(@"撸代码、").font(rzFont(15)).textColor(RGBA(51, 151, 51, 1));
            confer.text(@"等等\n\n").font(rzFont(15)).textColor(RGBA(251, 51, 51, 1));
            
            confer.appendImageByUrl(@"http://pic28.photophoto.cn/20130830/0005018667531249_b.jpg").bounds(CGRectMake(0, 0, 200, 0)).paragraphStyle.alignment(NSTextAlignmentLeft); // 宽或高为0时，即自动宽/高按照图片比例来
            
            confer.text(@"\n");
            NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
            NSString *filePath =[resourcePath stringByAppendingPathComponent:@"test.html"];
            NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            confer.htmlText(htmlstring);
        }];
    } else {
        [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
            confer.paragraphStyle.paragraphSpacing(15); // 设置段落之间的行距
            
            confer.text(@"日常用处:(图片+标题+描述)\n").font(rzFont(17)).textColor([UIColor redColor]);
            
            confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, -2, 15, 15)); // 图片
            confer.text(@" 姓        名: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11));
            confer.text(@"rztime").font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
            
            confer.text(@"\n");
            confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, -2, 15, 15));
            confer.text(@" 时        间: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11));
            confer.text([NSString stringWithFormat:@"%@", [NSDate new]]).font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
            
            confer.text(@"\n");
            confer.appendImage([UIImage imageNamed:@"test.jpg"]).bounds(CGRectMake(0, -2, 15, 15));
            confer.text(@" 当次消费: ").font(rzFont(15)).textColor(RGBA(151, 151, 151, 11));
            confer.text(@"￥").font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
            confer.text(@"100").font(rzFont(15)).textColor(RGBA(251, 51, 51, 1));
            confer.text(@"元").font(rzFont(15)).textColor(RGBA(51, 51, 51, 1));
        }];
    }


    return cell;
}

@end
