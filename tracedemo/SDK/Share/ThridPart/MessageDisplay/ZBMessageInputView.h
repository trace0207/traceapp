//
//  ZBMessageInputView.h
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-10.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBMessageTextView.h"

typedef enum
{
  ZBMessageInputViewStyleDefault, // ios7 样式
  ZBMessageInputViewStyleQuasiphysical
} ZBMessageInputViewStyle;

@protocol ZBMessageInputViewDelegate <NSObject>

@required

/**
 *  输入框刚好开始编辑
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewDidBeginEditing:(ZBMessageTextView *)messageInputTextView;

/**
 *  输入框将要开始编辑
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewWillBeginEditing:(ZBMessageTextView *)messageInputTextView;

/**
 *  输入框输入时候
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)inputTextViewDidChange:(ZBMessageTextView *)messageInputTextView;
/**
 * 点击发送按钮的时候
 *
*/
- (void)sendCommentMessage:(ZBMessageTextView *)messageInputTextView;
@optional

/**
 *  点击语音按钮Action
 */
- (void)didChangeSendVoiceAction:(BOOL)changed;

/**
 *  发送文本消息，包括系统的表情
 *
 *  @param messageInputTextView 输入框对象
 */
- (void)didSendTextAction:(ZBMessageTextView *)messageInputTextView;

/**
 *  点击+号按钮Action
 */
- (void)didSelectedMultipleMediaAction:(BOOL)changed;

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction;

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction;

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction;

/**
 *  发送第三方表情
 */
- (void)didSendFaceAction:(BOOL)sendFace;
@end

@interface ZBMessageInputView : UIImageView

@property (nonatomic,weak) id<ZBMessageInputViewDelegate> delegate;

/**
 *  用于输入文本消息的输入框
 */
@property (nonatomic,weak,readonly) ZBMessageTextView *messageInputTextView;

/**
 *  当前输入工具条的样式
 */
@property (nonatomic, assign) ZBMessageInputViewStyle messageInputViewStyle;

/**
 *  切换文本和语音的按钮
 */
@property (nonatomic, weak, readonly) UIButton *voiceChangeButton;

/**
 *  +号按钮
 */
@property (nonatomic, weak, readonly) UIButton *multiMediaSendButton;



/**
 *  语音录制按钮
 */
@property (nonatomic, weak, readonly) UIButton *holdDownButton;

/**
 *  输入框下方的细线
 */
@property (nonatomic, strong) UIView * mInputLine;

/**
 *  发表按钮
 */
@property (nonatomic, strong) UIButton * sendButton;

/**
 *  表情切换按钮
 */
@property (nonatomic, weak, readwrite) UIButton *emotionButton;

- (id)initWithFrame:(CGRect)frame textView:(ZBMessageTextView *)textView;

- (void)changeEmotion;
#pragma end

@end
