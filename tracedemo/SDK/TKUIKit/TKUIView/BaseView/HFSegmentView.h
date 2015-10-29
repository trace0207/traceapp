//
//  HFSegmentView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/17.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFSegmentViewDelegate <NSObject>

- (void)selectSegmentIndex:(NSInteger)index;

@end

@interface HFSegmentView : UIView

@property(nonatomic,weak)id<HFSegmentViewDelegate>delegate;

- (void)setSegmentTitles:(NSArray *)titles;

@end
