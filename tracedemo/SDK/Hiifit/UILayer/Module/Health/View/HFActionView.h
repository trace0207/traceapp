//
//  HFActionView.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/21.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchemeActionsAck.h"
#define BASETAG 100
@interface HFActionView : UIView

- (void)setActionData:(SchemeActionsData *)data;
- (void)selectedItemSelector:(SEL)selector withTarget:(id)target;

@end
