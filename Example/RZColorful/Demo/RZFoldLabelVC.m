//
//  RZFoldLabelVC.m
//  RZColorful_Example
//
//  Created by rztime on 2022/1/26.
//  Copyright © 2022 rztime. All rights reserved.
//

#import "RZFoldLabelVC.h"
#import <RZColorful.h>
#import <Masonry.h>

@implementation FoldModel

- (instancetype)init {
    if (self = [super init]) {
        _text = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
            confer.text(@"百年来，我们党团结带领人民进行的一切奋斗、一切牺牲、一切创造，都是在践行为中国人民谋幸福、为中华民族谋复兴的初心使命\n中国共产党的成就和贡献，不仅是历史性的，也是世界性的\n中国共产党人的历史自信，既是对奋斗成就的自信，也是对奋斗精神的自信\n从一大会址复原场景到遵义会议复原景观，从开国大典影像到创办经济特区图片，从脱贫攻坚数据图表到火神山、雷神山医院模型……走进中国共产党历史展览馆，一幅幅图片、一件件文物、一个个场景，全方位、全过程、全景式、史诗般展现中国共产党波澜壮阔的百年历程，让参观者从内心深处感受震撼，升腾起昂扬向上的力量。").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor);
        }];
        _showAll = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
            confer.text(@"...").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor);
            confer.text(@"显示全文").font([UIFont systemFontOfSize:16]).textColor(UIColor.redColor).tapActionByLable(@"showAll");
        }];
        _showFold = [NSAttributedString rz_colorfulConfer:^(RZColorfulConferrer * _Nullable confer) {
            confer.text(@"...").font([UIFont systemFontOfSize:16]).textColor(UIColor.blackColor);
            confer.text(@"折叠").font([UIFont systemFontOfSize:16]).textColor(UIColor.redColor).tapActionByLable(@"showFold");
        }];
        _isFold = YES;
    }
    return self;
}

@end


@interface RZFoldLabelVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation RZFoldLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.estimatedRowHeight = 100;
    [self.view addSubview:_tableView];
    _items = @[].mutableCopy;
    for (NSInteger i = 0; i < 50; i++) {
        FoldModel *model = [[FoldModel alloc] init];
        [_items addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RZFoldTestCell *cell = (RZFoldTestCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[RZFoldTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        __weak typeof(self) weakSelf = self;
        [cell.titleLabel rz_tapAction:^(UILabel * _Nonnull label, NSString * _Nonnull tapActionId, NSRange range) {
            if ([tapActionId isEqualToString:@"showAll"]) {
                NSLog(@"显示全文");
            } else if ([tapActionId isEqualToString:@"showFold"]) {
                NSLog(@"折叠");
            }
            FoldModel *model = weakSelf.items[label.tag];
            model.isFold = !model.isFold;
            [weakSelf.tableView reloadData];
        }];
    }
    cell.titleLabel.tag = indexPath.row;
    FoldModel *model = _items[indexPath.row];
    [cell.titleLabel rz_setAttributedString:model.text maxLine:4 maxWidth:self.view.bounds.size.width - 40 isFold:model.isFold showAllText:model.showAll showFoldText:model.showFold];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:false];
}

@end

@implementation RZFoldTestCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 20, 10, 20));
        }];
    }
    return _titleLabel;
}

@end
