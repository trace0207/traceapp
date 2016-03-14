//
//  HFTitleLabel.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFTitleLabel : UIView

@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;


- (void)setTitle:(NSString *)title number:(NSInteger)number;

@end
