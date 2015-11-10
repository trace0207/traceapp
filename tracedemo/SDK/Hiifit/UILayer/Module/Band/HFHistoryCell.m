//
//  HFHistoryTableViewCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/8.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFHistoryCell.h"
#import "NSDate+Common.h"
@implementation HFHistoryCell

- (void)awakeFromNib {
    self.bgView.layer.cornerRadius = 5.0;
    self.topView.backgroundColor = [UIColor HFColorStyle_5];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setContent:(BandHistoryData *)data
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * ackdate = [formatter dateFromString:data.createDate];
 
    NSArray * dateArr = [data.createDate componentsSeparatedByString:@"-"];
    
    NSInteger month = 0;
    NSInteger day = 0;
    if ([dateArr count] == 3)
    {
        month = [[dateArr objectAtIndex:1] integerValue];
        day = [[dateArr objectAtIndex:2] integerValue];
    }
    
    NSInteger flag = [NSDate compareIfTodayWithDate:ackdate];
    NSString *text = nil;
    if (flag == 0) {
        text = @"今日活动记录｜刚刚同步";
    }else if (flag == 1){
        text = @"昨日活动记录";
    }else {
        text = [NSString stringWithFormat:@"%@月%@日活动记录",@(month),@(day)];
    }
    self.dateLabel.text = text;
    self.stepLabel.text = [[NSNumber numberWithInteger:data.step]stringValue];
    self.caloriesLabel.text = [NSString stringWithFormat:@"%@大卡",[NSNumber numberWithInteger:data.calorie]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
