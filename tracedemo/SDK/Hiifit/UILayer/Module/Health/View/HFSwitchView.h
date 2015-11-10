//
//  HFSwitchView.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/16.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFSwitchViewDelegate <NSObject>

- (void)switchDidSelectAtIndex:(NSInteger)index;

@end

@interface HFSwitchView : UIView

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) id<HFSwitchViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;


@end
