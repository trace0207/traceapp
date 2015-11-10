//
//  HFUnBindingViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"

@interface HFUnBindingViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UIImageView *runCircleImage;

- (IBAction)unbindingAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
