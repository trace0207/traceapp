//
//  TKRewardCell.h
//  tracedemo
//
//  Created by 罗田佳 on 16/2/19.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKTableViewRowM.h"
#import "TK_RewardListForBuyerAck.h"
#import "CountDownView.h"
#import "TKHeadImageView.h"




@interface TKRewardCellModel : TKTableViewRowM

@property (nonatomic,strong) RewardData * ackData;

@property (nonatomic,assign) NSInteger remainingSeconds;

-(NSInteger)getRemainSeconds;
+(TKRewardCellModel *)transformFromRewardData:(RewardData *)reward;

@end


@protocol TKRewardCellDelegate <NSObject>

@optional

-(void)onAcceptBtnClick:(NSIndexPath *)indexPath;
-(void)onReleaseBtnClick:(NSIndexPath *)indexPath;
-(void)onHeadImageClick:(NSIndexPath *)indexPath;

@end


@interface TKRewardCell : UITableViewCell

@property (strong,nonatomic) NSIndexPath *indexPath;
@property (weak,nonatomic) id<TKRewardCellDelegate>  delegate;

@property (weak, nonatomic) IBOutlet CountDownView *timeCountView;

@property (strong, nonatomic) IBOutlet TKHeadImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *contentInfo;
@property (strong, nonatomic) IBOutlet UIImageView *statusIcon;
@property (strong, nonatomic) IBOutlet UIView *timeView;
@property (strong, nonatomic) IBOutlet UIButton *infoIconBtn1;
@property (strong, nonatomic) IBOutlet UIButton *infoIconBtn2;
@property (strong, nonatomic) IBOutlet UIImageView *pic1;
@property (strong, nonatomic) IBOutlet UILabel *moneyTip;
@property (strong, nonatomic) IBOutlet UIImageView *pic2;
@property (strong, nonatomic) IBOutlet UILabel *brandTip;
@property (strong, nonatomic) IBOutlet UIButton *btnLeft;
@property (strong, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UILabel *priceText;
- (IBAction)acceptAction:(id)sender;
- (IBAction)discardAction:(id)sender;


@end
