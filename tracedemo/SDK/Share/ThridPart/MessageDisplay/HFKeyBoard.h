//
//  HFKeyBoardView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/7/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBMessageTextView.h"

typedef NS_ENUM(NSInteger, EmojiKeyBoardType) {
    HF_KeyBoard_No_TextView = 0,
    HF_KeyBoard_Has_TextView,
};

@protocol HFKeyBoardDelegate <NSObject>

@optional

- (BOOL)checkText:(NSString *)text;

- (void)hf_sendinPutText:(NSString *)text;

- (void)hf_keyBoardReportHeight:(CGFloat)keyboardHeight;

- (void)hf_keyboardDid;

- (NSString *)hf_textViewPlaceholder;

@end


@interface HFKeyBoard : NSObject

@property (nonatomic, weak)id<HFKeyBoardDelegate>delegate;
//默认布局，自动初始化textview
- (instancetype)initWithSuperView:(UIView *)farView;

//外部去初始化textview
- (instancetype)initWithSuperView:(UIView *)farView withTextView:(ZBMessageTextView *)textView;


- (void)giveupFirstResponerWithTextClear:(BOOL)bClear;

- (void)textViewNeedBecomeFirstResponder;

- (ZBMessageTextView *)zbMessageTextView;

- (void)shutDownBtnUserActivity;
- (void)openBtnUserActivity;
- (void)tapBackgroud;
- (void)dismissKeyboard;
@property(nonatomic,strong)UIButton * mFaceSendButton;

@end
