//
//  MainTableViewCell.m
//  GuanHealth
//
//  Created by hermit on 15/2/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "MainTableViewCell.h"
#import "HFMainActivityRes.h"

@implementation MainTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
   
}

- (void)setContentToCell:(id)data
{
    if ([data isKindOfClass:[HFMainActivityData class]]) {
//        HFMainActivityData *activity = (HFMainActivityData *)data;
//        self.titleLabel.text = activity.title;
//        //self.timeLabel.text = activity.tips;
//        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else if ([data isKindOfClass:[Data class]]){
        Data *timeData = (Data *)data;
        if (timeData.source == GZTimeLineTypeHabitTips) {
            self.titleLabel.text = timeData.content;
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (timeData.source == GZTimeLineTypeShareModulariry){
            self.nameLabel.text = timeData.operatorName;
            [self.nameLabel sizeToFit];
            self.titleLabel.text = [NSString stringWithFormat:@"向你分享了%@模块",timeData.remark];
            self.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        if (timeData.createTimeUTC>0) {
            self.timeLabel.text = [NSDate stringWithTimeUTC:timeData.createTimeUTC];
        }else {
            self.timeLabel.text = @"刚刚";
        }
        if (timeData.headPortraitUrl.length>0) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:timeData.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        }else{
            [self.headImageView setImage:[UIImage imageNamed:@"heabit"]];
        }
        self.userBtn.tag = timeData.operatorId;
        [self.userBtn addTarget:self action:@selector(clickUserHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickUserHeadImage:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(goUserHomePage:)]) {
        [_delegate goUserHomePage:(int)btn.tag];
    }
}

@end
