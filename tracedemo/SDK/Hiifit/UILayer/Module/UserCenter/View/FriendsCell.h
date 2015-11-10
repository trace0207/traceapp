//
//  FriendsCell.h
//  GuanHealth
//
//  Created by hermit on 15/4/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsData.h"

@interface FriendsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
//@property (weak, nonatomic) IBOutlet UIButton *userBtn;
- (void)setValueToCell:(FriendsData *)data;

@end
