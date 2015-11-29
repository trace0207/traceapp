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

    if(_clearDelegate && [_clearDelegate respondsToSelector:@selector(onClearViewEvent)])
    {
        [_clearDelegate onClearViewEvent];
    }
    return nil;
}

@end
