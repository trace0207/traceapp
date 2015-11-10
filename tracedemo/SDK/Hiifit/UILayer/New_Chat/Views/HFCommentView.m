//
//  HFCommentView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCommentView.h"


@interface HFCommentView()

@end

@implementation HFCommentView
@synthesize mCommentInfos,mLikeImages;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (CGFloat)updateLikeUI
{
    
    if (!mLikeView) {
        mLikeView = [[HFCommentLikeView alloc] init];
        mLikeView.delegate = self;
        [self addSubview:mLikeView];
    }
    
    if ([mLikeImages count] == 0)
    {
        mLikeView.hidden = YES;
        mLikeView.frame = CGRectZero;
    }
    else
    {
        mLikeView.hidden = NO;
        CGFloat height = [mLikeView reloadUI:mLikeImages];
        mLikeView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    }
    return mLikeView.frame.origin.x + mLikeView.frame.size.height;
}

- (CGFloat)updateCommentUI
{
    //移除所有子视图
    for (id view in self.subviews) {
        if ([view isKindOfClass:[HFCommentInfoView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat orignHeight = mLikeView.frame.origin.y + mLikeView.frame.size.height;
    for (int i = 0; i < [mCommentInfos count]; i++) {
        HFCommentUsersData * data = [mCommentInfos objectAtIndex:i];
        
        HFCommentInfoView * infoView = [[HFCommentInfoView alloc] init];
        infoView.data = data;
        infoView.delegate = self;
        [self addSubview:infoView];
        CGFloat height;
        if (i == 0)
        {
            height = [infoView reloadUI:data msgImage:YES];
        }
        else
        {
            height = [infoView reloadUI:data msgImage:NO];
        }
        infoView.frame = CGRectMake(16, orignHeight, self.frame.size.width - 32, height);
        
        orignHeight += height;

        [infoView addLongAction:@selector(longGestureAction:) forTarget:self];
    }
    
    return orignHeight;
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        HFCommentInfoView * commentInfoView = (HFCommentInfoView *)gesture.view;
        commentInfoView.backgroundColor = [UIColor HFColorStyle_6];
        if (self.delegate && [self.delegate respondsToSelector:@selector(commentViewHandle: infoView:)]) {
            [self.delegate commentViewHandle:commentInfoView.data infoView:commentInfoView];
        }
    }
}
#pragma mark -
#pragma mark private

- (void)jumpPageWithId:(NSInteger)userID
{
    if (delegate && [delegate respondsToSelector:@selector(headPageJumpAction:)])
    {
        [delegate headPageJumpAction:userID];
    }
}

#pragma mark -
#pragma mark HFCommentInfoViewDelegate
- (void)selectCommentInfo:(NSInteger)authorID withNickName:(NSString *)name
{
    if (delegate && [delegate respondsToSelector:@selector(startComment:nickName:)]) {
        [delegate startComment:authorID nickName:name];
    }
}

- (void)commentInfoHeadAction:(NSInteger)userID
{
    [self jumpPageWithId:userID];
}

#pragma mark -
#pragma mark HFCommentLikeViewDelegate
- (void)liveViewHeadAction:(NSInteger)userID
{
    [self jumpPageWithId:userID];
}

- (void)moreUserLikes:(NSArray*)users
{
    if (delegate && [delegate respondsToSelector:@selector(jumpToLikeUsersList:)]) {
        [delegate jumpToLikeUsersList:users];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
