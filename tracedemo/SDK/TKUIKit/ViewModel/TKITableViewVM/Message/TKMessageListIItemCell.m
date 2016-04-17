//
//  TKMessageListIItemCell.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/18.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKMessageListIItemCell.h"
#import "NSDate+HFHelper.h"
@implementation TKMessageData
@end

@implementation TKMessageListIItemCell

- (void)awakeFromNib {
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContentData:(TKMessageData *)data
{
    
    if(data.msgData != nil)
    {
        [self.headImage setImage:IMG(@"mes_default")];
        self.nameLabel.text = @"IM对话消息";
        self.timeLabel.text = [NSDate stringWithTimeUTC:data.msgData.createTime.integerValue];
        self.messageLabel.text = data.msgData.content;
    }
    else if(data.boxItemData != nil)
    {
        if(data.boxItemData.boxType == 0)
        {
            [self.headImage setImage:IMG(@"mes_forgive")];
            self.nameLabel.text = @"订单通知";
        }
        else if(data.boxItemData.boxType == 1)
        {
            [self.headImage setImage:IMG(@"mes_statement")];
            self.nameLabel.text = @"支付通知";
        }
        else if(data.boxItemData.boxType ==2)
        {
            self.nameLabel.text = @"点赞通知";
            [self.headImage setImage:IMG(@"mes_praise")];
        }
      self.timeLabel.text = [NSDate stringWithTimeUTC:data.secondsUTC];
      self.messageLabel.text = data.boxItemData.boxContent;
    }
}

@end


