//
//  ChildSchemeViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "ChildSchemeViewController.h"
#import "HFVideoViewController.h"
#import "UIImage+Scale.h"
#import "ChildSchemeCell.h"
#import "SubSchemeHomeAck.h"
#import "SchemeActionsAck.h"
#import "SchemePunchAck.h"
#import "HFActionSheet.h"
#import "HFGiveUpView.h"
#import "WebViewController.h"
#import "HFPostBarController.h"
#import "HFQuestionTestViewController.h"
#import "HFCommentViewController.h"
#import "SentPostViewController.h"
#import "UserCenterViewController.h"
#import "HFCupView.h"
#import "HFThirdPartyCenter.h"
#import "GlobNotifyDefine.h"

#define TOP_IMAGE_SCALE (640.0f/326.0f)
@interface ChildSchemeViewController ()<UITableViewDataSource,UITableViewDelegate,HFActionSheetDelegate,HFGiveUpViewDelegate,
HFCommentViewControllerDelegate,
HFCupViewDelegate>
{
    FinishSchemeData *finishedData;
}

@property (nonatomic, strong) UIButton *finishedBtn;
@property (nonatomic, strong) UIView *btnBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) HFGiveUpView *giveUpView;

@property (nonatomic, strong) SubSchemeHomeData *homeData;
@property (nonatomic, strong) NSMutableArray *actionsArr;
@property (nonatomic, strong) NSMutableArray *usersArr;
@property (nonatomic, assign) NSInteger completeCount;//打卡人数
//@property (nonatomic, strong) UIImageView *navBackImage;
@end

@implementation ChildSchemeViewController

//- (instancetype)init
//{
//    self = [super init];
//    if (self)
//    {
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.modalPresentationCapturesStatusBarAppearance= NO;
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [kNotificationCenter addObserver:self selector:@selector(publishSuccessPost:) name:PublishSuccessNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:PublishSuccessNotification object:nil];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNavigationTitle:self.subSchemeName];
    [self addRightBarItemWithImageName:@"more"];
    [self addRightBarItemWithImageName:@"share_friend"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self getSchemeTopData];
    [self getSchemeActions];
    [self getSchemePunchCard];
}

-(void)rightBarItemAction:(id)sender
{
    UIView *view = (UIView *)sender;
    if (view.tag == 1) {
        HFActionSheet *sheet = [[HFActionSheet alloc]init];
        sheet.delegate = self;
        [sheet showInSuperView:[UIKitTool getAppdelegate].window cancelButton:@"取消" otherButton:@"调理日历",@"测试结果",@"退出此调理方案", nil];
    }else if (view.tag == 2) {
        [[HFThirdPartyCenter shareInstance] shareSDKShare:self HiifitType:HIModuleTypeScheme dataDic:nil];
    }
}

#pragma mark - Request Data

//主页信息
- (void)getSchemeTopData
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]schemeTopWithId:self.schemeId subSchemeId:self.subSchemeId withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            SubSchemeHomeAck *home = (SubSchemeHomeAck *)ack;
            weakSelf.homeData = home.data;
            if (home.data.isSubscribe) {
                weakSelf.btnBgView.hidden = NO;
                weakSelf.titleLabel.textAlignment =home.data.isOver == 1?NSTextAlignmentCenter:NSTextAlignmentLeft;
                weakSelf.titleLabel.text = home.data.isOver == 1? @"太棒了 完成了":@"每天打卡领福利，嗨豆送不停";
                weakSelf.finishedBtn.hidden = home.data.isOver == 1? YES:NO;
                //weakSelf.finishedBtn.userInteractionEnabled = home.data.isOver? NO:YES;
            }else{
                weakSelf.btnBgView.hidden = YES;
            }
            NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:0];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[path1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

//动作数组
- (void)getSchemeActions
{
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]schemeActions:self.schemeId subSchemeId:self.subSchemeId withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            [weakSelf.actionsArr removeAllObjects];
            SchemeActionsAck *actions = (SchemeActionsAck *)ack;
            [weakSelf.actionsArr addObjectsFromArray:actions.data];
            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

//打卡人们
- (void)getSchemePunchCard
{
    
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]schemePunchCards:self.subSchemeId withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            [weakSelf.usersArr removeAllObjects];
            SchemePunchAck *punchs = (SchemePunchAck *)ack;
            [weakSelf.usersArr addObjectsFromArray:punchs.data.list];
            _completeCount = punchs.data.complateCount;
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
            [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (NSMutableArray *)actionsArr
{
    if (!_actionsArr) {
        _actionsArr = [[NSMutableArray alloc]init];
    }
    return _actionsArr;
}

- (NSMutableArray *)usersArr
{
    if (!_usersArr) {
        _usersArr = [[NSMutableArray alloc]init];
    }
    return _usersArr;
}

- (HFGiveUpView *)giveUpView
{
    if (!_giveUpView) {
        _giveUpView = [[HFGiveUpView alloc] init];
        _giveUpView.delegate = self;
    }
    return _giveUpView;
}

//点击完成按钮
- (void)finishedAction:(UIButton *)btn
{
    [MobClick event:AdvanceScheme_PartFinished];
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]finishSubScheme:self.subSchemeId withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            weakSelf.finishedBtn.hidden = YES;
            weakSelf.titleLabel.textAlignment =NSTextAlignmentCenter;
            weakSelf.titleLabel.text = @"太棒了 完成了";
            FinishSchemeAck *scheme = (FinishSchemeAck*)ack;
            weakSelf.tiebaId = scheme.data.tiebaId;
            [weakSelf showCupView:scheme.data];
            finishedData = scheme.data;
            [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                
            }];
        }
    }];
}

