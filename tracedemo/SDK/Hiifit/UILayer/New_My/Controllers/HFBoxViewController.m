//
//  HFBoxViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/29.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFBoxViewController.h"
#import "HFBoxTableViewCell.h"
#import "WebViewController.h"
#import "SudoViewController.h"
#import "HFHabitViewController.h"
#import "BaseTableView.h"
#import "MainViewController.h"
@interface HFBoxViewController ()<UITableViewDataSource, UITableViewDelegate, BaseTableViewDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
@implementation HFBoxViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        if (IOS7_OR_LATER) {
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationTitle:@"嗨盒"];
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.baseDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HFBoxTableViewCell" bundle:nil] forCellReuseIdentifier:@"HFBoxTableViewCell"];
    
    _tableView.bPullDownRefreash = YES;
    _tableView.bPullUpRefreash = NO;
    [_tableView startRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    WS(weakSelf);
    [[[HIIProxy shareProxy]homeProxy]getModulesList:^(NSArray<HiModuleData> *modulesList, BOOL success) {
        [weakSelf.tableView endRefreash];
        if (success) {
            [weakSelf.dataSource removeAllObjects];
            for (HiModuleData *list in modulesList) {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:list.modelList];
                [weakSelf.dataSource addObjectsFromArray:arr];
            }
            [_tableView reloadData];
        }
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HiModuleListData *data = [self.dataSource objectAtIndex:indexPath.row];
    
    HFBoxTableViewCell *cell = (HFBoxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HFBoxTableViewCell" forIndexPath:indexPath];
    [cell setContentToCell:data];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.f;
}   

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HiModuleListData *data = [self.dataSource objectAtIndex:indexPath.row];
    
    [[UIKitTool getAppdelegate]goModuleDetail:data.id];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - BaseTableViewDelegate

- (void)pullDownAction
{
    [self loadData];
}

#pragma mark - private method

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

//- (void)goModuleDetail:(NSInteger)moduleId
//{
//    NSString *urlStr = nil;
//    HIModuleType type = 0;
//    switch (moduleId) {
//        case HIModuleTypeCalorie:
//            [MobClick event:HabitBox_Kaluli];
//            urlStr = kURLModuleCalorie;
//            type = HIModuleTypeCalorie;
//            break;
//        case HIModuleTypeDiseaseKnow:
//            [MobClick event:HabitBox_Illness_Knowledge];
//            urlStr = kURLModuleDisease;
//            type = HIModuleTypeDiseaseKnow;
//            break;
//        case HIModuleTypeDrugHelp:
//            [MobClick event:HabitBox_Assi];
//            urlStr = kURLModuleHelp;
//            type = HIModuleTypeDrugHelp;
//            break;
//        case HIModuleTypeGame:
//        {
//            [MobClick event:HabitBox_Sudo_Game];
//            SudoViewController *vc = [[SudoViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case HIModuleTypeHabit:
//        {
//            [MobClick event:HabitBox_Habit];
//            HFHabitViewController *vc = [[HFHabitViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case HIModuleTypeHealthNews:
//            [MobClick event:HabitBox_Health_Ask];
//            urlStr = kURLModuleInformation;
//            type = HIModuleTypeHealthNews;
//            break;
//        case HIModuleTypeSelfCheck:
//            [MobClick event:HabitBox_Health_Check];
//            urlStr = kURLModuleCheckHealth;
//            type = HIModuleTypeSelfCheck;
//            break;
//        case HIModuleTypeTestTools:
//            [MobClick event:HabitBox_Health_Test];
//            urlStr = kURLModuleCheckTool;
//            type = HIModuleTypeTestTools;
//            break;
//        default:
//            break;
//    }
//    if (urlStr) {
//        WebViewController *vc = [[WebViewController alloc]init];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setValue:urlStr forKey:kParamURL];
//        vc.param = dic;
//        vc.moduleType = type;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

@end
