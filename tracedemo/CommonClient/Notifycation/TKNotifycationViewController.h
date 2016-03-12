//
//  TKNotifycationViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/11.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKNotifycationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *holeView;



+(void)showNotifyCation:(NSString *)text;

@end
