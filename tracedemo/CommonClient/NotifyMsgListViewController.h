//
//  NotifyMsgListViewController.h
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "NotifyMsgListVM.h"



@interface NotifyMsgListViewController : TKIBaseNavWithDefaultBackVC

@property (nonatomic,strong)NotifyMsgListVM * vm;

+(void)showBoxList:(NSInteger) boxType;

@end
