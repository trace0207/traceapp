//
//  TKClearView.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKClearViewDelegate <NSObject>

@optional
-(UIView *)onClearViewEvent:(CGPoint)point withEvent:(UIEvent *)event;

@end

@interface TKClearView : UIView
@property (weak,nonatomic)id<TKClearViewDelegate> clearDelegate;

@end
