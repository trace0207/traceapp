//
//  HFFeedbackController.m
//  GuanHealth
//
//  Created by hermit on 15/5/25.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFeedbackController.h"

@interface HFFeedbackController ()<UITextViewDelegate,UITextFieldDelegate>
@end

const int wordsNum = 200;

@implementation HFFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationTitle:_T(@"HF_Common_Feedback")];
    [self addRightBarItemWithImageName:@"icon_send"];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(16, 16, kScreenWidth - 32, 250)];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:16.0f];
    self.textView.textColor = [UIColor HFColorStyle_1];
    [self.scrollView addSubview:self.textView];
    
    self.placehorderLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 16+2, 200, 30)];
    self.placehorderLabel.textColor = [UIColor lightGrayColor];
    self.placehorderLabel.text = _T(@"HF_Common_give_Suggest");
    self.placehorderLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.scrollView addSubview:self.placehorderLabel];
    
    self.buttomView.frame = CGRectMake(0, self.textView.frame.origin.y+30, kScreenWidth, self.buttomView.frame.size.height);
    [self.scrollView addSubview:self.buttomView];
    self.phoneTextField.text = [GlobInfo shareInstance].usr.mobile;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidesKeyBoard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)leftBarItemAction:(id)sender
{
    [MobClick event:FeedBack_Back];
    [super leftBarItemAction:sender];
}

- (void)rightBarItemAction:(id)sender
{
    [MobClick event:FeedBack_Send];
    if (self.textView.text.length==0) {
        [self.textView becomeFirstResponder];
        return;
    }else if (self.phoneTextField.text.length != 11){
        [self.phoneTextField becomeFirstResponder];
        return;
    }
    if (self.textView.text.length > wordsNum) {
        [self.textView endEditing:YES];
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"反馈内容不能超过400字！" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        
        return;
    }
    WS(weakSelf)
    HFFeedbackReq *req = [[HFFeedbackReq alloc]init];
    req.source =  1;
    req.suggest = self.textView.text;
    req.telephone = self.phoneTextField.text;
    req.email = self.emailTextField.text;
    [[[HIIProxy shareProxy]commProxy]feedback:req completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)hidesKeyBoard:(UITapGestureRecognizer*)tap
{
    if (self.textView.isFirstResponder) {
        [self.textView endEditing:YES];
    }
    if (self.phoneTextField.isEditing) {
        [self.phoneTextField endEditing:YES];
    }
    if (self.emailTextField.isEditing) {
        [self.emailTextField endEditing:YES];
    }
}

#pragma mark - text view delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>=wordsNum && text.length>0) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placehorderLabel.hidden = NO;
    }else{
        self.placehorderLabel.hidden = YES;
    }
    CGSize size = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(kScreenWidth-32, 300)];
    if (size.height<=30) {
        self.buttomView.frame = CGRectMake(self.buttomView.frame.origin.x, textView.frame.origin.y+30, self.buttomView.frame.size.width, self.buttomView.frame.size.height);
    }else{
        self.buttomView.frame = CGRectMake(self.buttomView.frame.origin.x, textView.frame.origin.y+size.height+10, self.buttomView.frame.size.width, self.buttomView.frame.size.height);
    }
    if (wordsNum-(int)textView.text.length>=0) {
        self.wordsNumLabel.text = [NSString stringWithFormat:@"%i字",wordsNum-(int)textView.text.length];
    }else{
        //self.textView.text = [self.textView.text substringToIndex:wordCount];
        self.wordsNumLabel.text = [NSString stringWithFormat:@"0字"];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.line1.backgroundColor = [UIColor HFColorStyle_5];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.line1.backgroundColor = [UIColor HFColorStyle_5];
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.line2.backgroundColor = [UIColor HFColorStyle_5];
    }else if (textField == self.emailTextField) {
        self.line3.backgroundColor = [UIColor HFColorStyle_5];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.line2.backgroundColor = [UIColor HFColorStyle_1];
    }else if (textField == self.emailTextField) {
        self.line3.backgroundColor = [UIColor HFColorStyle_6];
    }
}

@end
