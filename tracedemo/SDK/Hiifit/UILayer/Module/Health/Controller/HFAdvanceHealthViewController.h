//
//  HFAdvanceHealthViewController.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/17.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"


@interface HFAdvanceHealthViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *mHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *mHeadBgView;
@property (weak, nonatomic) IBOutlet UILabel *mHeadTitle;
@property (weak, nonatomic) IBOutlet UILabel *mHeadInfo;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic) BOOL  bShowTest;

- (IBAction)tapSchemeDetail:(UITapGestureRecognizer *)sender;

@property (nonatomic)NSInteger  schemeID;

@end
