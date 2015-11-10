//
//  HFBandViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@protocol HFDismissBandViewDelegate <NSObject>

- (void)dismissBandView:(UIViewController *)vc;

@end

@interface HFBandViewController : BaseViewController

@property (nonatomic, weak) id<HFDismissBandViewDelegate>delegate;

- (IBAction)bandAction:(id)sender;

- (IBAction)dismissAction:(id)sender;

@end