- (void)showCupView:(FinishSchemeData *)scheme
{
    HFCupView *cupView = [[HFCupView alloc]initWithSchemeInfo:scheme];
    cupView.delegate = self;
    [cupView show];
}

-(UIView *)btnBgView
{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:1.f];
        [self.view addSubview:_btnBgView];
        WS(weakSelf)
        [_btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left);
            make.bottom.equalTo(weakSelf.view.mas_bottom);
            make.right.equalTo(weakSelf.view.mas_right);
            make.height.mas_equalTo(@60);
        }];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor HFColorStyle_2];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"每天打卡领福利，嗨豆送不停";
        [_btnBgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 20));
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.3f];
        [_btnBgView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_btnBgView.mas_left);
            make.top.equalTo(_btnBgView.mas_top);
            make.right.equalTo(_btnBgView.mas_right);
            make.height.mas_equalTo(@0.5f);
        }];
    }
    return _btnBgView;
}

- (UIButton *)finishedBtn
{
    if (!_finishedBtn) {
        _finishedBtn = [[UIButton alloc]init];
        [_finishedBtn setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
//        [_finishedBtn setBackgroundImage:[UIImage scaleWithImage:@"btn_bg_unable"] forState:UIControlStateSelected];
        [_finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
        //[_finishedBtn setTitle:@"太棒了，已完成" forState:UIControlStateSelected];
        [_finishedBtn addTarget:self action:@selector(finishedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBgView addSubview:_finishedBtn];
        WS(weakSelf)
        [_finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.btnBgView.mas_right).with.offset(-16);
            make.centerY.equalTo(weakSelf.btnBgView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
    }
    return _finishedBtn;
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (self.usersArr.count == 0) {
        return 1;
    }else if (self.usersArr.count <= 5){
        return self.usersArr.count + 1;
    }else {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Identifier = nil;
    NSInteger index = 0;
    if (indexPath.section == 0) {
        index = indexPath.row;
    }else {
        if (self.usersArr.count == 0) {
            index = 4;
        }else {
            if (indexPath.row == 0) {
                index = 2;
            }else {
                index = 3;
            }
        }
    }
    
    Identifier = [NSString stringWithFormat:@"CellAtIndex_%@",[[NSNumber numberWithInteger:index]stringValue]];
    ChildSchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChildSchemeCell" owner:self options:nil]objectAtIndex:index];
        
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [cell addActions:self.actionsArr withSelector:@selector(selectActionItem:) andTarget:self];
        }else {
            [cell addTopData:self.homeData];
            if (self.homeData.isSubscribe == 0) {
                [cell addSchemeSelector:@selector(addSubSchemeAction) withTarget:self andObject:nil];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (self.usersArr.count > 0) {
            if (indexPath.row == 0) {
                [cell setPunchCards:self.usersArr completeCount:_completeCount];
            }else{
                SchemePunchList *user = [self.usersArr objectAtIndex:indexPath.row - 1];
                [cell setPunchMen:user];
                [cell userCenterSelector:@selector(goUserCenter:) withTarget:self];
            }
        }
    }
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kScreenWidth/TOP_IMAGE_SCALE + 130;
        }else if (indexPath.row == 1){
            return 130;
        }
    }else {
        if (self.usersArr.count == 0) {
            return 90;
        }else {
            if (indexPath.row == 0) {
                return 60;
            }else {
                return 44;
            }
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 60;
    }
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && self.usersArr.count > 0) {
        if (indexPath.row == 0) {
            HFPostBarController * post = [[HFPostBarController alloc] init];
            post.schemeId = self.schemeId;
            [self.navigationController pushViewController:post animated:YES];
        }else {
            SchemePunchList *punchMan = [self.usersArr objectAtIndex:indexPath.row-1];
            HFCommentViewController * commentController = [[HFCommentViewController alloc] init];
            commentController.mWbType = punchMan.type;
            commentController.delegate = self;
            commentController.mWbID = punchMan.tiebaId;
            commentController.bIsPostBar = YES;
            [self.navigationController pushViewController:commentController animated:YES];
        }
        
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGBA(238, 238, 238, 1);
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    return nil;
}

#pragma mark - action sheet delegate

- (void)didSelectItemAtIndex:(NSInteger)index
{
    if (index == 0) {
        //调理日历
        [MobClick event:AdvanceScheme_MyCalendar];
        WebViewController * calViewController = [[WebViewController alloc] init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:KURLCalendar((long)self.subSchemeId) forKey:kParamURL];
        calViewController.param = dic;
        [self.navigationController pushViewController:calViewController animated:YES];
        
    }else if (index == 1){
        //测试结果
        [MobClick event:AdvanceScheme_MyTestResult];
        HFQuestionTestViewController * questionVC = [[HFQuestionTestViewController alloc] initFromMainAdvancePage:NO];
        questionVC.schemeId = self.schemeId;
        [self.navigationController presentViewController:questionVC animated:YES completion:^{
            
        }];
    }else if (index == 2) {
        //退出调理方案
        [MobClick event:AdvanceScheme_ExitScheme];
        if (self.subscribeSize == 1) {
            self.giveUpView.encourageLabel.text = @"此为最后一个调理方案，退出后，即视为彻底放弃整个调理计划";
        }else {
            self.giveUpView.encourageLabel.text = @"退出后，此调理方案的相关数据将丢失！";
        }
        
        [self.giveUpView show];
    }
}

#pragma mark -
#pragma mark HFGiveUpViewDelegate
- (void)cancleButtonClick
{
    [self.giveUpView dismiss];
}
- (void)giveUpButtonClick
{
    [MobClick event:AdvanceScheme_ExitPart];
    WS(weakSelf)
    
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:self.subSchemeId schemeStatus:HFModifySchemeTypeGiveUp withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            //弹窗页面消失
            
            //[weakSelf leftBarItemAction:nil];
            BOOL showBack = (weakSelf.subscribeSize == 1 ? YES:NO);
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(giveUpSubScheme:)]) {
                [weakSelf.delegate giveUpSubScheme:showBack];
            }
            if (showBack) {
                [weakSelf leftBarItemAction:nil];
            }else {
                [weakSelf getSchemeTopData];
            }
        }
        [weakSelf.giveUpView dismiss];
    }];
}

