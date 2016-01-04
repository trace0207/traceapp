//
//  TKHeadImageView.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKHeadImageView : UIImageView

@property (nonatomic,strong) NSString * userId;


- (void)tkAddTapAction:(SEL)selector forTarget:(id)target;

@end
