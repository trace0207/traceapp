//
//  HFControl.h
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/7/30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HFControl : UIView

@property (nonatomic, strong) UIImageView * mIconImage;

- (void)addTargetSelector:(NSString *)selector;

@end
