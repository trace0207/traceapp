//
//  HFNewMainHeaderView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/21.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFNewMainHeaderViewDelegate <NSObject>

- (void)buttonClick:(NSInteger)index;

@end


@interface HFNewMainHeaderView : UIView

@property(nonatomic,weak)id<HFNewMainHeaderViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;

@end
