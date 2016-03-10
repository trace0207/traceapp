//
//  CPublishRewardViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/9.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface CPublishRewardViewController : TKIBaseNavWithDefaultBackVC

@property (weak, nonatomic) IBOutlet UIView *imageContaner;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageFieldHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UIView *mainView;


@end
