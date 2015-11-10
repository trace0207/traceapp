//
//  HFTopImageView.h
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/6.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFTopImageView : UIView

@property (nonatomic, assign) NSInteger numberOfImages;//圈圈总共的个数
@property (nonatomic, assign) CGFloat imageWidth;//圈圈宽高，默认40;
- (void)changeFinishImage:(NSInteger)index;
- (void)changeFormerImage:(NSInteger)index;
@end
