//
//  TKHomePageViewController.h
//  tracedemo
//
//  Created by 罗田佳 on 15/10/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKBaseViewController.h"
#import "TKUserCenter.h"



@protocol HomePageEventProtocol <NSObject>

-(void)leftBarIconDidClick;

@end

@interface TKHomePageViewController : TKBaseViewController
@property (nonatomic, weak)id<HomePageEventProtocol>eventDelegate;

+(NSArray *)imaginaryShowOrdersData;

@end
