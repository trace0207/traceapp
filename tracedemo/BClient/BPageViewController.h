//
//  BPageViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/12.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "ViewPagerController.h"

@interface BPageViewController : ViewPagerController
@property (nonatomic,assign)HomePageType dataType;
-(void)reloadTitleView;

@end
