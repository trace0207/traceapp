//
//  HFDevInfoViewController.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, RightBarType) {
    Bar_Unbind_State = 0,
    Bar_Success_State,
    Bar_Loading_State,
    Bar_Fail_State,
};

@interface HFDevInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *connectStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *calariesLabel;
- (IBAction)lookHistoryAction:(id)sender;

@end
