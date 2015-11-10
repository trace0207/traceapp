//
//  HFInsightLargeImageView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFInsightLargeImageView : UIImageView

- (void)dd_setImageURL:(NSURL *)imageURL;

- (void)dd_setImageURL:(NSURL *)imageURL withPlaceholder:(UIImage *)image;

- (void)dd_setImage:(UIImage *)image;

@end
