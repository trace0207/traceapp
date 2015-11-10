//
//  HFSchemeListViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/23.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFSchemeListViewController.h"
#import "HFAdvanceSchemeCell.h"
#import "MainPageAdvanceSchemeAck.h"
#import "HFAdvanceSchemeContainerViewController.h"
@interface HFSchemeListViewController ()<UITableViewDataSource,UITableViewDelegate,HFAdvanceSchemeCellDelegate>

@property(nonatomic,strong)UIView * mHeadView;
@property(nonatomic,strong)MainPageAdvanceSchemeData * adSchemeData;
@end

@implementation HFSchemeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mTableView.tableFooterView = [[UIView alloc] init];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addNavigationTitle:@"调理方案列表"];
    
    [self getAdvanceSchemeInfo];
    
}


//获取高级方案信息
- (void)getAdvanceSchemeInfo
{
    WS(weakSelf)
    [[[HIIProxy shareProxy] schemeProxy] getAdvanceSchemeWithBlock:^(HF_BaseAck *ack) {
        MainPageAdvanceSchemeAck * ret = (MainPageAdvanceSchemeAck *)ack;
        
        if (ret.data.count >0)
        {
            MainPageAdvanceSchemeData * data = [ret.data lastObject];
            weakSelf.adSchemeData = data;
            
            [self.mTableView reloadData];
            
        }
        else
        {
            DDLogDebug(@"数据少于一个!,请知悉");
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.mHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"adScheme_beign";
    
    HFAdvanceSchemeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[HFAdvanceSchemeCell alloc] initWithIndex:3];
    }
    
    cell.begin_TitleLabel.text = self.adSchemeData.name;
    cell.begin_introduceLabel.text = [NSString stringWithFormat:@"适用人群: %@",self.adSchemeData.crowd];
    cell.begin_SubscribeLabel.text = [NSString stringWithFormat:@"%ld人进行中",self.adSchemeData.subscribeNum];
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.adSchemeData.picAddr] placeholderImage:nil];
    cell.bgImageView.layer.cornerRadius = 5.0;
    [cell.begin_SubscribeLabel sizeToFit];
    if (self.adSchemeData.isNew)
    {
        cell.begin_newImageView.hidden = NO;
    }
    else
    {
        cell.begin_newImageView.hidden = YES;
    }
    
    if (self.adSchemeData.isSubscribe)
    {
        cell.begin_addBtn.hidden = NO;
    }
    else
    {
        cell.begin_addBtn.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [MobClick event:AdvanceScheme_Start_Click];
    HFAdvanceSchemeContainerViewController * advCtrl = [[HFAdvanceSchemeContainerViewController alloc] init];
    advCtrl.adSchemeID = self.adSchemeData.id;
    advCtrl.bBeginUse = !self.adSchemeData.isSubscribe;
    [self.navigationController pushViewController:advCtrl animated:YES];
    
}


#pragma mark -
#pragma mark getter

- (UIView *)mHeadView
{
    if (!_mHeadView)
    {
        _mHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _mHeadView.backgroundColor = [UIColor clearColor];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 300, 20)];
        title.text = @"成功添加调理方案，可获取20个嗨豆奖励哦";
        title.font = [UIFont systemFontOfSize:14.0];
        title.textColor = [UIColor HFColorStyle_3];
        [_mHeadView addSubview:title];
    }
    
    return _mHeadView;
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
