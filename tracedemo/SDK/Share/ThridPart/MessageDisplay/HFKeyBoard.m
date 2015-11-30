//
//  HFKeyBoardView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/7/17.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFKeyBoard.h"
#import "ZBMessageManagerFaceView.h"
#import "HFInputView.h"
@interface HFKeyBoard()<HFInputViewDelegate,ZBMessageManagerFaceViewDelegate>
{
    EmojiKeyBoardType mType;
    
    BOOL bEmojiShow;
    
    NSInteger location;
}
@property(nonatomic,strong)HFInputView  * mInPutView;
@property(nonatomic,strong)ZBMessageTextView * mTextView;
@property(nonatomic,strong)ZBMessageManagerFaceView * mEmojiView;
@property(nonatomic,strong)UIView * mFartherView;
@property(nonatomic,strong)UIView * mBgView;
@property (nonatomic, strong) UIImageView * bgImageView;
@property(nonatomic,strong)NSDictionary * faceMap;
@end


static NSInteger  faceTabHeight = 45;// 表情键盘高度
static NSInteger  faceIconXY = 25; //  键盘的 icon


@implementation HFKeyBoard

- (instancetype)initWithSuperView:(UIView *)farView{
    self = [super init];
    
    if (self)
    {   
        self.mFartherView = farView;
        [self addObserver];
        [self resetFrame];
        
        //初始化其他需要的控件
        self.mInPutView.frame = CGRectMake(60, 0, kScreenWidth - 80, 62);
        [self.mInPutView resetFrame];
        [self.mBgView addSubview:self.mInPutView];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)farView withTextView:(ZBMessageTextView *)textView
{
    self = [super init];
    if (self)
    {
        mType = HF_KeyBoard_Has_TextView;
        self.mTextView = textView;
//        self.mTextView.delegate = self;
        [self.mTextView setUp];
        self.mFartherView = farView;
        [self addObserver];
        [self resetFrame];
    }
    return self;
}

- (void)resetFrame
{
    if (self.mTextView) {
        self.mBgView.frame = CGRectMake(0, self.mFartherView.frame.size.height, kScreenWidth, faceTabHeight);
    }else{
        self.mBgView.frame = CGRectMake(0, self.mFartherView.frame.size.height - faceTabHeight, kScreenWidth, faceTabHeight);
    }
    
    self.bgImageView.frame = CGRectMake(0, 0, self.mBgView.frame.size.width, self.mBgView.frame.size.height);
    self.mBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.mFartherView addSubview:self.mBgView];
    
    self.mFaceSendButton.frame = CGRectMake(10, 10, faceIconXY, faceIconXY);
    [self.mBgView addSubview:self.mFaceSendButton];
    self.mEmojiView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 196);
    [self.mFartherView addSubview:self.mEmojiView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroud)];
    [self.mFartherView addGestureRecognizer:tapGesture];
}

#pragma mark -
#pragma mark Notication
- (void)keyboardWillShow:(NSNotification *)notication
{
    if (!bEmojiShow)
    {
        //进行盘的初始化工作
        [self.mFartherView bringSubviewToFront:self.mBgView];
        [self.mFartherView bringSubviewToFront:self.mEmojiView];
        
    }
    
    //计算键盘的高度
    CGRect rect = [[notication.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //进行self 的frame的修改
    
    if (rect.origin.y < kScreenHeight)
    {
        bEmojiShow = YES;
        
        if (self.mFaceSendButton.selected)
        {
            self.mFaceSendButton.selected = !self.mFaceSendButton.isSelected;
        }
        
        [self showEmojiViewFrame:rect.size.height];
        if (_delegate && [_delegate respondsToSelector:@selector(hf_keyBoardReportHeight:)]) {
            
            [_delegate hf_keyBoardReportHeight:rect.size.height + self.mBgView.frame.size.height];
        }
    }
    
}

- (void)keyboardWillHide
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(hf_keyBoardReportHeight:)]) {
        //计算键盘的高度
        if (!self.mFaceSendButton.selected)
        {
            [_delegate hf_keyBoardReportHeight:0.0];
        }
        else
        {
            [_delegate hf_keyBoardReportHeight:self.mEmojiView.frame.size.height];
        }
        
    }
    
    if (!self.mFaceSendButton.selected)
    {
        [self dismissEmojiKeyBoard];
    }
    else
    {
        CGFloat orignY = self.mFartherView.frame.size.height - self.mEmojiView.frame.size.height - self.mBgView.frame.size.height;
        [self animationToOrignY:orignY];
    }
}

