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
    if (data.type == TKMessageTypeForgive) {
        [self.headImage setImage:IMG(@"mes_forgive")];
    }else if (data.type == TKMessageTypeStatement) {
        [self.headImage setImage:IMG(@"mes_statement")];
    }else if (data.type == TKMessageTypePraise) {
        [self.headImage setImage:IMG(@"mes_praise")];
    }else if (data.type == TKMessageTypeService) {
        [self.headImage setImage:IMG(@"mes_service")];
    }else{
        [self.headImage setImage:IMG(@"mes_default")];
    }
    self.nameLabel.text = data.name;
    self.messageLabel.text = data.describle;
    self.timeLabel.text = [NSDate stringWithTimeUTC:data.secondsUTC];
}

@end


