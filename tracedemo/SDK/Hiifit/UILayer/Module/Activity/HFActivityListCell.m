//
//  HFActivityListCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFActivityListCell.h"

@implementation HFActivityListCell

- (void)awakeFromNib {
    // Initialization code
    self.lineView.backgroundColor = [UIColor HFColorStyle_6];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentCell:(HFActivityListData *)data
{
    [_activityBgImageView sd_setImageWithURL:[NSURL URLWithString:data.picAddrUrl] placeholderImage:IMG(@"main_banner")];
    
    UIImage * image;
    NSString * infoTips;
    switch (data.status)
    {
        case 1:       //进行中
        {
            image = [UIImage imageNamed:@"activityIn"];
            NSString * days = [NSString stringWithFormat:@"%02ld",(long)data.endDays];
            infoTips = [NSString stringWithFormat:@"还有%@天结束",days];
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:infoTips];
            [attributedStr addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor HFColorStyle_5]
                                  range:NSMakeRange([infoTips length] - 2 - days.length - 1, days.length)];
            _activiInfo.attributedText = attributedStr;
            break;
        }
        case 2:     //未开始
        {
            image = [UIImage imageNamed:@"activityUnbegin"];
            NSString * days = [NSString stringWithFormat:@"%02ld",(long)data.startDays];
            infoTips = [NSString stringWithFormat:@"还有%@天开始",days];
            
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:infoTips];
            [attributedStr addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor HFColorStyle_5]
                                  range:NSMakeRange([infoTips length] - 2 - days.length - 1, days.length)];
            _activiInfo.attributedText = attributedStr;
            break;
        }
        case 3:       //已结束
        {
            image = [UIImage imageNamed:@"activityEnd"];
            infoTips = [NSString stringWithFormat:@"%@~%@",data.startTimeFormat,data.endTimeFormat];
            _activiInfo.text = infoTips;
            break;
        }
        default:
            break;
    }
    
    _stautsImage.image = image;
    _activityName.text = data.title;
    
    [_activiInfo sizeToFit];
}

@end