#pragma mark -
#pragma mark public
- (ZBMessageTextView *)zbMessageTextView
{
    return [self findTextViewFromType];
}

- (void)giveupFirstResponerWithTextClear:(BOOL)bClear
{
    ZBMessageTextView * text = [self findTextViewFromType];
    [text resignFirstResponder];
    
    if (self.mFaceSendButton.isSelected)
    {
        [self changeFaceBoardWhenBackgroundClick];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(hf_textViewPlaceholder)])
    {
        text.placeHolder = [_delegate hf_textViewPlaceholder];
    }
    else
    {
        if (bClear)
        {
            [self.mInPutView clearTextView];
        }
    }
}
- (void)changeFaceBoardWhenBackgroundClick
{
    self.mFaceSendButton.selected = !self.mFaceSendButton.isSelected;
    CGFloat originY;
    if (self.mTextView)
    {
        originY = self.mFartherView.frame.size.height;
        [self dismissEmojiViewFrame:originY];
    }
    else
    {
        originY = self.mFartherView.frame.size.height - 62;
        [self dismissEmojiViewFrame:originY];
    }
}
#pragma mark -
#pragma mark private
- (void)clickEmpty
{
    
}
- (void)tapBackgroud
{
    bEmojiShow = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hf_keyBoardReportHeight:)]) {
        [self.delegate hf_keyBoardReportHeight:0.0];
    }
    [self giveupFirstResponerWithTextClear:NO];
}
- (void)shutDownBtnUserActivity
{
    self.mInPutView.mSendBtn.userInteractionEnabled = NO;
}
- (void)openBtnUserActivity
{
    self.mInPutView.mSendBtn.userInteractionEnabled = YES;
}
- (void)dismissKeyboard
{
    self.mBgView.hidden = YES;
}
- (void)showEmojiViewFrame:(CGFloat)height
{
    
    CGRect rect = self.mEmojiView.frame;
    rect.origin.y = self.mFartherView.frame.size.height - rect.size.height;
    self.mEmojiView.frame = rect;
    
    
    CGFloat orignY = self.mFartherView.frame.size.height - height - self.mBgView.frame.size.height;
    [self animationToOrignY:orignY];
}
- (void)dismissEmojiViewFrame:(CGFloat)originY
{
    [UIView animateWithDuration:0.2 animations:^{
        self.mBgView.frame = CGRectMake(0, originY, kScreenWidth, 62);
        self.mEmojiView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 196);
    }];
}
- (void)animationToOrignY:(CGFloat)orignY
{
    [UIView animateWithDuration:0.2 animations:^{
        self.mBgView.frame = CGRectMake(0, orignY, self.mBgView.frame.size.width, self.mBgView.frame.size.height);
    }];
}


- (void)addObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardDidChangeFrameNotification
                                              object:nil];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


- (ZBMessageTextView *)findTextViewFromType
{
    ZBMessageTextView * textView;
    if (self.mTextView)
    {
        textView = self.mTextView;
    }
    else
    {
        if (self.mInPutView)
        {
            textView = self.mInPutView.mTextView;
        }
    }
    
    if (!textView)
    {
        DDLogDebug(@"没有任何textview的信息！警告！");
    }
    
    return textView;
}

- (NSDictionary *)getEmojiData
{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"]];
}

