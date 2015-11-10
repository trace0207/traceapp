//
//  FriendsViewController.h
//  GuanHealth
//
//  Created by hermit on 15/4/15.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableViewController.h"

#define KEY_FOLLOWS @"关注列表"
#define KEY_FANS    @"粉丝列表"

@interface FriendsViewController : BaseTableViewController

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic,   copy) NSString *from;

@property (nonatomic, assign) int pageIndex;

@end
