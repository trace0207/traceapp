//
//  CountDownView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol CountDownViewDelegate <NSObject>

- (void)timeOver;//倒计时结束

@end

//视图宽高要求  height = (width - 12)/3
@interface CountDownView : UIView

@property (nonatomic, assign) NSTimeInterval secondsUTC;
@property (nonatomic, weak) id<CountDownViewDelegate>delegate;

@end


