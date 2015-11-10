//
//  HFCommentInfoView.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HFCommentUsersData;

@protocol HFCommentInfoViewDelegate <NSObject>

- (void)selectCommentInfo:(NSInteger)authorID withNickName:(NSString *)name;

- (void)commentInfoHeadAction:(NSInteger)userID;

@end

@interface HFCommentInfoView : UIView
{
    NSInteger  mAuthorId;
    
    NSString  *mNickName;
}
@property(nonatomic,weak)id<HFCommentInfoViewDelegate>delegate;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, strong) HFCommentUsersData * data;
- (CGFloat)reloadUI:(HFCommentUsersData *)data msgImage:(BOOL)bShow;
- (void)addLongAction:(SEL)selector forTarget:(id)target;
@end
