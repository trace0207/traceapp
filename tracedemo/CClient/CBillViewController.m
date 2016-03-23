//
//  CBillViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/23.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "CBillViewController.h"
#import "KTDropdownMenuView.h"
#import "UIColor+TK_Color.h"
#import "TK_SettingCell.h"
@interface CBillViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)KTDropdownMenuView *menuView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation CBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.tableView reloadData];
}

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
        //NSDictionary *dic1 = [];
    }
    return _data;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKaddNavigationTitle:@"我的账单"];
    [self addRightBarItemWithCustomView:self.menuView];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (KTDropdownMenuView *)menuView
{
    if (_menuView == nil) {
        NSArray *titles = @[@"01月", @"02月",@"03月", @"04月",@"05月", @"06月",@"07月", @"08月",@"09月", @"10月",@"11月", @"12月"];
        _menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,40, 44) titles:titles];
        _menuView.cellColor = [UIColor clearColor];
        _menuView.cellSeparatorColor = [UIColor lightGrayColor];
        _menuView.selectedAtIndex = ^(int index)
        {
            NSLog(@"selected title:%@", titles[index]);
        };
        _menuView.textFont = [UIFont systemFontOfSize:15];
        _menuView.backgroundAlpha = 0.0f;
        _menuView.width = 90;
        _menuView.edgesRight = -15;
        _menuView.textColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellAccessoryCheckmarkColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellSeparatorColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
    }
    return _menuView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [TK_SettingCell loadDefaultTextType:self];
    }
    cell.label1.text = @"收到来自趣拍的一笔退款";
    cell.label2.text = @"+1000";
    return cell;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    
    if (section == 0) {
        label.text = @"    14日-星期三";
    }else {
        label.text = @"    13日-星期四";
    }
    return label;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


@end
