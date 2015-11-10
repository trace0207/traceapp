//
//  MyInfoCell.m
//  GuanHealth
//
//  Created by hermit on 15/4/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "MyInfoCell.h"

@interface MyInfoCell ()
{
    UIImageView * imageView;
}
@end

@implementation MyInfoCell

- (void)awakeFromNib {
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 52, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 52, 0, 0)];
    }
    if (self.countLabel) {
        self.countLabel.layer.cornerRadius = self.countLabel.frame.size.height / 2.;
        self.countLabel.clipsToBounds = YES;
        self.countLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:145 / 255.0 blue:145 / 255.0 alpha:1];
        self.countLabel.textColor = [UIColor whiteColor];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.font = [UIFont systemFontOfSize:12];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setUnreadCount:(NSInteger)unreadCount
{
    if (unreadCount<=0) {
        self.countLabel.hidden = YES;
    }else {
        self.countLabel.hidden = NO;
        self.countLabel.text = [[NSNumber numberWithInteger:unreadCount]stringValue];
    }
    
}
- (void)judgeFirstLogin
{
    if (![kUserDefaults boolForKey:kParamFirstNew]) {
        if (!imageView) {
            imageView = [[UIImageView alloc] init];
            imageView.image = IMG(@"My_new");
            imageView.tag = 10086;
            [self.contentView addSubview:imageView];
            
            WS(weakSelf)
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.mas_right).with.offset(-36);
                make.centerY.equalTo(weakSelf.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(50, 20));
            }];
        }
        imageView.hidden = NO;
    }else{
        [self hiddenImageNew];
    }
}
- (void)hiddenImageNew
{
    UIView *v = [self.contentView viewWithTag:10086];
    if (v) {
        v.hidden = YES;
    }
}
@end