- (BOOL)isExpression:(NSString *)string
{
    NSArray * expressionArray = [_faceMap allKeys];
    for (NSString * expressionString in expressionArray) {
        if ([expressionString isEqualToString:string]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)changeEmoji
{
    self.mFaceSendButton.selected = !self.mFaceSendButton.isSelected;
    
    ZBMessageTextView * textView = [self findTextViewFromType];
    
    if (self.mFaceSendButton.selected)
    {
        if (!bEmojiShow)
        {
            [self showEmojiViewFrame:self.mEmojiView.frame.size.height];
        }
        
        [textView resignFirstResponder];
    }
    else
    {
        [textView becomeFirstResponder];
    }

}



- (void)dismissEmojiKeyBoard
{
    bEmojiShow = NO;

    self.mEmojiView.frame = CGRectMake(0, self.mFartherView.frame.size.height, self.mEmojiView.frame.size.width, self.mEmojiView.frame.size.height);
    
    if (mType == HF_KeyBoard_Has_TextView) {
        [self animationToOrignY:self.mFartherView.frame.size.height];

    }else{
        [self animationToOrignY:self.mFartherView.frame.size.height - self.mBgView.frame.size.height];
    }
}

- (UIButton *)mFaceSendButton
{
    if (!_mFaceSendButton)
    {
        _mFaceSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mFaceSendButton addTarget:self action:@selector(changeEmoji) forControlEvents:UIControlEventTouchUpInside];
        _mFaceSendButton.selected = NO;
        [_mFaceSendButton setBackgroundImage:IMG(@"smile1") forState:UIControlStateNormal];
        [_mFaceSendButton setBackgroundImage:IMG(@"smileClick") forState:UIControlStateSelected];
    }
    return _mFaceSendButton;
}

#pragma mark -
#pragma mark HFInputViewDelegate
- (void)sendAction
{
    [self shutDownBtnUserActivity];
    [self tapBackgroud];
    //发送通知
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkText:)] && [self.delegate respondsToSelector:@selector(hf_sendinPutText:)]) {
        if ([self.delegate checkText:self.mInPutView.mTextView.text]) {
            [self.delegate hf_sendinPutText:self.mInPutView.mTextView.text];
        }
    }
}


#pragma mark - ZBMessageFaceViewDelegate
- (void)SendTheFaceStr:(NSString *)faceStr isDelete:(BOOL)dele
{
    ZBMessageTextView * textView = [self findTextViewFromType];
    NSString * afterString = [textView.text substringFromIndex:textView.selectedRange.location];
    NSString * formerString = [textView.text substringToIndex:textView.selectedRange.location];
    NSString * nowString = [formerString stringByAppendingString:faceStr];
    textView.text = [nowString stringByAppendingString:afterString];
    textView.selectedRange = NSMakeRange([formerString length] + [faceStr length], 0);
    self.mInPutView.mSendBtn.userInteractionEnabled = YES;
    self.mInPutView.mSendBtn.backgroundColor = [UIColor HFColorStyle_5];
    [textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height - 20, textView.contentSize.width, 20) animated:NO];
}

