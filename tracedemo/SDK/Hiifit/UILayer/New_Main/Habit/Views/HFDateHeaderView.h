//
//  HFDateHeaderView.h
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HFDateDelegate;


@interface HFDateHeaderView : UIView

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic,   weak) id<HFDateDelegate>delegate;

- (void)setLeftViewHidden:(BOOL)hidden;
- (void)setRightViewHidden:(BOOL)hidden;
- (void)setTitileWithDate:(NSDate *)date nearDay:(NSInteger)day;

@end

@protocol HFDateDelegate <NSObject>

- (void)leftPage:(HFDateHeaderView *)dateHeader;
- (void)rightPage:(HFDateHeaderView *)dateHeader;

@end