//
//  GoodsDetailViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "SDCycleScrollView.h"
#import "TKRewardCell.h"
@interface GoodsDetailViewController : TKIBaseNavWithDefaultBackVC

@property (nonatomic,strong) RewardData * data;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *grobBtn;
@property (weak, nonatomic) IBOutlet UIButton *freeBtn;
- (IBAction)grobAction:(UIButton *)sender;
- (IBAction)freeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
- (IBAction)followAction:(id)sender;

@end
