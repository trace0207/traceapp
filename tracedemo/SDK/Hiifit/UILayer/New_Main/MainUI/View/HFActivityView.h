//
//  HFActivityView.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/11/3.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFActivityViewDelegate <NSObject>

- (void)goActivityView:(NSString *)url;
@optional
- (void)cancel;

@end

@interface HFActivityView : UIView
@property (nonatomic, weak)id<HFActivityViewDelegate>delegate;
- (instancetype)initWithImage:(NSString *)urlStr activityUrl:(NSString *)url;
- (void)show;
@end
