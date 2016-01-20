//
//  TKEditTextViewController.h
//  tracedemo
//
//  Created by 罗田佳 on 16/1/5.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface TKEditTextViewController : TKIBaseNavWithDefaultBackVC

@property (nonatomic,strong)NSString * text;
@property (nonatomic,assign)NSInteger inPutType;
@property (nonatomic,assign)NSInteger tag;


@end
