//
//  BannerView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "SDCycleScrollView.h"

@interface BannerView : SDCycleScrollView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSAttributedString *attributedString;

@end
