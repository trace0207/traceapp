//
//  HFCupView.h
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/17.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinishSchemeAck.h"
@class HFCupView;
@protocol HFCupViewDelegate <NSObject>

- (void)thoughtsButtonClick:(HFCupView *)cupView;

@optional
- (void)cancle:(HFCupView *)cupView;

@end
@interface HFCupView : UIView
- (instancetype)initWithSchemeInfo:(FinishSchemeData *)data;

@property (nonatomic, weak) id<HFCupViewDelegate>delegate;

- (void)show;

- (void)dismiss;

@end
