//
//  BHomePageViewController.h
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "HFSegmentView.h"

@interface BHomePageViewController : TKIBaseNavWithDefaultBackVC
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,strong)HFSegmentView * mSegView;
@end
