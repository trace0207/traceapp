//
//  sijiacheWebViewcontroller.h
//  rentCar
//
//  Created by duonuo on 14-6-21.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define KEY_ADD_HABIT   @"addHabit"
#define KEY_ADD_FRIEND  @"addFriend"

@interface WebViewController : BaseViewController

@property (nonatomic,   copy)          NSString     *from;
@property (nonatomic, assign)          HIModuleType moduleType;
@property (nonatomic, strong) IBOutlet UIWebView    *webView;

@end
