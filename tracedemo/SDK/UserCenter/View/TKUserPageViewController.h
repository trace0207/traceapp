//
//  TKUserPageViewController.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/9.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKUserPageViewController : TKIBaseNavWithDefaultBackVC
@property (strong, nonatomic) IBOutlet UIView *tableHeadView;
@property (strong, nonatomic) IBOutlet BasePortraitView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameView;
@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;
@property (strong, nonatomic) IBOutlet UILabel *fansCountView;
@property (strong, nonatomic) IBOutlet UILabel *faithValueView;
@property (strong, nonatomic) IBOutlet UILabel *signatureView;

@property (nonatomic, strong) NSString *userId;

@end
