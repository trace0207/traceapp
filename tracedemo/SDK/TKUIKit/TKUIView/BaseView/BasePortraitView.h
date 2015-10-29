//
//  PortraitView.h
//  test
//
//  Created by hermit on 15/5/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePortraitView : UIImageView

//增加手势
- (void)addAction:(SEL)selector forTarget:(id)target;
//移除手势
- (void)removeAction;

@end
