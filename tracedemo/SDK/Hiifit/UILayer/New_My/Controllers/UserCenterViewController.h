//
//  UserCenterViewController.h
//  GuanHealth
//
//  Created by hermit on 15/3/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface UserCenterViewController : BaseViewController

@property (nonatomic,   strong) IBOutlet UIView      *headView;
@property (nonatomic,   weak) IBOutlet UIImageView *headImage;
@property (nonatomic,   weak) IBOutlet UIImageView *sexImage;
@property (nonatomic,   weak) IBOutlet UILabel     *focusLable;
@property (nonatomic,   weak) IBOutlet UILabel     *funsLable;
@property (nonatomic,   weak) IBOutlet UILabel     *signameLabel;
@property (nonatomic,   weak) IBOutlet UIButton    *editBtn;
@property (nonatomic,   weak) IBOutlet UILabel     *nameLabel;

- (IBAction)seeFriendsAction:(UIButton*)sender;
- (IBAction)seeBigImage:(UIButton*)sender;
- (IBAction)editUserInfo:(UIButton *)sender;

@end
