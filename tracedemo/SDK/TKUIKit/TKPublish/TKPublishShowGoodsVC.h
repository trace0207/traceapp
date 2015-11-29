//
//  TKPublishShowGoodsVC.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/26.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKBaseViewController.h"
#import "TKIBaseNavWithDefaultBackVC.h"
#import "ZBMessageTextView.h"
#import "TKClearView.h"

@interface TKPublishShowGoodsVC : TKIBaseNavWithDefaultBackVC
@property (strong, nonatomic) UIScrollView *rootScrollView;
@property (strong, nonatomic) IBOutlet ZBMessageTextView *inputTextView;
@property (strong, nonatomic) IBOutlet UIView *picContainer;
//@property (strong, nonatomic) IBOutlet UILabel *pinleiShowLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *pinleiArrow;
//@property (strong, nonatomic) IBOutlet UILabel *locationShowLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *locationArrow;
@property (strong, nonatomic) IBOutlet UIView *mainContentView;
@property (strong, nonatomic) IBOutlet UIView *testView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *picHeight;
@property (strong, nonatomic) IBOutlet TKClearView *tabViewForCloseKeybord;
@property (strong, nonatomic) IBOutlet UILabel *textCountView;
@property (strong, nonatomic) IBOutlet UILabel *typeTextView;
- (IBAction)typeBtnEvent:(UIButton *)sender;

@property (nonatomic, strong)          NSMutableArray  *picturesArr;
@end
