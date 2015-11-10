//
//  ModifySignatureController.m
//  GuanHealth
//
//  Created by hermit on 15/5/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ModifySignatureController.h"
#import "HFModifySignatureReq.h"
const int wordCount = 40;
@interface ModifySignatureController ()<UITextViewDelegate>

@end

@implementation ModifySignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addRightBarItemWithTitle:_T(@"HF_Common_Finish")];
    [self addNavigationTitle:@"个性签名"];

    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14.0f];
    self.textView.textColor = [UIColor HFColorStyle_1];
    self.placehorderLabel.userInteractionEnabled = NO;
    
    NSString *signature = [GlobInfo shareInstance].usr.signature;
    if (signature.length > 0) {
        self.textView.text = signature;
        self.placehorderLabel.hidden = YES;
    }
    

    self.wordsNumLabel.text = [NSString stringWithFormat:@"还能输入%lu个字",wordCount - signature.length];
    self.wordsNumLabel.textColor = [UIColor HFColorStyle_2];
    
    
    //[self updateFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarItemAction:(id)sender
{
    [self.textView endEditing:YES];
    if ([self.textView.text isEqualToString:[GlobInfo shareInstance].usr.signature]){
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.textView.text.length>40){
        WS(weakSelf)
        HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"签名长度不能超过40个字符串！" commpleteBlock:^(NSInteger buttonIndex) {
            [weakSelf.textView becomeFirstResponder];
        } cancelTitle:nil determineTitle:@"确定"];
        [alter show];
        return;
    }else{
        HFModifySignatureReq *req = [[HFModifySignatureReq alloc]init];
        req.signature = self.textView.text;
        WS(weakSelf)
        [[[HIIProxy shareProxy]userProxy]modifyWithInfo:req success:^(BOOL finished) {
            if (finished) {
                [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(finishModify)]) {
                        [weakSelf.delegate finishModify];
                    }
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }
}

#pragma mark - text view delegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placehorderLabel.hidden = NO;
    }else{
        self.placehorderLabel.hidden = YES;
    }
        if (wordCount-(int)self.textView.text.length>=0) {
            self.wordsNumLabel.text = [NSString stringWithFormat:@"还能输入%i个字",wordCount-(int)self.textView.text.length];
        }else{
            self.wordsNumLabel.text = [NSString stringWithFormat:@"还能输入0个字"];
        }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>=wordCount && text.length>0) {
        return NO;
    }
    return YES;
}

@end
