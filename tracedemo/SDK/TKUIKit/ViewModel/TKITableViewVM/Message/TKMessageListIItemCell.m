//
//  TKMessageListIItemCell.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/18.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKMessageListIItemCell.h"
#import "NSDate+HFHelper.h"
#import "NSString+HFStrUtil.h"
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
        self.timeLabel.text = [NSDate stringWithTimeUTC:data.msgData.createTime.integerValue/1000];
        self.messageLabel.text = data.msgData.content;
    }
    else if(data.boxItemData != nil)
    {
        if(data.boxItemData.boxType == 0)
        {
            [self.headImage setImage:IMG(@"mes_forgive")];
            self.nameLabel.text = @"订单通知";
            if([NSString isStrEmpty:data.boxItemData.boxContent])
            {
                self.messageLabel.text = @"您没有订单通知";
                self.timeLabel.text = @"";
            }else
            {
                self.messageLabel.text = data.boxItemData.boxContent;
                self.timeLabel.text = [NSDate stringWithTimeUTC:data.boxItemData.createTime.integerValue/1000];
            }
        }
        else if(data.boxItemData.boxType == 1)
        {
            [self.headImage setImage:IMG(@"mes_statement")];
            self.nameLabel.text = @"支付通知";
            if([NSString isStrEmpty:data.boxItemData.boxContent])
            {
                self.messageLabel.text = @"您没有支付通知";
                self.timeLabel.text = @"";
            }else
            {
                self.messageLabel.text = data.boxItemData.boxContent;
                self.timeLabel.text = [NSDate stringWithTimeUTC:data.boxItemData.createTime.integerValue/1000];
            }
        }
        else if(data.boxItemData.boxType ==2)
        {
            self.nameLabel.text = @"点赞通知";
            [self.headImage setImage:IMG(@"mes_praise")];
            if([NSString isStrEmpty:data.boxItemData.boxContent])
            {
                self.messageLabel.text = @"您没有点赞通知";
                self.timeLabel.text = @"";
            }else
            {
                self.messageLabel.text = data.boxItemData.boxContent;
                self.timeLabel.text = [NSDate stringWithTimeUTC:data.boxItemData.createTime.integerValue/1000];
            }
        }
    }
}

@end


