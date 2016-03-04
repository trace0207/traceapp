//
//  CHomePageViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/2.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "HFSegmentView.h"



@interface CHomePageViewController : TKIBaseNavWithDefaultBackVC

@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,strong)HFSegmentView * mSegView;

@end