- (void)deleteTheFaceStr
{
    ZBMessageTextView * textView = [self findTextViewFromType];
    
    NSString *inputString = [textView.text substringToIndex:textView.selectedRange.location];
    NSString * afterString = [textView.text substringFromIndex:textView.selectedRange.location];
    _faceMap = [self getEmojiData];
    NSString * subString = @"";
    NSInteger inputStringLength = inputString.length;
    if (inputStringLength > 5) {
        subString = [inputString substringFromIndex:inputStringLength - 1];
        if ([subString isEqualToString:@"]"]) {
            NSString * threeWordSubString = [inputString substringFromIndex:inputString.length - 3];
            NSString * fourWordSubString = [inputString substringFromIndex:inputString.length - 4];
            NSString * fiveWordSubString = [inputString substringFromIndex:inputString.length - 5];
            if ([[threeWordSubString substringToIndex:1] isEqualToString:@"["]) {
                if ([self isExpression:threeWordSubString]) {
                    inputString = [inputString substringToIndex:inputString.length - 3];
                }else{
                    inputString = [inputString substringToIndex:inputString.length - 1];
                }
            }else if ([[fourWordSubString substringToIndex:1] isEqualToString:@"["]) {
                if ([self isExpression:fourWordSubString]) {
                    inputString = [inputString substringToIndex:inputString.length - 4];
                }else{
                    inputString = [inputString substringToIndex:inputString.length - 1];
                }
            }else if ([[fiveWordSubString substringToIndex:1] isEqualToString:@"["]) {
                if ([self isExpression:fiveWordSubString]) {
                    inputString = [inputString substringToIndex:inputString.length - 5];
                }else{
                    inputString = [inputString substringToIndex:inputString.length - 1];
                }
            }
        }else{
            inputString = [inputString substringToIndex:inputString.length - 1];
        }
    }else if(inputString.length < 3 && inputString.length != 0){
        inputString = [inputString substringToIndex:inputString.length - 1];
    }else if (inputString.length == 3){
        BOOL isEmoji = NO;
        for (NSString * str in [_faceMap allKeys]) {
            if ([str isEqualToString:inputString]) {
                isEmoji = YES;
            }
        }
        if (isEmoji) {
            inputString = @"";
        }else{
             inputString = [inputString substringToIndex:inputString.length - 1];
        }
    }else if (inputString.length == 4){
        if ([[inputString substringFromIndex:3] isEqualToString:@"]"]) {
            if ([self isExpression:inputString]) {
                inputString = @"";
            }else if ([self isExpression:[inputString substringFromIndex:1]]){
                inputString = [inputString substringToIndex:1];
            }else{
                inputString = [inputString substringToIndex:3];
            }
        }else{
            inputString = [inputString substringToIndex:3];
        }
    }else if (inputString.length == 5){
        if ([[inputString substringFromIndex:3] isEqualToString:@"]"]) {
            if ([self isExpression:inputString]) {
                inputString = @"";
             }else if ([self isExpression:[inputString substringFromIndex:1]]){
                inputString = [inputString substringToIndex:1];
            }else if ([self isExpression:[inputString substringFromIndex:2]]){
                inputString = [inputString substringToIndex:2];
            }
        }else{
            inputString = [inputString substringToIndex:4];
        }
    }
    if (inputString.length == 0) {

    }
    textView.text = [inputString stringByAppendingString:afterString];
    [self checkTextViewLength:textView.text];
    textView.selectedRange = NSMakeRange([inputString length], 0);
}
- (void)checkTextViewLength:(NSString *)text
{
    if (text.length == 0) {
        self.mInPutView.mSendBtn.backgroundColor = [UIColor hexChangeFloat:@"CCCCCC" withAlpha:1.0];
        self.mInPutView.mSendBtn.userInteractionEnabled = NO;
    }
}
#pragma mark -
#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.mBgView.hidden = NO;
}
#pragma mark -
#pragma mark Lazy Init

- (ZBMessageManagerFaceView *)mEmojiView
{
    if (!_mEmojiView)
    {
        _mEmojiView = [[ZBMessageManagerFaceView alloc] init];
        _mEmojiView.delegate = self;
        [_mEmojiView setup];
    }
    return _mEmojiView;
}

- (UIView * )mBgView
{
    if (!_mBgView)
    {
        _mBgView = [[UIView alloc] init];
        //_mBgView.backgroundColor = [UIColor hexChangeFloat:kColorWhite withAlpha:1.0];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty)];
        [_mBgView addGestureRecognizer:tapGesture];
    }
    return _mBgView;
}

- (HFInputView * )mInPutView
{
    if (!_mInPutView)
    {
        _mInPutView = [[HFInputView alloc] init];
        _mInPutView.delegate  = self;
    }
    return _mInPutView;
}
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = IMG(@"commentAlphaBg.png");
        [self.mBgView addSubview:_bgImageView];
    }
    return _bgImageView;
}
- (void)textViewNeedBecomeFirstResponder
{
    [self.mInPutView TextViewBecomeFirstResponder];
}
- (void)dealloc
{
    [self removeObserver];
}

@end
