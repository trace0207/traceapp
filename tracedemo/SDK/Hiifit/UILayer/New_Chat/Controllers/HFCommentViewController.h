//
//  HFCommentViewController.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "PostDetailRes.h"
#import "BaseViewController.h"


@protocol HFCommentViewControllerDelegate <NSObject>
@optional
- (void)updatePostData:(PostDetailData *)data;

@end

@interface HFCommentViewController : BaseViewController<UITextViewDelegate>
{
    NSInteger  mWbType;
    
    NSInteger  mWbID;
    
    PostDetailData * mDetailData;
}
@property(nonatomic)NSInteger mWbType;
@property(nonatomic)NSInteger mWbID;
@property(nonatomic,strong)PostDetailData * mDetailData;
@property(nonatomic,weak)id<HFCommentViewControllerDelegate>delegate;
@property (nonatomic, assign) BOOL bIsPostBar;


@end
