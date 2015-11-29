//
//  TKClearView.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKClearViewDelegate <NSObject>

-(void)onClearViewEvent;

@end

@interface TKClearView : UIView
@property (weak,nonatomic)id<TKClearViewDelegate> clearDelegate;

@end
