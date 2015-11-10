//
//  HFTitleView.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/10/21.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFTitleViewDelegate <NSObject>

- (void)titleViewDidSelectedAtIndex:(NSInteger)index clickMenuTap:(BOOL)clicked;

@end

@interface HFTitleView : UIView

@property (nonatomic, weak) id<HFTitleViewDelegate>delegate;
@property (nonatomic, assign) NSInteger currentIndex;
- (instancetype)initWithTitles:(NSArray *)titles withScrollView:(UIScrollView *)scrollView;

@end
