//
//  GoodsDetailViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "SDCycleScrollView.h"
@interface GoodsDetailViewController : TKIBaseNavWithDefaultBackVC
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *grobBtn;
@property (weak, nonatomic) IBOutlet UIButton *freeBtn;
- (IBAction)grobAction:(UIButton *)sender;
- (IBAction)freeAction:(UIButton *)sender;

@end
