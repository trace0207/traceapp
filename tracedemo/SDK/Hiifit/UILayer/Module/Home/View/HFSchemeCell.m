//
//  HFSchemeCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSchemeCell.h"
#import "UIImage+Scale.h"

typedef NS_ENUM(NSUInteger, HFSchemeStage) {
    HFSchemeStageFirst = 1,
    HFSchemeStageSecond = 2,
    HFSchemeStageThird = 3
};
@implementation HFSchemeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_progressView setSeparatorNumber:2];
    UIImage *image = [UIImage scaleWithImage:@"My_bigButton"];
    [self.useBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setContent:(LoadSchemeDataAck *)info
{
    if (!info) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        return;
    }
    self.crowdLabel.text = [NSString stringWithFormat:@"适用人群：%@",info.crowd];
    self.schemeLabel.text = info.name;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:info.iconAddr] placeholderImage:IMG(@"pot")];
    if (info.isSubscribe) {
        if (info.isOver) {
            [_progressView setProgressImage:IMG(@"dark_progress_small")];
            
            [_progressView setProgress:1 animated:NO];
            [_progressView setSeparatorColor:[UIColor darkGrayColor]];
            [_progressView setSeparatorWidth:1];
        }else {
            self.pastDaysLabel.text = [NSString stringWithFormat:@"%@",@(info.currDay)];
            self.nextDaysLabel.text = [NSString stringWithFormat:@"%@",@(info.offsetDay)];
            self.contentLabel.text = info.content;
            [_progressView setProgressImage:IMG(@"bright_progress_small")];
            CGFloat rate = 0;
            if (info.currStage == HFSchemeStageFirst) {
                rate = ((7.-info.offsetDay)/7.0f)*(1.0f/3.0f);
            }else if (info.currStage == HFSchemeStageSecond) {
                rate = 1./3.0f + ((15.-info.offsetDay)/15.0f)*(1.0f/3.0f);
            }else if (info.currStage == HFSchemeStageThird){
                rate = 2./3.0f + ((23.-info.offsetDay)/23.0f)*(1.0f/3.0f);
            }
            [_progressView setProgress:rate animated:NO];
        }
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.peopleNumLabel.text = [NSString stringWithFormat:@"%@使用中",@(info.subscribeNum)];
    }
}

@end
