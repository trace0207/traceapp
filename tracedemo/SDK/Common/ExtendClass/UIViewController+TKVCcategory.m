//
//  UIViewController+TKVCcategory.m
//  tracedemo
//
//  Created by 罗田佳 on 15/10/9.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "UIViewController+TKVCcategory.h"

@implementation UIViewController (TKVCcategory)

-(void)viewDidAppear:(BOOL)animated{

    DDLogInfo(@"showVC class is %@", NSStringFromClass([self class]));
}


@end
