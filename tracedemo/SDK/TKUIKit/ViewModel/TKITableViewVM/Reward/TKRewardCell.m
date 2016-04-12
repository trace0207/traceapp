//
//  TKRewardCell.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/19.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKRewardCell.h"


@implementation TKRewardCellModel



+(TKRewardCellModel *)transformFromRewardData:(RewardData *)reward
{
    TKRewardCellModel * m = [[TKRewardCellModel alloc] init];
    if(reward)
    {
        
//        m.pic1Address = reward.picAddr1;
//        m.pic2Address = reward.picAddr2;
//        m.contentInfo = reward.content;
        m.ackData = reward;
    }
    return m;
}




-(NSInteger)getRemainSeconds
{
    NSInteger  seconds = (self.ackData.releaseTime.integerValue - self.ackData.finalTime.integerValue)/1000;
    if (seconds <=0) {
        seconds = 0;
    }
    return seconds;
}


@end



@implementation TKRewardCell



- (void)awakeFromNib {
    // Initialization code
    
#if B_Client == 0
    self.btnLeft.hidden = YES;
    self.btnRight.hidden = YES;
#endif
    

    UIGestureRecognizer * tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(onHeadImageClick:)];
    [self.headImageView addGestureRecognizer:tap];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)acceptAction:(id)sender {
    if(self.delegate)
    {
        [self.delegate onAcceptBtnClick:self.indexPath];
    }
}

- (IBAction)discardAction:(id)sender {
    if(self.delegate)
    {
        [self.delegate onReleaseBtnClick:self.indexPath];
    }
}
-(void)onHeadImageClick:(UIGestureRecognizer *)tap
{
    if(self.delegate)
    {
        [self.delegate onHeadImageClick:self.indexPath];
    }
}

@end
