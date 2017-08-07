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

@interface LabelExampleViewController ()

@end

@implementation LabelExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.numberOfLines = 0;
    [self.view addSubview:label];

    // 基本简单使用方法
//    [label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
//        // 设置文本颜色
//        confer.text(@"荷花开后西湖好，\n").textColor(RGB(255, 0, 0));
//        // 设置文本字体
//        confer.text(@"载酒来时。\n").font(FONT(19));
//        // 可以将属性连起来
//        confer.text(@"不用旌旗，\n").textColor(RGB(255, 0, 0)).font(FONT(19));
//        // 更多属性方法可以参考 RZColorfulAttribute.h文件 基本属性设置
//        // 基本属性包含 文本颜色、文字所在区域背景色，字体，连体字，字间距，删除线以及其颜色，下划线以及其颜色，描边，横竖排版，斜体字，拉伸字体（扩展）,带url的文本等
//        confer.text(@"前后红幢绿盖随。\n").textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
//    }];

    // 基本简单使用方法 包含特殊的属性（阴影、段落），有且只有这两个属性设置稍有不同
//    [label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
//         // 设置阴影，偏移量，颜色，模糊等等
//        confer.text(@"画船撑入花深处，\n").shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9));
//        // 可设置好文本属性在设置阴影
//        confer.text(@"香泛金卮。\n").font(FONT(19)).textColor(RGB(255, 0 , 0)).shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9));
//        // 也可以使用连接词and/with/end之后，在继续设置文本的属性
//        confer.text(@"烟雨微微，\n").shadow.offset(CGSizeMake(5, 5)).radius(3).color(RGB(233, 100, 9)).and.textColor(RGB(255, 0, 0)).font(FONT(19));
//        // 段落使用方法及技巧也是同样如此，具体方法参照 RZParagraphStyle.h设置
//        confer.text(@"一片笙歌醉里归。\n").paragraph.alignment(1).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
//    }];

//    // 设置统一段落样式
//    [label rz_colorfulWithParagraphStyle:^(RZParagraphStyle * _Nullable paragraph) {
//        // 这里设置统一的段落样式，即confer.text（）都遵循此段落样式
//        // 这里设置完后请勿使用and/with/end连接词，使用无效
//        paragraph.lineSpacing(5).alignment(1);
//
//    } confer:^(RZColorfulConferrer * _Nonnull confer) {
//        // 所有的text内容都遵循上边的paragraphStyle，这里设置paragraph将无效。
//        confer.text(@"常记溪亭日暮，\n沉醉不知归路。\n").paragraph.alignment(0).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
//        confer.text(@"兴尽晚回舟，\n误入藕花深处。\n争渡，争渡，惊起一滩鸥鹭。\n").paragraph.alignment(3).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
//    }];

    [label rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.paragraphStyle.lineSpacing(15).baseWritingDirection(1);
        confer.text(@"常记溪亭日暮，\n沉醉不知归路。\n").textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
        confer.text(@"兴尽晚回舟，\n误入藕花深处。\n争渡，争渡，惊起一滩鸥鹭。\n").paragraph.alignment(3).and.textColor(RGB(255, 0, 0)).font(FONT(19)).underLineStyle(3);
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
