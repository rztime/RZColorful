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
        confer.text(@"hello，大家好\n").font(FONT(21));
        confer.appendImage([UIImage imageNamed:@"flower"]);
        confer.text(@"设置颜色加字体\n").textColor(RGB(255, 255 ,80)).font(FONT(25));
        confer.text(@"颜色加字体,以及字体所在加个背景\n").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230));
        confer.text(@"添加一张图片，要使其和文本对齐，设置bounds.origin.y为适当负值，且size和前后文本大小差不多一致").font(FONT(20));
        confer.appendImage([UIImage imageNamed:@"flower"]).bounds(CGRectMake(10, -2, 20, 20));
        confer.text(@"\n颜色加字体,加个背景, 加点间距\n").textColor(RGB(255, 55 ,80)).font(FONT(25)).backgroundColor(RGB(230, 230, 230)).wordSpace(@15);
        confer.text(@"\n限时特卖 加个删除线\n").strikeThrough(RZLineStyleSignl);
        // 插入图片时，可以设置图片和前后排文字字体大小一样，并且设置其origin.y 为适当负值，可对齐文本
        confer.appendImage([UIImage imageNamed:@""]).bounds(CGRectMake(10, -2, 15, 15));
        // 设置段落样式、阴影为两种方法，一种为全当前cofer的全文本统一样式
        // 另一种是局部设置段落、阴影样式，局部优先级高于全文统一样式
        confer.paragraphStyle.lineSpacing(25).headIndent(20);    // 这里请勿使用and等连接词返回
        confer.text(@"局部段落样式").paragraphStyle.lineSpacing(5).headIndent(0).baseWritingDirection(NSWritingDirectionRightToLeft); //这里可以使用and等连接词继续返回设置text的属性

    }];

    [textView rz_colorfulConferAppend:^(RZColorfulConferrer *confer) {
        confer.text(@"此方法在原内容上增加文本\n");
        confer.text(@"空心描边\n").strokeColor(RGB(255, 0, 0)).strokeWidth(@3).font(FONT(30));
        confer.text(@"横竖排版好像iOS上并没有卵用\n").verticalGlyphForm(@1);
        confer.text(@"斜体字设置 > 0\n").italic(@1);
        confer.text(@"斜体字设置 < 0\n").italic(@(-1));
        confer.text(@"拉伸字体\n").expansion(@2);
        confer.text(@"设置点击的链接属性，需要textView.editable = NO\n");
        confer.text(@"可以添加一个带有url的字符串,可点击\n").underLineStyle(1).url([NSURL URLWithString:@"http:www.baidu.com"]).font(FONT(30));

        confer.text(@"【text】之后的属性添加方法具体可以查看RZColorfulAttribute.h").font(FONT(21)).textColor(RGB(255, 0, 0));
        // 阴影设置完之后如还需设置其他属性，可直接使用and，with，end连接词以继续添加text的属性
        confer.text(@"阴影测试").shadow.offset(CGSizeMake(10, 10)).radius(1).and.font(FONT(40)).textColor(RGB(255, 0, 0));
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
