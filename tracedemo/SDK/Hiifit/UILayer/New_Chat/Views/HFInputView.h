//
//  HFInputView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/7/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBMessageTextView;

@protocol HFInputViewDelegate <NSObject>

- (void)sendAction;

@end

@interface HFInputView : UIView

@property(nonatomic,strong)UIButton * mSendBtn;

@property(nonatomic,weak)id<HFInputViewDelegate>delegate;
@property(nonatomic,strong)ZBMessageTextView * mTextView;

- (void)resetFrame;

- (void)clearTextView;

- (void)TextViewBecomeFirstResponder;

- (void)initPlaceholder:(NSString *)placerholder;
@end
