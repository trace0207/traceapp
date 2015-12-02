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
@class  TK_ShareCategory;


@interface TKPublishData : NSObject

@property (nonatomic,strong)NSString  * tips; // 备注
@property (nonatomic,strong)TK_ShareCategory * cateGory;
@property (nonatomic,copy)NSMutableArray * picArray;
@property (nonatomic,assign)NSInteger count; // 数量
@property (nonatomic,assign)CGFloat tagPrice; // 吊牌价
@property (nonatomic,assign)CGFloat willByPrice;//  悬赏价
@property (nonatomic,strong)NSString  * goodsColor; // 颜色
@property (nonatomic,strong)NSString * goodsSize;// 尺寸
@property (nonatomic,strong)NSString * publishAddress;// 地址

@end



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
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *picLoadingView;

@property (nonatomic, strong)          NSMutableArray  *picturesArr;

- (IBAction)countAddAction:(id)sender;
- (IBAction)countMinusAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *countTextView;
@property (strong, nonatomic) IBOutlet UITextField *tagPriceTextView;
@property (strong, nonatomic) IBOutlet UITextField *willByPrice;
@property (strong, nonatomic) IBOutlet UITextField *goodColorView;
@property (strong, nonatomic) IBOutlet UITextField *goodSizeView;

-(BOOL)showKeyBoard;

@end
