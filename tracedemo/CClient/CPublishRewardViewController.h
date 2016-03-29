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

@interface CPublishRewardViewController : TKIBaseNavWithDefaultBackVC

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
@property (weak, nonatomic) IBOutlet UITextView *inputText;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UITextField *priceInputText;
@property (weak, nonatomic) IBOutlet UITextField *categoryText;
@property (weak, nonatomic) IBOutlet UIImageView *brandSelect;
@property (weak, nonatomic) IBOutlet UIImageView *categorySelect;
@property (weak, nonatomic) IBOutlet UITextField *brandText;


@property (nonatomic,strong)TK_ImageSelectBoxView * firstPic;
@property (nonatomic,strong)TK_ImageSelectBoxView * secondPic;

- (IBAction)addressFieldTouch:(id)sender;
@property (weak, nonatomic) IBOutlet TKClearView *clearView;
- (IBAction)brandSelectClick:(id)sender;
- (IBAction)categorySelectAction:(id)sender;

@end
