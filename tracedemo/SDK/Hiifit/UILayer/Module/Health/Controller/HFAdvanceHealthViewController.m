//
//  HFAdvanceHealthViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/17.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFAdvanceHealthViewController.h"
#import "HFAdvanceSchemeTableViewCell.h"
#import "GetAdvanceSchemeMainPageAck.h"
#import "ChildSchemeViewController.h"
#import "HFDiseaseIntroViewController.h"
#import "HFQuestionTestViewController.h"
#import "HFGiveUpView.h"
#define HeadScale (640.0/326.0)
@interface HFAdvanceHealthViewController ()<UITableViewDataSource,UITableViewDelegate,HFAdvanceSchemeTableViewCellDelegate,HFQuestionTestDelegate,ChildSchemeDeleagte,HFGiveUpViewDelegate>
{
   
}

@property(nonatomic,strong)GetAdvanceSchemeMainPageData * data;
@property(nonatomic,strong)HFGiveUpView * giveUpView;
@end

@implementation HFAdvanceHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.parentViewController addRightBarItemWithImageName:@"person_detail"];
    self.view.backgroundColor = [UIColor redColor];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mHeadBgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/HeadScale);
    self.mTableView.tableHeaderView = self.mHeaderView;

    self.mTableView.tableFooterView = [[UIView alloc] init];
    
    //请求数据
    [self requestAdSchemeInfo];
    
    // Do any additional setup after loading the view from its nib.
}



#pragma mark -
#pragma mark private
- (void)requestAdSchemeInfo
{
    WS(weakSelf)
    [[[HIIProxy shareProxy] schemeProxy] getAdvanceSchemeMainPage:self.schemeID withBlock:^(HF_BaseAck *ack) {
        GetAdvanceSchemeMainPageAck * ret = (GetAdvanceSchemeMainPageAck *)ack;
        
        //刷新界面层UI
        weakSelf.data = (GetAdvanceSchemeMainPageData *)ret.data;
        [weakSelf reloadSchemeUI];
    }];
}

- (void)reloadSchemeUI
{
    //先刷新header 然后刷新tableview
    
    self.mHeadTitle.text = self.data.name;
    self.mHeadInfo.text = self.data.desc1;
    [self.mHeadBgView sd_setImageWithURL:[NSURL URLWithString:self.data.picAddr] placeholderImage:nil];
    [self.mTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 44.0;
    }
    else
    {
        if (!self.bShowTest)
        {
            return 90.0;
        }
        else
        {
            return 120.0;
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.data == nil)
    {
        return 0;
    }

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.data == nil)
    {
        return 0;
    }
    
    if (!self.bShowTest)
    {
        if (section == 0)
        {
            return 1;
        }
        else
        {
            return [self.data.homeSubSchemeList count];
        }
        
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        HFAdvanceSchemeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"advanceCell_detail"];
        
        if (!cell)
        {
            cell = [[HFAdvanceSchemeTableViewCell alloc] initWithIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        if (!self.bShowTest)
        {
            cell.moreButton.hidden = NO;
        }
        else
        {
            cell.moreButton.hidden = YES;
        }
        
        return cell;
    }
    else
    {
        if (self.bShowTest)
        {
            HFAdvanceSchemeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"advanceCell_nostart"];
            
            if (!cell)
            {
                cell = [[HFAdvanceSchemeTableViewCell alloc] initWithIndex:2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            
            return cell;
        }
        else
        {
            
            HFAdvanceSchemeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"advanceCell_kind"];
            if (!cell)
            {
                cell = [[HFAdvanceSchemeTableViewCell alloc] initWithIndex:1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                
                if (indexPath.row < [self.data.homeSubSchemeList count])
                {
                    GetAdvanceSchemeMainPageSubData * data = [self.data.homeSubSchemeList objectAtIndex:indexPath.row];
                    [cell setContentData:data];
                }
    
                
            }
            return cell;
            
        }
    }
    return [[UITableViewCell alloc] init];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && !self.bShowTest)
    {
        GetAdvanceSchemeMainPageSubData * subsSource = [self.data.homeSubSchemeList objectAtIndex:indexPath.row];
        ChildSchemeViewController * scheme = [[ChildSchemeViewController alloc] init];
        NSInteger count = 0;
        for (GetAdvanceSchemeMainPageSubData *subData in self.data.homeSubSchemeList) {
            if (subData.isSubscribe) {
                ++count;
            }
        }
        switch (subsSource.subSchemeId) {
            case 3:
                [MobClick event:AdvanceScheme_SchemeRudiments];
                break;
            case 4:
                [MobClick event:AdvanceScheme_SchemeAdvance];
                break;
            case 5:
                [MobClick event:AdvanceScheme_SchemeStrengthen];
                break;

            default:
                break;
        }
        scheme.subscribeSize = count;
        scheme.subSchemeName = subsSource.subSchemeName;
        scheme.subSchemeId = subsSource.subSchemeId;
        scheme.schemeId = self.schemeID;
        scheme.delegate = self;
        [self.navigationController pushViewController:scheme animated:YES];
    }
}

#pragma mark -
#pragma mark HFAdvanceSchemeTableViewCellDelegate

- (void)jumpToTest
{
    [MobClick event:AdvanceScheme_StartTest];
    HFQuestionTestViewController * testVC = [[HFQuestionTestViewController alloc] initFromMainAdvancePage:YES];
    testVC.schemeId = self.schemeID;
    testVC.delegate = self;
    [self.navigationController presentViewController:testVC animated:YES completion:^{
        
    }];
}

- (void)restartTest
{
    [self jumpToTest];
}

- (void)giveupAdvanceScheme
{
    [self.giveUpView show];
}

#pragma mark -
#pragma mark HFGiveUpViewDelegate
- (void)cancleButtonClick
{
    [self.giveUpView dismiss];
}
- (void)giveUpButtonClick
{
    [self.giveUpView dismiss];
    
    WS(weakSelf)
    [[[HIIProxy shareProxy] schemeProxy] modifyScheme:self.schemeID schemeStatus:HFModifySchemeTypeGiveUp withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess])
        {
            [weakSelf.parentViewController.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - 
#pragma mark HFQuestionTestDelegate
- (void)schemeStart
{
    self.bShowTest = NO;
    [self requestAdSchemeInfo];
}

#pragma mark -
#pragma mark ChildSchemeDeleagte
- (void)giveUpSubScheme:(BOOL)lastSubScheme
{
    self.bShowTest = lastSubScheme;
    [self requestAdSchemeInfo];
}

#pragma mark -
#pragma mark Event
- (IBAction)tapSchemeDetail:(UITapGestureRecognizer *)sender {
    
    HFDiseaseIntroViewController * diseaseViewController = [[HFDiseaseIntroViewController alloc] init];
    diseaseViewController.schemeId = self.schemeID;
    [self.parentViewController.navigationController pushViewController:diseaseViewController animated:YES];
}

- (HFGiveUpView *)giveUpView
{
    if (!_giveUpView) {
        _giveUpView = [[HFGiveUpView alloc] init];
        _giveUpView.delegate = self;
    }
    return _giveUpView;
}

@end
