//
//  FaceBoard.m
//
//  Created by blue on 12-9-26.
//  Copyright (c) 2012年 blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood

#import "FaceBoard.h"


#define FACE_COUNT_ALL  100

#define FACE_COUNT_ROW  3

#define FACE_COUNT_CLU  7

#define FACE_COUNT_PAGE ( FACE_COUNT_ROW * FACE_COUNT_CLU )

#define FACE_ICON_SIZE  35


@implementation FaceBoard

@synthesize delegate;

@synthesize inputTextField = _inputTextField;
@synthesize inputTextView = _inputTextView;

- (id)init {

    self = [super initWithFrame:CGRectMake(0, 0, 320, 216)];
    if (self) {

        //self.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
        self.backgroundColor = [UIColor whiteColor];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        if ([[languages objectAtIndex:0] hasPrefix:@"zh"]) {

            _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                         [[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"]] ;
        }
        else {

            _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                         [[NSBundle mainBundle] pathForResource:@"expression"
                                                         ofType:@"plist"]];
        }
       
        [[NSUserDefaults standardUserDefaults] setObject:_faceMap forKey:@"expression_dic"];
        //表情盘
        faceView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 190)];
        faceView.pagingEnabled = YES;
        faceView.contentSize = CGSizeMake((FACE_COUNT_ALL / FACE_COUNT_PAGE + 1) * CGRectGetWidth([UIScreen mainScreen].bounds), 190);
        faceView.showsHorizontalScrollIndicator = NO;
        faceView.showsVerticalScrollIndicator = NO;
        faceView.delegate = self;
        
        int j = 0, k = 1;
        for (int i = 1, l = 1; i <= FACE_COUNT_ALL + 4; i++,k++) {
            j++;
            if (j > 7) {
                j = 0;
            }
            FaceButton *faceButton = [FaceButton buttonWithType:UIButtonTypeCustom];
            if (i % 21 == 0 && i != 1) {
                l--;
            }
            faceButton.buttonIndex = l;
            l++;
            [faceButton addTarget:self
                           action:@selector(faceButton:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            //计算每一个表情按钮的坐标和在哪一屏
            CGFloat x = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * CGRectGetWidth([UIScreen mainScreen].bounds) / FACE_COUNT_CLU + 6 + ((i - 1) / FACE_COUNT_PAGE * CGRectGetWidth([UIScreen mainScreen].bounds));
            CGFloat y = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * CGRectGetWidth([UIScreen mainScreen].bounds) / FACE_COUNT_CLU + 8;
            
            faceButton.frame = CGRectMake( x, y, FACE_ICON_SIZE, FACE_ICON_SIZE);
            
            //faceButton.backgroundColor = [UIColor grayColor];
            faceButton.layer.cornerRadius = faceButton.frame.size.height / 2;
            [faceButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"emoji_%d.png", k]] forState:UIControlStateNormal];
            
            [faceView addSubview:faceButton];
            if (k % (FACE_COUNT_PAGE - 1) == 0) {
                i++;
                CGFloat xdel = (((i - 1) % FACE_COUNT_PAGE) % FACE_COUNT_CLU) * CGRectGetWidth([UIScreen mainScreen].bounds) / FACE_COUNT_CLU + 6 + ((i - 1) / FACE_COUNT_PAGE * CGRectGetWidth([UIScreen mainScreen].bounds));
                CGFloat ydel = (((i - 1) % FACE_COUNT_PAGE) / FACE_COUNT_CLU) * CGRectGetWidth([UIScreen mainScreen].bounds) / FACE_COUNT_CLU + 8;
                //删除键
                UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
                [back setTitle:@"删除" forState:UIControlStateNormal];
                [back setTitle:@"删除" forState:UIControlStateNormal];
                [back setBackgroundImage:[UIImage imageNamed:@"icon_emotion_del"] forState:UIControlStateNormal];
                [back addTarget:self action:@selector(backFace) forControlEvents:UIControlEventTouchUpInside];
                back.frame = CGRectMake(xdel, ydel + 2, 30, 26);
                [faceView addSubview:back];
            }
        }
        
        //添加PageControl
        facePageControl = [[GrayPageControl alloc]initWithFrame:CGRectMake(110, 170, 100, 40)];
        [facePageControl addTarget:self
                            action:@selector(pageChange:)
                  forControlEvents:UIControlEventValueChanged];
        facePageControl.numberOfPages = 5;
        facePageControl.currentPage = 0;
        [self addSubview:facePageControl];
        
        //添加键盘View
        [self addSubview:faceView];
    }
    return self;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length >= 400 && text.length > 0) {
        return NO;
    }
    return YES;
}
//停止滚动的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [facePageControl setCurrentPage:faceView.contentOffset.x / 320];
    [facePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender {

    [faceView setContentOffset:CGPointMake(facePageControl.currentPage * 320, 0) animated:YES];
    [facePageControl setCurrentPage:facePageControl.currentPage];
}

- (void)faceButton:(id)sender {

    FaceButton * button = sender;
    NSInteger i = button.buttonIndex;
    if (self.inputTextField) {
        NSMutableString *faceString = [[NSMutableString alloc]initWithString:self.inputTextField.text];
        NSString * emojiString = [NSString stringWithFormat:@"emoji_%d", i];
        for (int i = 0; i < [[_faceMap allValues] count]; i++) {
            if ([emojiString isEqualToString:[[_faceMap allValues] objectAtIndex:i]]) {
                [faceString appendString:[[_faceMap allKeys] objectAtIndex:i]];
                break;
            }
        }
        //[faceString appendString:[_faceMap objectForKey:[NSString stringWithFormat:@"emoji_%ld", i]]];
            self.inputTextField.text = faceString;
    }
    if (self.inputTextView) {
        self.inputTextView.delegate = self;
        NSMutableString *faceString = [[NSMutableString alloc]initWithString:self.inputTextView.text];
        NSString * emojiString = [NSString stringWithFormat:@"emoji_%d", i];
        for (int i = 0; i < [[_faceMap allValues] count]; i++) {
            if ([emojiString isEqualToString:[[_faceMap allValues] objectAtIndex:i]]) {
                [faceString appendString:[[_faceMap allKeys] objectAtIndex:i]];
                break;
            }
        }
        if (faceString.length > 400) {
            [delegate textViewDidChange:self.inputTextView];
        }else{
            self.inputTextView.text = faceString;
            [delegate textViewDidChange:self.inputTextView];
        }
    }
}

- (void)backFace{

    NSString *inputString = self.inputTextField.text;
    if ( self.inputTextView ) {

        inputString = self.inputTextView.text;
    }
    
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
                            self.inputTextView.text = [inputString substringToIndex:inputString.length - 3];
                        }else{
                            self.inputTextView.text = [inputString substringToIndex:inputString.length - 1];
                        }
                    }else if ([[fourWordSubString substringToIndex:1] isEqualToString:@"["]) {
                        if ([self isExpression:fourWordSubString]) {
                            self.inputTextView.text = [inputString substringToIndex:inputString.length - 4];
                        }else{
                            self.inputTextView.text = [inputString substringToIndex:inputString.length - 1];
                        }
                    }else if ([[fiveWordSubString substringToIndex:1] isEqualToString:@"["]) {
                        if ([self isExpression:fiveWordSubString]) {
                            self.inputTextView.text = [inputString substringToIndex:inputString.length - 5];
                        }else{
                            self.inputTextView.text = [inputString substringToIndex:inputString.length - 1];
                        }
                    }
            }else{
                self.inputTextView.text = [inputString substringToIndex:inputString.length - 1];
            }
        }else if(inputString.length < 3 && inputString.length != 0){
            self.inputTextView.text = [inputString substringToIndex:inputString.length - 1];
        }else if (inputString.length == 3){
            //NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"FaceMap"];
            for (NSString * str in [_faceMap allKeys]) {
                if ([str isEqualToString:inputString]) {
                    self.inputTextView.text = @"";
                    return;
                }else{
                    self.inputTextView.text = [inputString substringToIndex:inputString.length - 1];
                }
            }
        }else if (inputString.length == 4){
            if ([[inputString substringFromIndex:3] isEqualToString:@"]"]) {
                if ([self isExpression:inputString]) {
                    self.inputTextView.text = @"";
                }else if ([self isExpression:[inputString substringFromIndex:1]]){
                    self.inputTextView.text = [inputString substringToIndex:1];
                }else{
                    self.inputTextView.text = [inputString substringToIndex:3];
                }
            }else{
                self.inputTextView.text = [inputString substringToIndex:3];
            }
        }else if (inputString.length == 5){
            if ([[inputString substringFromIndex:3] isEqualToString:@"]"]) {
                if ([self isExpression:inputString]) {
                    self.inputTextView.text = @"";
                }else if ([self isExpression:[inputString substringFromIndex:1]]){
                    self.inputTextView.text = [inputString substringToIndex:1];
                }else if ([self isExpression:[inputString substringFromIndex:2]]){
                    self.inputTextView.text = [inputString substringToIndex:2];
                }
            }else{
                self.inputTextView.text = [inputString substringToIndex:4];
            }
        }
    if (inputString.length == 0) {
        
    }
    [delegate textViewDidChange:self.inputTextView];
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

@end
