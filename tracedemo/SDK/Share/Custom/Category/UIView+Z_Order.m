//
//  UIView+Z_Order.m
//  test
//
//  Created by hermit on 15/3/31.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "UIView+Z_Order.h"

@implementation UIView (Z_Order)
-(NSUInteger)getSubviewIndex
{
    return [self.superview.subviews indexOfObject:self];
}
-(void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}
-(void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}
-(void)bringOneLevelUp
{
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}
-(void)sendOneLevelDown
{
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}
-(BOOL)isInFront
{
    return ([self.superview.subviews lastObject]==self);
}
-(BOOL)isAtBack
{
    return ([self.superview.subviews objectAtIndex:0]==self);
}
-(void)swapDepthsWithView:(UIView*)swapView
{
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}
@end
