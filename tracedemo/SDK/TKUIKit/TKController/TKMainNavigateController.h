//
//  TKMainNavigateController.h
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKColorDefine.h"


typedef NS_ENUM(NSInteger,TK_LoginEvent)
{
    TK_Default = 0,
    TK_GoToUserCenter = 1,
    TK_GoToPublishReward = 2,
    TK_GoToOrderWebView = 3,
    TK_GoToMyShowGoodsView = 4,
    TK_GotoMessageCenter = 5
    
};

@interface TKMainNavigateController : UITabBarController


+(TKMainNavigateController *)showNavigateControllerInWindow:(UIWindow *) window;


@end
