//
//  TKShowGoodsCell.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKHeadImageView.h"

@interface TKShowGoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *imageContentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageFiledHeight;
@property (strong, nonatomic) IBOutlet TKHeadImageView *userHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *contentText;
@property (strong, nonatomic) IBOutlet UILabel *headSecondLabel;
@property (strong, nonatomic) IBOutlet UILabel *headFirstLabel;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
@property (strong, nonatomic) IBOutlet UIButton *rewardBtn;
@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;


@end
