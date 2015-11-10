//
//  GrayPageControl.m
//
//  Created by blue on 12-9-28.
//  Copyright (c) 2012年 blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood
//


#import "GrayPageControl.h"


@implementation GrayPageControl


//- (id)initWithCoder:(NSCoder *)aDecoder {
//
//    self = [super initWithCoder:aDecoder];
//    if ( self ) {
//
//        activeImage = [UIImage imageNamed:@"indicator_point_select"];
//        inactiveImage = [UIImage imageNamed:@"indicator_point_nomal"];
//
//        [self setCurrentPage:1];
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)aFrame {
    
	if (self = [super initWithFrame:aFrame]) {
        activeImage = [UIImage imageNamed:@"indicator_point_select"];
        inactiveImage = [UIImage imageNamed:@"indicator_point_nomal"];
        //self.backgroundColor = [UIColor whiteColor];
        [self setCurrentPage:1];
	}
	return self;
}
-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView * dot = [self imageViewForSubview:[self.subviews objectAtIndex: i]];
        if (i == self.currentPage) {
            dot.image = activeImage;
            dot.frame = CGRectMake(-4, -4, 15, 15);
        }
        else {
            dot.image = inactiveImage;
            dot.frame = CGRectMake(0, 0, 7, 7);
        }
    }
}
- (UIImageView *) imageViewForSubview: (UIView *) view
{
    UIImageView * dot = nil;
    if ([view isKindOfClass: [UIView class]])
    {
        for (UIView* subview in view.subviews)
        {
                dot = (UIImageView *)subview;
                break;
        }
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }
    else
    {
        dot = (UIImageView *) view;
    }
    
    return dot;
}
-(void) setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    [self updateDots];
}



@end
