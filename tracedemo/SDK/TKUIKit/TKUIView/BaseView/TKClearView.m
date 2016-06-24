//
//  TKClearView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKClearView.h"

@implementation TKClearView


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    if(![self pointInside:point withEvent:event])
    {
        return nil;
    }
    if(_clearDelegate && [_clearDelegate respondsToSelector:@selector(hideKeyboardExcludeViews)])
    {
        NSArray * views = [_clearDelegate hideKeyboardExcludeViews];
        BOOL hide = YES;
        for (UIView * view in views) {
            
            CGPoint tapPoint = [view convertPoint:point fromView:self];
            
            if([view pointInside:tapPoint withEvent:event])
            {
                hide = NO;
            }
        }
        if(hide)
        {
            [self endEditing:YES];
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
