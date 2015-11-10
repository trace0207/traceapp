//
//  MessageFaceView.h
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-12.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBFaceView.h"
#import "ZBMessageTextView.h"

@protocol ZBMessageManagerFaceViewDelegate <NSObject>

- (void)SendTheFaceStr:(NSString *)faceStr isDelete:(BOOL)dele;
- (void)deleteTheFaceStr;

@end

@interface ZBMessageManagerFaceView : UIView<UIScrollViewDelegate,ZBFaceViewDelegate>

@property (nonatomic,weak)id<ZBMessageManagerFaceViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame textView:(ZBMessageTextView *)textView;
- (void)setup;

@end
