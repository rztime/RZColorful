//
//  RZTextViewDemoVC.m
//  RZColorfulExample
//
//  Created by xk_mac_mini on 2019/11/20.
//  Copyright © 2019 rztime. All rights reserved.
//

#import "RZTextViewDemoVC.h"
#import "NSAttributedString+RZColorful.h"
#import <Masonry/Masonry.h>
#import "UITextView+RZColorful.h"

@interface RZTextViewDemoVC ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView; 
@end

@implementation RZTextViewDemoVC


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
        UITextView *textView = [[UITextView alloc] init];
        [cell.contentView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.delegate = self;
        textView.tag = 100;
        textView.rzDidTapTextView = ^BOOL(id  _Nullable tapObj) {
            NSString *url = tapObj;
            if ([tapObj isKindOfClass:[NSURL class]]) {
                url = [(NSURL *)tapObj absoluteString];
            }
            url = url.rz_decodedString;
            
            NSLog(@"rzDidTapTextView：tapObj:%@  \n如果url中包含了有中文,URL将会进行编码，所以请rz_decodedString解码之后查看:%@", tapObj, url);
            return NO;
        };
        textView.linkTextAttributes = @{}; // 请将url的属性置空，这样在设置tapAction时，才会按自定义属性显示
    }
    UITextView *textView = [cell.contentView viewWithTag:100];
    [textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"初始化方法和RZRichAttributedInitDemoViewController里的demo有详解\n\n");
        confer.text(@"给文字添加点击事件,点击事件可在deleagte中或rzDidTapTextView实现区分\n");
        confer.text(@"点击查看 tapAction").tapAction(@"这是tapAction点击事件的回调").textColor(UIColor.redColor);
        confer.text(@"\n\n");
        confer.text(@"点击查看 url").url([NSURL URLWithString:@"xxxxxxx"]);
    }];
    
    return cell;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *url = URL;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = [(NSURL *)URL absoluteString];
    }
    url = url.rz_decodedString;
    
    NSLog(@"delegate: URL:%@  \n如果url中包含了有中文,URL将会进行编码，所以请rz_decodedString解码之后查看:%@", URL, url);
    return NO;
}

@end
