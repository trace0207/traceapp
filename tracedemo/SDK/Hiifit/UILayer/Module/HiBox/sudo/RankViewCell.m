//
//  RankViewCell.m
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "RankViewCell.h"

@implementation RankViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setContentToCell:(UploadGameData*)data
{
    UIImage *image = nil;
    if (data.rowNum == 1) {
        image = [UIImage imageNamed:@"number_one"];
        self.rankLabel.text = @"";
    }else if (data.rowNum == 2){
        image = [UIImage imageNamed:@"number_two"];
        self.rankLabel.text = @"";
    }else if (data.rowNum == 3){
        image = [UIImage imageNamed:@"number_three"];
        self.rankLabel.text = @"";
    }else{
        image = [UIImage imageNamed:@"rank_bg_circle"];
        self.rankLabel.text = [NSString stringWithFormat:@"%i",data.rowNum];
    }
    [self.rankImage setImage:image];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
    self.nameLabel.text = data.nickName;
    self.timeLabel.text = [UIKitTool getTimeStrFromUTC:data.spendTime];
}

@end
