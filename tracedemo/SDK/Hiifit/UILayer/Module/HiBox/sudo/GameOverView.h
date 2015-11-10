//
//  GameOverView.h
//  GuanHealth
//
//  Created by hermit on 15/5/12.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseView.h"
#import "UploadGameRes.h"

@interface GameOverView : BaseView

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIImageView *firstHeadImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondHeadImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *firstTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

- (void)setContent:(UploadGameRes*)res;


@end
