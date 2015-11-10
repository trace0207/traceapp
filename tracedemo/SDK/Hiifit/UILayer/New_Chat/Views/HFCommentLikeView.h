//
//  HFCommentLikeView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFCommentLikeViewDelegate <NSObject>

- (void)liveViewHeadAction:(NSInteger)userID;

- (void)moreUserLikes:(NSArray *)users;

@end

@interface HFCommentLikeView : UIView

@property(nonatomic,weak)id<HFCommentLikeViewDelegate>delegate;
//刷新界面
- (CGFloat)reloadUI:(NSArray *)sourceArr;

@end
