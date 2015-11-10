//
//  HFRefreshHeader.h
//  HFRefreshDemo
//
//  Created by zhuxiaoxia on 15/8/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HFDefaultRefreshViewWidth 48
#define HFDefaultTopDistance 80

typedef NS_ENUM(NSInteger, HFRefreshState) {
    HFRefreshStateNormal    = 0,
    HFRefreshStatePulling   = 1,
    HFRefreshStateLoading   = 2,
    HFRefreshStateStopped   = 3,
};

@interface HFRefreshView : UIView

@property (nonatomic, assign) HFRefreshState refreshState;

- (void)modifyRefreshState:(HFRefreshState)refreshState withOffSetY:(CGFloat)offSetY;

- (void)modifyRefreshState:(HFRefreshState)refreshState;

@end
