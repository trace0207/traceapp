//
//  MyInfoCell.h
//  GuanHealth
//
//  Created by hermit on 15/4/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, assign) NSInteger unreadCount;

- (void)judgeFirstLogin;
- (void)hiddenImageNew;

@end
