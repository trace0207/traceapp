//
//  TKTextView.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TKTextView;

@protocol TKTextViewDelegate<NSObject>
@optional
- (BOOL)textViewShouldBeginEditing:(TKTextView *)textView;
- (BOOL)textViewShouldEndEditing:(TKTextView *)textView;

- (void)textViewDidBeginEditing:(TKTextView *)textView;
- (void)textViewDidEndEditing:(TKTextView *)textView;

- (BOOL)textView:(TKTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(TKTextView *)textView;

//- (void)textViewDidChangeSelection:(TKTextView *)textView;
//
//- (BOOL)textView:(TKTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
//- (BOOL)textView:(TKTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);

@end

@interface TKTextView : UIView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *placehorderText;
@property (nonatomic, strong) UIFont *placehorderFont;
@property (nonatomic, strong) UIColor *placehorderColor;
@property (nonatomic, strong) UILabel *placehorder;
@property(nonatomic,  copy) NSString *text;
@property (nonatomic, strong) UIFont *textViewFont;
@property (nonatomic, strong) UIColor *textViewColor;

@property (nonatomic, strong) UIColor *borderColor;//边框颜色，默认＃bbbbbb
@property (nonatomic, assign) CGFloat borderWidth;//边框线宽，默认 1px
@property (nonatomic, assign) CGFloat cornerRadius;//边框圆角角度，默认 2px

@property (nonatomic, weak) id<TKTextViewDelegate>delegate;
@property (nonatomic, assign, readonly) BOOL isEditing;
@end