#pragma mark - 点击添加子方案动作

- (void)addSubSchemeAction
{
    [MobClick event:AdvanceScheme_PartAddAgain];
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]modifyScheme:self.subSchemeId schemeStatus:HFModifySchemeTypeStart withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess]) {
            [weakSelf getSchemeTopData];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(giveUpSubScheme:)]) {
                [weakSelf.delegate giveUpSubScheme:NO];
            }
        }
    }];
}

#pragma mark - 进入个人中心

- (void)goUserCenter:(UIButton *)btn
{
    UserCenterViewController *vc = [[UserCenterViewController alloc]init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:btn.tag] forKey:kParamUserId];
    vc.param = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击动作item

- (void)selectActionItem:(UIButton *)btn
{
    HFVideoViewController *vc = [[HFVideoViewController alloc]init];
    vc.sportDataArray = self.actionsArr;
    vc.startIndex = btn.tag;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  - 完成按钮 cup

- (void)cancle:(HFCupView *)cupView
{
    
    [cupView dismiss];
    //刷新打卡数据
    [self getSchemePunchCard];
    
}

- (void)thoughtsButtonClick:(HFCupView *)cupView
{
    [MobClick event:AdvanceScheme_FinishPostIdea];
    [cupView dismiss];
    SentPostViewController * postVC = [[SentPostViewController alloc] init];
    postVC.sendPostType = HFSendDiscussion;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:FromUpdatePost forKey:kParamFrom];
    [dic setObject:[NSNumber numberWithInteger:_schemeId] forKey:kparamSchemeId];
    [dic setObject:[NSNumber numberWithInteger:self.tiebaId] forKey:kParamTiebaId];
    postVC.param = dic;
    [self.navigationController pushViewController:postVC animated:YES];
}

#pragma mark - 更新打卡人次

- (void)publishSuccessPost:(NSNotification *)noti
{
    if (noti.object == nil) {
        if (finishedData && finishedData.status) {
            NSString *text = [NSString stringWithFormat:@"发表感想成功\n获得%@个嗨豆",@(finishedData.score)];
            [[HFHUDView shareInstance] ShowTips:text delayTime:1.0 atView:nil];
        }
        
    }
    [self getSchemePunchCard];
}

@end
