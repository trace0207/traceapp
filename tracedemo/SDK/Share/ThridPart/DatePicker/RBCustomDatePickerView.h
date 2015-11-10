//
//  RBCustomDatePickerView.h
//  RBCustomDateTimePicker
//  e-mail:rbyyy924805@163.com
//  Created by renbing on 3/17/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

@protocol RBCustomDatePickerViewDelegate <NSObject>

- (NSString *)showTimeString;

- (void)setTimeHour:(NSInteger)hour  min:(NSInteger)min;

@end

@interface RBCustomDatePickerView : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>

@property(nonatomic,weak)id<RBCustomDatePickerViewDelegate>delegate;

- (void)setTimeBroadcastView;

- (void)back;
@end
