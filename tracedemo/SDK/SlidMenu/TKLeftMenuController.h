//
//  TKLeftMenuController.h
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKTableViewController.h"

@interface TKLeftMenuController : TKTableViewController

/**
 *  初始化 制定宽度的 menu
 *
 *  @param maxWidth 最大 屏幕宽度
 *
 *  @return self
 *///

-(id)initWithMaxWidth : (NSInteger) maxWidth;

@end
