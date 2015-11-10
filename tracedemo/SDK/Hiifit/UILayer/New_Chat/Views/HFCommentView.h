//
//  HFCommentView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCommentLikeView.h"
#import "HFCommentInfoView.h"
@protocol HFCommentViewDelegate <NSObject>

- (void)startComment:(NSInteger)authorID nickName:(NSString *)nickName;

- (void)headPageJumpAction:(NSInteger)userId;

- (void)commentViewHandle:(HFCommentUsersData *)data infoView:(HFCommentInfoView *)infoView;

- (void)jumpToLikeUsersList:(NSArray *)users;

@end


@interface HFCommentView : UIView<HFCommentInfoViewDelegate,HFCommentLikeViewDelegate>
{
    NSArray * mLikeImages;    //点赞的数组
    
    NSArray * mCommentInfos;   //具体的评论
    HFCommentLikeView * mLikeView;
}
@property(nonatomic,strong)NSArray * mLikeImages;
@property(nonatomic,strong)NSArray * mCommentInfos;
@property(nonatomic,weak)id<HFCommentViewDelegate>delegate;
- (CGFloat)updateLikeUI;

- (CGFloat)updateCommentUI;
@end
