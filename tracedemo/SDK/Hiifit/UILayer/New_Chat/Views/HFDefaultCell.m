//
//  HFDefaultCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/28.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFDefaultCell.h"

@implementation HFDefaultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsMake(0, 60, 0, 0)];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //self.imageView.bounds =CGRectMake(15,15,30,30);
    self.imageView.frame = CGRectMake(15,15,30,30);
    self.imageView.contentMode =UIViewContentModeScaleAspectFit;
    [self.imageView.layer setCornerRadius:15];
    self.imageView.clipsToBounds = YES;
    self.textLabel.textColor = [UIColor HFColorStyle_1];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = 60;
    self.textLabel.frame = tmpFrame;
//
//    tmpFrame = self.detailTextLabel.frame;
//    tmpFrame.origin.x = 46;
//    self.detailTextLabel.frame = tmpFrame;
}

@end
