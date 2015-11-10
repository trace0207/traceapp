//
//  HFBigImageView.h
//  GuanHealth
//
//  Created by hermit on 15/5/24.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFBigImageView : UIView

- (instancetype)initWithImage:(UIImage *)image withImageUrl:(NSString *)urlStr;

- (instancetype)initWithImage:(UIImage *)image;

- (void)show;

@end
