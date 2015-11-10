//
//  HFBindingViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"

@interface HFBindingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchAction:(id)sender;
@end
