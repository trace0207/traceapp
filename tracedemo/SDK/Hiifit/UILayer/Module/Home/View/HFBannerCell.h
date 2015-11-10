//
//  HFBannerCell.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFBannerCellDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface HFBannerCell : UIView
@property (nonatomic, weak) id<HFBannerCellDelegate>delegate;

- (void)setBannerToCell:(NSArray *)imageUrls;

@end
