//
//  UIView+Z_Order.h
//  test
//
//  Created by hermit on 15/3/31.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Z_Order)
-(NSUInteger)getSubviewIndex;
-(void)bringToFront;
-(void)sendToBack;
-(void)bringOneLevelUp;
-(void)sendOneLevelDown;
-(BOOL)isInFront;
-(BOOL)isAtBack;
-(void)swapDepthsWithView:(UIView*)swapView;
@end
