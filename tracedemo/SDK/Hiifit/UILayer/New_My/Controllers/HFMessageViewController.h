//
//  HFMessageViewController.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/20.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BTScrollViewController.h"

#define kMsgComment   @"comment_msg"
#define kMsgPrised    @"prise_msg"
#define kMsgFollow    @"follow_msg"
#define kMsgSystem    @"system_msg"

@protocol HFMessageViewControllerDelegate <NSObject>

- (void)updateMessageBoxIcon:(NSInteger)unreadNum;

@end

@interface HFMessageViewController : BTScrollViewController<BTScrollViewDelegate>

@property(nonatomic,weak)id<HFMessageViewControllerDelegate>delegate;
@property(nonatomic,strong)NSMutableArray * mSourceMessageCountArr;

@end
