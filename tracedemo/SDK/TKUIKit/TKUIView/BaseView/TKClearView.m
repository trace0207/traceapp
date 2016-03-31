//
//  TKClearView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKClearView.h"

@implementation TKClearView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    if(_clearDelegate && [_clearDelegate respondsToSelector:@selector(onClearViewEvent:withEvent:)])
    {
        UIView * view = [_clearDelegate onClearViewEvent:point withEvent:event];
        if(view != nil)
        {
            return  view;
        }
        return nil;
    }
    return nil;
}

@end
