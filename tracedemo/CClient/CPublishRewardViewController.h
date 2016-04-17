//
//  CPublishRewardViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/9.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "TK_ImageSelectBoxView.h"
#import "TKClearView.h"
#import "TKTextView.h"
#import "TKIShowGoodsRowM.h"
#import "TK_RewardListForBuyerAck.h"
@interface CPublishRewardViewController : TKIBaseNavWithDefaultBackVC

@property (nonatomic,assign) NSInteger publishType;// 1发布悬赏, 0 发布晒单

@property (weak, nonatomic) IBOutlet UIView *imageContaner;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageFieldHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *dayBtn1;
- (IBAction)dayBtn1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn2;
- (IBAction)dayBtn2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn3;
- (IBAction)dayBtn3:(id)sender;
@property (weak, nonatomic) IBOutlet TKTextView *inputText;

@property (weak, nonatomic) IBOutlet UIView *priceInputView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextField *priceInputText;
@property (weak, nonatomic) IBOutlet UITextField *categoryText;
@property (weak, nonatomic) IBOutlet UIImageView *brandSelect;
@property (weak, nonatomic) IBOutlet UIImageView *categorySelect;
@property (weak, nonatomic) IBOutlet UITextField *brandText;

@property (weak, nonatomic) IBOutlet UIView *brandField;

@property (nonatomic,strong)TK_ImageSelectBoxView * firstPic;
@property (nonatomic,strong)TK_ImageSelectBoxView * secondPic;

- (IBAction)addressFieldTouch:(id)sender;
@property (weak, nonatomic) IBOutlet TKClearView *clearView;
- (IBAction)brandSelectClick:(id)sender;
- (IBAction)categorySelectAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *dayBtnField;
@property (weak, nonatomic) IBOutlet UIView *infoField;
@property (weak, nonatomic) IBOutlet UIView *addressField;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoFieldMarginTop;


@property (weak,nonatomic) TKIShowGoodsRowM * showGoodsrowData;//跟单的数据原始对象
@property (weak,nonatomic) RewardData * rewardData;// 悬赏的原始数据

@end
