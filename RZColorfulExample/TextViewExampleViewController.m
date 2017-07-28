//
//  TextViewExampleViewController.m
//  RZColorfulExample
//
//  Created by 乄若醉灬 on 2017/7/26.
//  Copyright © 2017年 rztime. All rights reserved.
//

#import "TextViewExampleViewController.h"
#import "common.h"
#import "RZColorful.h"

@interface TextViewExampleViewController ()<UITextViewDelegate>
{
    UITextView *textView;
}

@end

@implementation TextViewExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    textView = [[UITextView alloc] initWithFrame:self.view.frame];
    textView.delegate = self;
    [self.view addSubview:textView];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:18];
    [textView rz_colorfulConfer:^(RZColorfulConferrer *confer) {
        confer.text(@"hello，大家好，先来默认数据").font(FONT(21));
        confer.appendImage([UIImage imageNamed:@"flower"]);
        confer.text(@"先来个红色").textColor(RGB(255, 0 ,0));
        confer.text(@"继续看颜色加字体").textColor(RGB(255, 255 ,80)).font(FONT(25));
        confer.text(@"继续看颜色加字体,给字加个背景").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230));
        confer.text(@"flush 连体字效果没看出来").ligature(@1);
        confer.appendImage([UIImage imageNamed:@"flower"]).bounds(CGRectMake(10, -2, 15, 15));
        confer.text(@"继续看颜色加字体,给字加个背景, 加点间距").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230)).wordSpace(@15);
        confer.text(@"限时特卖 加个删除线").strikeThrough(RZLineStyleSignl);
        // 插入图片时，可以设置图片和前后排文字字体大小一样，并且设置其origin.y 为适当负值，可对齐文本
        confer.appendImage([UIImage imageNamed:@""]).bounds(CGRectMake(10, -2, 15, 15));
        confer.text(@"删除线颜色修改").textColor(RGB(255, 0, 0)).font(FONT(15));


    }];

    [textView rz_colorfulConferAppend:^(RZColorfulConferrer *confer) {
        confer.text(@"此方法在原内容上增加文本\n");
        confer.text(@"空心描边\n").strokeColor(RGB(255, 0, 0)).strokeWidth(@3).font(FONT(30));
        confer.text(@"横竖排版好像iOS上并没有卵用\n").verticalGlyphForm(@1);
        confer.text(@"斜体字设置 > 0\n").italic(@1);
        confer.text(@"斜体字设置 < 0\n").italic(@(-1));
        confer.text(@"拉伸字体\n").expansion(@2);
        confer.text(@"设置点击的链接属性，需要textView.editable = NO\n");
        confer.text(@"可以添加一个带有url的字符串,可点击\n").underLineStyle(1).url(nil).font(FONT(30));

        confer.text(@"【text】之后的属性添加方法具体可以查看RZColorfulAttribute.h").font(FONT(21)).textColor(RGB(255, 0, 0));
        confer.text(@"  还有段落方法还未实现，我会在稍后继续完善\n").font(FONT(21)).textColor(RGB(255, 0, 0));
        // 阴影设置完之后如还需设置其他属性，可直接使用and，with，end连接词以继续添加text的属性
        confer.text(@"阴影测试").shadow.offset(CGSizeMake(10, 10)).radius(5).and.font(FONT(40)).textColor(RGB(255, 0, 0));
        confer.text(@"阴影测试2").shadow.color(RGB(0, 255, 0)).offset(CGSizeMake(10, 10)).radius(5).and.font(FONT(22));
        confer.text(@"阴影测试3").shadow.color(RGB(0, 0, 255)).offset(CGSizeMake(10, 10)).radius(5);
        confer.text(@"阴影测试4").shadow.color(RGB(0, 255, 255)).offset(CGSizeMake(-10, 10)).radius(5);
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
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"URL:%@", URL);
    return YES;
}

@end
