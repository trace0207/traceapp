//
//  HFWeekdaySelectView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFWeekdaySelectViewDelegate <NSObject>

- (void)weekSelectAction:(NSInteger)index selectedState:(BOOL)selected;

@end

@interface HFWeekdaySelectView : UIView

@property(nonatomic,weak)id<HFWeekdaySelectViewDelegate>delegate;

- (void)reloadData:(NSArray *)sources;

@end
