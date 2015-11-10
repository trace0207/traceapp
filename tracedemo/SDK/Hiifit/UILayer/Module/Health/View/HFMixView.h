//
//  HFMixView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, mixType) {
    horizontalType = 0,
    verticalType,
};

@interface HFMixView : UIView

@property(nonatomic)mixType  mType;

- (void)setContextText:(NSString *)text withImage:(UIImage *)image;

@end
