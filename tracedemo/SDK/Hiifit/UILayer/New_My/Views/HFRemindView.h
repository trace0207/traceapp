//
//  HFRemindView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/29.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HFRemindViewDelegate <NSObject>

- (void)myDeviceClicked;

@end
@interface HFRemindView : UIView

@property (nonatomic, weak) id<HFRemindViewDelegate>delegate;
@property (nonatomic) BOOL  bHasSetting;
- (void)show;
- (void)dismiss;

@end
