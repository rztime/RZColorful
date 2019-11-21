//
//  RZRichAttributedInitDemoViewController.m
//  RZColorfulExample
//
//  Created by xk_mac_mini on 2019/11/20.
//  Copyright © 2019 rztime. All rights reserved.
//

#import "RZRichAttributedInitDemoViewController.h"
#import "UILabel+RZColorful.h"
#import "NSAttributedString+RZColorful.h"

@interface RZRichAttributedInitDemoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RZRichAttributedInitDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 0;
        
    }
    cell.textLabel.attributedText = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer *confer) {
        confer.text(@"富文本的属性很多，包含了如字体颜色、大小、行距、间距、图片、超链接、阴影等等,在配置富文本时，如果只用系统的NSAttributedString来设置，无疑是很复杂麻烦的，所以这里提供简洁的方法以供使用\n\n\n").font([UIFont systemFontOfSize:15]).textColor(UIColor.blackColor);
        confer.text(@"NSAttributedString适用于UILabel,UITextField,UITextView,\n其中\nUITextField 不支持图片\nUILabel 支持图文混排，不支持超链接\nUITextView  支持图文混排，支持超链接\n\n\n").font([UIFont systemFontOfSize:15]).textColor(UIColor.blackColor);
        
        confer.text(@"1.要设置文本，直接用confer.text(文本内容),然后使用点语法，后边可连接包括").font([UIFont systemFontOfSize:15]).textColor(UIColor.blackColor);
        confer.text(@"\n");
        confer.text(@"(字体颜色)").textColor(UIColor.redColor);
        confer.text(@"\n");
        confer.text(@"(字体背景颜色)").backgroundColor(UIColor.grayColor);
        confer.text(@"\n");
        confer.text(@"(字体大小)").font([UIFont systemFontOfSize:18]);
        confer.text(@"\n");
        confer.text(@"连体字").ligature(@(1));
        confer.text(@"\n");
        confer.text(@"字间距").wordSpace(@(3));
        confer.text(@"\n");
        confer.text(@"删除线及颜色、粗细").strikeThrough(1).strikeThroughColor(UIColor.blueColor);
        confer.text(@"\n");
        confer.text(@"下划线线及颜色、粗细").strikeThrough(1).strikeThroughColor(UIColor.redColor);
        confer.text(@"\n");
        confer.text(@"描边的画笔大小和颜色").strokeWidth(@(2)).strokeColor(UIColor.orangeColor);
        confer.text(@"\n");
        confer.text(@"横竖排版").verticalGlyphForm(@(1));
        confer.text(@"\n");
        confer.text(@"斜体字").italic(@(1));
        confer.text(@"\n");
        confer.text(@"拉伸").expansion(@(1));
        confer.text(@"\n");
        confer.text(@"上标和下标等等").baselineOffset(@(1));
        confer.text(@"上标").baselineOffset(@(3));
        confer.text(@"下标").baselineOffset(@(-3));
        confer.text(@"\n");
        confer.text(@"书写（从左至右）等等").writingDirection(RZWDRightToLeft).paragraphStyle.alignment(NSTextAlignmentRight);
        confer.text(@"\n");
        confer.text(@"超链接url(UITextView中实现rzDidTapTextView或实现url点击代理此点击才有效)").tapAction(@"http:www.baidu.com");
        confer.text(@"\n");
        confer.text(@"阴影").shadow.color(UIColor.redColor).radius(3).offset(CGSizeMake(3, 3));
        confer.text(@"\n");
        confer.text(@"段落的样式（包含了行距、间距、对齐方式等等）").paragraphStyle.alignment(NSTextAlignmentCenter);
        confer.text(@"\n\n\n");
        
        confer.text(@"2").textColor(UIColor.greenColor);
        confer.appendImage([UIImage imageNamed:@"test.jpg"]).size(CGSizeMake(40, 40), RZHorizontalAlignCenter, [UIFont systemFontOfSize:15]);
        confer.text(@"添加图片 还可以连接tapAction,段落样式等等\n");
        confer.appendImageByUrl(@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574248377078&di=cf53e56d95c97225082e2063d94fb151&imgtype=0&src=http%3A%2F%2Fi1.sinaimg.cn%2Fent%2Fd%2F2008-06-04%2FU105P28T3D2048907F326DT20080604225106.jpg").size(CGSizeMake(40, 40), RZHorizontalAlignCenter, [UIFont systemFontOfSize:15]);
        confer.text(@"通过url添加的图片，好像无法控制其位置\n\n");
        
        confer.text(@"除了shadown(阴影),paragraphStyle(段落样式), 其他属性都可以直接在.text()后，通过“.”连接起来使用\n\n").font([UIFont systemFontOfSize:17]).textColor(UIColor.redColor).underLineStyle(1).underLineColor(UIColor.blackColor);
        confer.text(@"shadown(阴影),paragraphStyle(段落样式)可在confer.后直接连接，此时将把此属性赋给所有的文本，即设置之后全局将共用\n\n").font([UIFont systemFontOfSize:17]).textColor(UIColor.redColor).underLineStyle(1).underLineColor(UIColor.blackColor);;
        confer.text(@"shadown(阴影),paragraphStyle(段落样式)也可以在.text()之后连接，此时全局的shadown、paragraphStyle将被覆盖，可用and等连接词继续连接.text()之后的属性\n\n").font([UIFont systemFontOfSize:17]).textColor(UIColor.redColor).underLineStyle(1).underLineColor(UIColor.blackColor);
    }];
    // 或者使用下列方法
    //    [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
    //
    //    }];
    return cell;
}

@end


