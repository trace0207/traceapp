//
//  GoodsDetailViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TK_BaseNavSettingViewController.h"
#import "SDCycleScrollView.h"
@interface GoodsDetailViewController : TK_BaseNavSettingViewController
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *grobBtn;
@property (weak, nonatomic) IBOutlet UIButton *freeBtn;
- (IBAction)grobAction:(UIButton *)sender;
- (IBAction)freeAction:(UIButton *)sender;

@end
