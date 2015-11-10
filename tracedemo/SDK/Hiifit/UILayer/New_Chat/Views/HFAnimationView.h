//
//  HFAnimationView.h
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/7/30.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFAnimationView : UIView//自定义动画控件

- (id)initWithFrame:(CGRect)frame timeInterval:(CGFloat)interval repeatCounts:(NSInteger)repeatCounts;//初始化方法：需要传进去一个动画时长和一个重播次数(重播次数为0的话代表一直播放)
@property (nonatomic, strong) NSArray * imageArray;//动画图片数组

@end
