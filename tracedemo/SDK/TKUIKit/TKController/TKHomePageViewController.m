//
//  TKHomePageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/10/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "HFSegmentView.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "SDCycleScrollView.h"
#import "HFTitleView.h"
#import "HFPostDetailView.h"
#import "UIColor+TK_Color.h"
#import "TKColorDefine.h"

@interface TKHomePageViewController ()<HFTitleViewDelegate,BasePostDetailViewDelegate,SDCycleScrollViewDelegate>{

    NSInteger mCurrentIndex;
    NSMutableArray *mSourceArray;
    NSMutableArray *mViewArray;
    NSMutableArray *mOffsetArray;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HFTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.backgroundColor = [UIColor HFColorStyle_6];
    [_scrollView setContentSize:CGSizeMake(TKScreenWidth*2, CGRectGetHeight(_scrollView.frame))];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    for (NSInteger i = 0; i < 2; i++) {
        HFPostDetailView *_tableView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight-64-49)
                                                           withTableViewStyle:UITableViewStylePlain];
        _tableView.bSupportPullUpLoad = YES;
        _tableView.delegate = self;
        [_scrollView addSubview:_tableView];
        [mViewArray addObject:_tableView];
    }
    
    


}


-(void)leftDrawerButtonPress{

    if(_eventDelegate){
        [_eventDelegate leftBarIconDidClick];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self TKremoveLeftBarButtonItem];
    [self TKremoveRightBarButtonItem];
    [self TKremoveNavigationTitle];
    [self TKaddNavigationTitleView:[self titleView]];
    [self TKsetLeftBarItemImage:[UIImage imageNamed:@"tk_icon_menu"]
                      addTarget:self action:@selector(leftDrawerButtonPress)
               forControlEvents:UIControlEventTouchUpInside];
}

- (HFTitleView *)titleView
{
    if (!_titleView) {
        NSArray *titles = [NSArray arrayWithObjects:@"晒 单",@"悬 赏",nil];
        _titleView = [[HFTitleView alloc]initWithTitles:titles
                                         withScrollView:self.scrollView
                                           defaultColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                                            activeColor:[UIColor TKcolorWithHexString:TK_Color_nav_textActive]];
//        _titleView.activeColor = [UIColor TKcolorWithHexString:TK_Color_nav_textActive];
//        _titleView.defaultColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _titleView.delegate = self;
    }
    return _titleView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----------- delegate
- (void)titleViewDidSelectedAtIndex:(NSInteger)index clickMenuTap:(BOOL)clicked{

    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}

@end
