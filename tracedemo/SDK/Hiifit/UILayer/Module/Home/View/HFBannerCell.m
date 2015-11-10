//
//  HFBannerCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFBannerCell.h"
#import "SDCycleScrollView.h"

@interface HFBannerCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

@implementation HFBannerCell
@synthesize bannerView;
@synthesize delegate = _delegate;

- (void)setBannerToCell:(NSArray *)imageUrls
{
    if (imageUrls.count==0) {
        return;
    }
    if (bannerView) {
        [bannerView removeFromSuperview];
        bannerView = nil;
    }
    NSMutableArray *images = nil;
    if (imageUrls.count>6) {
        images = [[NSMutableArray alloc]initWithArray:[imageUrls subarrayWithRange:NSMakeRange(0, 6)]];
    }else {
        images = [[NSMutableArray alloc]initWithArray:imageUrls];
    }
    bannerView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame imageURLStringsGroup:images];
    bannerView.autoScrollTimeInterval = 3.0f;
    [bannerView setPlaceholderImage:IMG(@"main_banner")];
    if (images.count<=1) {
        [bannerView setPageControlStyle:SDCycleScrollViewPageContolStyleNone];
    }else{
        [bannerView setPageControlStyle:SDCycleScrollViewPageContolStyleClassic];
    }
    
    bannerView.delegate = self;
    [self addSubview:bannerView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    bannerView.frame = self.frame;
}

#pragma mark - scrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [_delegate didSelectItemAtIndex:index];
    }
}

@end
