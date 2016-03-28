//
//  GoodsDetailViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "BannerView.h"
#import "DetailView.h"
#import "TKUITools.h"
#import "UIColor+TK_Color.h"
#import "TKUserCenter.h"
#import "TKAlertView.h"

@interface GoodsDetailViewController ()
@property (nonatomic, strong) BannerView *bannerView;
@property (nonatomic, strong) DetailView *detailView;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"详情";
//    NSString *text = self.data.content;
    NSString * text = self.data.content;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat height = [UIKitTool caculateHeight:text sizeOfWidth:(kScreenWidth-68) withAttributes:dic];
    
    self.detailView.frame = CGRectMake(0, kScreenWidth, kScreenWidth, 91+height);
//    self.detailView.countDownView.secondsUTC = 1457312501+BSDay*13;
    self.detailView.textView.text = text;
    
    TKSetHeadImageView(self.detailView.headImageView, self.data.userHeaderUrl);
    self.detailView.nameLabel.text = self.data.userNickName;
    self.detailView.brandLabel.text = self.data.brandName;
    self.detailView.kindLabel.text = self.data.categoryName;
    [self.detailView.countDownView beginCutDownFromSeconds:self.data.clock.integerValue/1000];
    
    TKBorder(self.grobBtn);
    TKBorder(self.freeBtn);
    [self.grobBtn setBackgroundImage:IMG(@"bg_purchase") forState:UIControlStateNormal];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.bannerView.frame.size.height+self.detailView.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self TKI_setBarDefaultTitle:@"详情"];
//    [self TKI_setBarDefaultLeftBack];
}

- (BannerView *)bannerView
{
    if (_bannerView == nil) {
        
        
        
//        NSArray *images = @[IMG(@"tk_image_appicon"),IMG(@"tk_image_headbg"),IMG(@"tk_image_head")];
        NSArray * images = [self.data getPicsArrays];
        _bannerView = [BannerView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) imageURLStringsGroup:images];
        _bannerView.imageURLStringsGroup = images;
        
        //[NSString stringWithFormat:@"%0.2f",rowData.rewardPrice.floatValue/100]
        NSString * price = [NSString stringWithFormat:@"悬赏价:¥%0.2f",self.data.rewardPrice.floatValue/100];
        [_bannerView setTitle:price];
        [self.scrollView addSubview:_bannerView];
    }
    return _bannerView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-55-64)];
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (DetailView *)detailView
{
    if (_detailView == nil) {
        _detailView = [[DetailView alloc]init];
        [self.scrollView addSubview:_detailView];
    }
    return _detailView;
}

- (IBAction)grobAction:(UIButton *)sender {
    //抢单动作
    [TKAlertView showDeliveryTime:[self.data.requireDay intValue] WithBlock:^(NSInteger buttonIndex, int deliveryTime) {
        if (buttonIndex == 1) {
            [[TKProxy proxy].mainProxy accept:[[TKUserCenter instance] getUser].userId rewardId:self.data.id needDays:deliveryTime withBlock:^(HF_BaseAck * ack)
             {
                 if(ack.sucess)
                 {
        
                 }
                 DDLogInfo(@"ack %@",ack);
             }];
        }
    }];

}

- (IBAction)freeAction:(UIButton *)sender {
    //释放动作
    [TKAlertView showAltertWithTitle:@"确定不接该笔悬赏？" withMessage:@"释放后，您可以在悬赏状态切换位置找到“已释放的悬赏”。" commpleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[TKProxy proxy].mainProxy releaseReward:self.data.id source:0 withBlock:^(HF_BaseAck *ack) {
                DDLogInfo(@"ack %@",ack);
            }];
        }
    } cancelTitle:@"取消" determineTitle:@"不接"];
    
}


//
//-(void)onAcceptBtnClick:(NSIndexPath *)indexPath
//{
//    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
//    RewardData * rowData  = cellData.ackData;
//    [[TKProxy proxy].mainProxy accept:[[TKUserCenter instance] getUser].userId rewardId:rowData.id needDays:3 withBlock:^(HF_BaseAck * ack)
//     {
//         DDLogInfo(@"ack %@",ack);
//     }];
//}
//
//-(void)onReleaseBtnClick:(NSIndexPath *)indexPath
//{
//    TKRewardCellModel * cellData = (TKRewardCellModel *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
//    RewardData * rowData  = cellData.ackData;
//    [[TKProxy proxy].mainProxy releaseReward:rowData.id source:0 withBlock:^(HF_BaseAck *ack) {
//        DDLogInfo(@"ack %@",ack);
//    }];
//}


@end
