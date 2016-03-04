//
//  TKRewardDetailViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/2.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKRewardDetailViewController.h"
#import "SDCycleScrollView.h"

@interface TKRewardDetailViewController ()<SDCycleScrollViewDelegate>
{
}


@property (nonatomic,copy) SDCycleScrollView * bannerView;

@end

@implementation TKRewardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    
    NSArray * pics = [NSArray arrayWithObjects:@"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_R.jpg",@"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_R.jpg", nil];
    [self.bannerView setImageURLStringsGroup:pics];
}


-(void)initView
{

    _contentMainView.frame = CGRectMake(0, 0, TKScreenWidth, 800);
    _tkScrollview.contentSize = _contentMainView.frame.size;
    [_tkScrollview addSubview:_contentMainView];
   
//    [_picsFieldView addSubview:self.bannerView];
    [_picsFieldView insertSubview:self.bannerView atIndex:0];
    
}


- (SDCycleScrollView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 1.4)];
        [_bannerView setPlaceholderImage:IMG(@"tk_image_headbg")];
        _bannerView.autoScrollTimeInterval = 3.0f;
        _bannerView.delegate = self;
        [_bannerView setPageControlStyle:SDCycleScrollViewPageContolStyleClassic];
    }
    return _bannerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
}

@end
