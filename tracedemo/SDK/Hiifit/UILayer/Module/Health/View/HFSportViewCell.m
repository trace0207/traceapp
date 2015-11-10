//
//  HFSportViewCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSportViewCell.h"
#import "NSString+HFStrUtil.h"
@implementation HFSportViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setImage:(NSString *)imageName
           title:(NSString *)title
         content:(NSString *)content
{
    [self.headImageView setImage:IMG(imageName)];
    self.titleLabel.text = [title URLDecodedForString];
    NSString *detailText = [[content URLDecodedForString] stringByReplacingOccurrencesOfString:@"||" withString:@"\n"];
    self.contentLabel.text = detailText;
}

@end
