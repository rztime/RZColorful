//
//  RZAttributedStringDemoVC.m
//  RZColorfulExample
//
//  Created by xk_mac_mini on 2019/11/20.
//  Copyright © 2019 rztime. All rights reserved.
//

#import "RZAttributedStringDemoVC.h"
#import "UILabel+RZColorful.h"
#import "NSAttributedString+RZColorful.h"

@interface RZAttributedStringDemoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RZAttributedStringDemoVC


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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 0;
    }
    cell.detailTextLabel.text = @"";
    if (indexPath.row == 0) {
        [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
            confer.text(@"富文本的初始化请参考RZRichAttributedInitDemoViewController的demo");
        }];
    } else if (indexPath.row == 1) {
        [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
            confer.text(@"html与富文本的互换");
        }];
    } else if (indexPath.row == 2) {
        NSAttributedString *attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer *confer) {
            confer.text(@"简单的几个字转成html").textColor(UIColor.redColor).font([UIFont systemFontOfSize:18]);
        }];
        NSArray *images = [attr rz_images];
        NSMutableArray *urls;
        if (images) {
            urls = [NSMutableArray new];
        }
        // 将富文本转换成html，如果有图片，可以对图片先进行上传到服务器，拿到URL，在写入，转成html
        NSString *html = [attr rz_codingToHtmlWithImagesURLSIfHad:urls];
        //        html = [attr rz_codingToCompleteHtml];  没有图片时，可以直接使用此方法
        cell.textLabel.text = html;
    } else if (indexPath.row == 3) {
        NSAttributedString *attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer *confer) {
            confer.text(@"简单的几个字html转成NSAttributeString").textColor(UIColor.redColor).font([UIFont systemFontOfSize:18]);
        }];
        NSArray *images = [attr rz_images];
        NSMutableArray *urls;
        if (images) {
            urls = [NSMutableArray new];
        }
        // 将富文本转换成html，如果有图片，可以对图片先进行上传到服务器，拿到URL，在写入，转成html
        NSString *html = [attr rz_codingToHtmlWithImagesURLSIfHad:urls];
        [cell.textLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
            confer.htmlText(html);
        }];
        //        cell.textLabel.attributedText = [NSAttributedString htmlString:html];// 也可以使用此方法
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"[NSAttributedString rz_linesIfDrawInRect:]可以获取到每一行文字的内容及其range";
    } else if (indexPath.row == 5) {
        NSAttributedString *attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer *confer) {
            confer.text(@"第1行\n第2行\n第3行\n第4行\n第5行\n第6行\n第7行\n");
        }];
        NSArray <RZAttributedStringInfo * > *lines = [attr rz_linesIfDrawInRect:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200)];
        cell.textLabel.attributedText =  lines[0].attributedString;
        cell.detailTextLabel.text = NSStringFromRange(lines[0].range);
    } else if (indexPath.row == 6) {
        NSAttributedString *attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer *confer) {
            confer.text(@"第1行\n第2行\n第3行\n第4行\n第5行\n第6行\n第7行\n");
        }];
        NSArray <RZAttributedStringInfo * > *lines = [attr rz_linesIfDrawInRect:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200)];
        cell.textLabel.attributedText = lines[1].attributedString;
        cell.detailTextLabel.text = NSStringFromRange(lines[1].range);
    } else if (indexPath.row == 7) {
        NSAttributedString *attr = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer *confer) {
            confer.text(@"第1行\n第2行\n第3行\n第4行\n第5行\n第6行\n第7行\n");
        }];
        NSArray <RZAttributedStringInfo * > *lines = [attr rz_linesIfDrawInRect:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200)];
        cell.textLabel.attributedText = lines[4].attributedString;
        cell.detailTextLabel.text = NSStringFromRange(lines[4].range);
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"其他的可以查看NSAttributedString+RZColorful.h的方法"];
    }
    
    return cell;
}

@end

