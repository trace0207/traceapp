//
//  HFGiveUpView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HFGiveUpViewDelegate <NSObject>

@optional
- (void)cancleButtonClick;
- (void)giveUpButtonClick;

@end
@interface HFGiveUpView : UIView

@property (nonatomic, weak) id<HFGiveUpViewDelegate>delegate;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * encourageLabel;

- (void)show;


- (void)dismiss;

@end
