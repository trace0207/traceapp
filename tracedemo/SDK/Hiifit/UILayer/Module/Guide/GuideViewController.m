//
//  GuideViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "GuideViewController.h"
#import "GlobConfig.h"
#import "Masonry.h"
#import "UIKitTool.h"
#define pageNum 4

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    UIScrollView *_scrollView;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    _scrollView = [[UIScrollView alloc]initWithFrame:kScreenBounds];
    _scrollView.contentSize = CGSizeMake(kScreenWidth*pageNum, kScreenHeight);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-200.0)/2.0, kScreenHeight-50, 200, 30)];
    [pageControl setNumberOfPages:pageNum];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:59/255.0f green:201/255.0f blue:217/255.0f alpha:1.0];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:145.0/255.0f green:150/255.0f blue:150/255.0f alpha:1.0];
    [self.view addSubview:pageControl];
    
    for (NSUInteger i = 0; i < pageNum; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        NSString *imageName = nil;
        if (IS_SCREEN_35_INCH) {
            imageName = [NSString stringWithFormat:@"iphone4_guide_%lu",(unsigned long)(i+1)];
        }else {
            imageName = [NSString stringWithFormat:@"guide_%lu",(unsigned long)(i+1)];
        }
        
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        
//        if (i == pageNum-1) {
//            UIButton *goBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-190.0)/2.0, kScreenHeight-200, 190, 60)];
//            [goBtn setBackgroundImage:[UIImage imageNamed:@"go_ahead_yellow"] forState:UIControlStateNormal];
//            [goBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
//            [imageView addSubview:goBtn];
//        }else {
//            UIButton *goBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-91.0)/2.0, kScreenHeight-100, 91, 29)];
//            [goBtn setBackgroundImage:[UIImage imageNamed:@"go_ahead"] forState:UIControlStateNormal];
//            [goBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
//            [imageView addSubview:goBtn];
//        }

        if (i == pageNum - 1)
        {
            UIButton *goBtn = [[UIButton alloc]init];
            [goBtn setBackgroundImage:IMG(@"anniu_guide") forState:UIControlStateNormal];
            goBtn.backgroundColor = [UIColor clearColor];
            [goBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:goBtn];
            [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(pageControl.mas_bottom).with.offset(-30);
                make.size.mas_equalTo(CGSizeMake(124, 43));
                make.centerX.mas_equalTo(imageView.mas_centerX);
            }];
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAction:(id)sender {
    [[[HIIProxy shareProxy] userProxy] autoLoginWithComplete:^(BOOL finish) {
        if (finish)
        {
            [[UIKitTool getAppdelegate] goMainViewController];
        }
        else
        {
            [[UIKitTool getAppdelegate] goLoginViewController];
        }
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    pageControl.currentPage = index;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    pageControl.currentPage = index;
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //更新UIPageControl的当前页
//    CGPoint offset = scrollView.contentOffset;
//    CGRect bounds = scrollView.frame;
//    [pageControl setCurrentPage:offset.x / bounds.size.width];
//}
//
////然后是点击UIPageControl时的响应函数pageTurn
//- (void)pageTurn:(UIPageControl*)sender
//{
//    //令UIScrollView做出相应的滑动显示
//    CGSize viewSize = _scrollView.frame.size;
//    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
//    [_scrollView scrollRectToVisible:rect animated:YES];
//}

@end
