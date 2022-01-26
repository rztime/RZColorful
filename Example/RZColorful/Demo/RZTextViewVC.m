//
//  RZTextViewVC.m
//  RZColorful_Example
//
//  Created by rztime on 2022/1/26.
//  Copyright © 2022 rztime. All rights reserved.
//

#import "RZTextViewVC.h"
#import <Masonry.h>
#import <RZColorful.h>

@interface RZTextViewVC ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation RZTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _textView = [[UITextView alloc] init];
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset((-20));
        make.height.equalTo(@300);
    }];
    _textView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    _textView.linkTextAttributes = @{};
    
    [_textView rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"百年来，我们党团结带领人民进行的一切奋斗、一切牺牲、一切创造").font([UIFont systemFontOfSize:16]).textColor([UIColor blackColor]);
        confer.text(@"都是在践行为中国人民谋幸福、为中华民族谋复兴的初心使命\n中国共产党的成就和贡献，不仅是历史性的，也是世界性的").font([UIFont systemFontOfSize:16]).textColor([UIColor redColor]);
        confer.text(@"\n\n\n");
        confer.text(@"添加链接").font([UIFont systemFontOfSize:18]).textColor([UIColor blueColor]).tapAction(@"点击事件");
    }];
 
    _textView.rzDidTapTextView = ^BOOL(id  _Nullable tapObj) {
        NSString *obj = [((NSURL *)tapObj).absoluteString rz_decodedString];
        NSLog(@"%@", obj); // http://www.baidu.com
        return false;
    };
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
