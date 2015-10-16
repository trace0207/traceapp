//
//  UIViewController+TKTestController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/10/10.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "UIViewController+TKTestController.h"

@implementation UIViewController (TKTestController)

-(void)viewDidAppear:(BOOL)animated{

    DDLogInfo(@"showTestController class = %@",NSStringFromClass([self class]));
}

@end
