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

@interface GoodsDetailViewController ()
@property (nonatomic, strong) BannerView *bannerView;
@property (nonatomic, strong) DetailView *detailView;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *text = @"我佛拍哈卡卡收到回复流口水了空军航空地方搭上了回家看房客户发了快递发货快乐就啊水电费看了好久啊穑地方立刻就收到回复快乐就会撒地方离开家哈桑地方还撒了看法是拉空间发的哈克里斯蒂肌肤拉开绝代风华阿斯利康绝代风华收到了空间发很多事分开就拉屎的方式打开链接发贺卡收到放到沙发和电视看房活动萨卡积分的看法好哒是靠近阿富汗的失联客机繁华的司芬克斯地方还可减肥哈是对抗肌肤哈桑分";
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat height = [UIKitTool caculateHeight:text sizeOfWidth:(kScreenWidth-68) withAttributes:dic];
    
    self.detailView.frame = CGRectMake(0, kScreenWidth, kScreenWidth, 91+height);
    self.detailView.countDownView.secondsUTC = 1457312501+BSDay*13;
    self.detailView.textView.text = text;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.bannerView.frame.size.height+self.detailView.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self TKI_setBarDefaultTitle:@"详情"];
    [self TKI_setBarDefaultLeftBack];
}

- (BannerView *)bannerView
{
    if (_bannerView == nil) {
        NSArray *images = @[IMG(@"tk_image_appicon"),IMG(@"tk_image_headbg"),IMG(@"tk_image_head")];
        _bannerView = [BannerView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) imagesGroup:images];
        _bannerView.localizationImagesGroup = images;
        [_bannerView setTitle:@"悬赏价：¥3800"];
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
}

- (IBAction)freeAction:(UIButton *)sender {
    //释放动作
}
@end
