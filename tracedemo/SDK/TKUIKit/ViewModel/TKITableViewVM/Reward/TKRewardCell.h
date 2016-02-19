//
//  TKRewardCell.h
//  tracedemo
//
//  Created by 罗田佳 on 16/2/19.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKTableViewRowM.h"



@interface TKRewardCellModel : TKTableViewRowM


@property (nonatomic,strong) NSString * userName;
@property (nonatomic,strong) NSString * headAddress;
@property (nonatomic,strong) NSString * contentInfo;
@property (nonatomic,strong) NSString * pic1Address;
@property (nonatomic,strong) NSString * pic2Address;
@property (nonatomic,strong) NSString * goodTips;
@property (nonatomic,strong) NSString * infoIcon1;
@property (nonatomic,strong) NSString * infoIcon2;
@property (nonatomic,assign) CGFloat money;
@property (nonatomic,assign) NSInteger remainingSeconds;




@end

@interface TKRewardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
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

@end
