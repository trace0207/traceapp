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
-(BOOL)hideKeyboardOnPoint:(CGPoint)point withEvent:(UIEvent *)event;

-(NSArray *)hideKeyboardExcludeViews;

@end

/**
 用于回收键盘的view
 需要相应触碰 收起键盘的区域，只需要将最外层的UIView 设置为 TKClearView。 
 实现代理方法 hideKeyboardExcludeViews  返回不需要收起键盘的view数组即可
 **/
@interface TKClearView : UIView
@property (weak,nonatomic)id<TKClearViewDelegate> clearDelegate;

@end
