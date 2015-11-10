//
//  HFTitleBar.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFTitleBarDelegate <NSObject>

- (void)selectBarItem:(NSInteger)index;

@end

@interface HFTitleBar : UIView


@property(nonatomic,weak)id<HFTitleBarDelegate>delegate;
@property(nonatomic,strong)NSArray * mTitles;
@property(nonatomic)BOOL hasLine;
//- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles;

/**
 *  更新barItem完成状态
 *
 *  @param index
 */
- (void)updateBarItemFinish:(NSInteger)index;

/**
 *  更新barItem选中
 *
 *  @param index
 */
- (void)updateItemSelected:(NSInteger)index;

- (void)setBarTitles:(NSArray *)titles selectColor:(UIColor *)selColor  disColor:(UIColor *)disColor;

@end
