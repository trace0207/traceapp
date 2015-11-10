//
//  HFItem.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFItem : UIView

@property (nonatomic, strong) UIImageView   *iconImageView;
@property (nonatomic, strong) UILabel       *textLabel;

@property (nonatomic, strong) UIFont        *textFont;//设置textLabel的font
@property (nonatomic, strong) UIColor       *textColor;//设置textLabel的Color
@property (nonatomic, strong) UILabel       *tieBarUnreadLabel;//贴吧帖子数label
- (void)setItemWithImageUrl:(NSString *)imageUrl andText:(NSString *)text;

- (void)addTarget:(id)target selector:(SEL)selector withObject:(id)object;

- (void)setLocalImage:(UIImage *)image andText:(NSString *)text;

@end
