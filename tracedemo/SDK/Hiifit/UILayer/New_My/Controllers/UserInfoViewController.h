//
//  UserInfoViewController.h
//  GuanHealth
//
//  Created by hermit on 15/3/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableViewController.h"

@interface UserInfoViewController : BaseTableViewController

@property (strong, nonatomic) IBOutlet UITableViewCell  *headCell;
@property (weak,   nonatomic) IBOutlet UILabel          *headLabel;
@property (weak,   nonatomic) IBOutlet UIImageView      *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *mHiScore;

@end