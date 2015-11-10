//
//  SetHeadViewController.h
//  GuanHealth
//
//  Created by hermit on 15/5/14.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"
#import "BasePortraitView.h"
@interface SetHeadViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UIButton    *photoBtn;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet BasePortraitView *headImage;

- (IBAction)photoAction:(id)sender;

@end
