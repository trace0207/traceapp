//
//  ModifyViewController.m
//  GuanHealth
//
//  Created by hermit on 15/3/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ModifyViewController.h"



@interface ModifyViewController ()<UITextViewDelegate,UITextFieldDelegate>

@end
const NSUInteger wordsNumber = 8;
@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.line.backgroundColor = [UIColor HFColorStyle_5];
    // Do any additional setup after loading the view from its nib.
    [self addRightBarItemWithTitle:_T(@"HF_Common_Finish")];
    UserRes *user = [GlobInfo shareInstance].usr;
    [self addNavigationTitle:@"修改信息"];
    if (self.modyfyType != GZModifyTypeAge) {
        self.birthdayLabel.hidden = YES;
        self.birthdayPicker.hidden = YES;
        [self.infoTextField becomeFirstResponder];
    }else{
        
        [self.birthdayPicker setMaximumDate:[NSDate date]];
        [self.birthdayPicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        NSString *birthday = [[GlobInfo shareInstance].usr getBirthdayStr];
        if (birthday.length == 0) {
            //birthday = @"1990年10月14日";
            [self.birthdayPicker setDate:[NSDate date]];
        }else{
            NSString *dateStr = user.birthday;
            if ([dateStr hasSuffix:@"日"]) {
                dateStr = [dateStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
            }
            NSDate *date = [NSDate getDateFromDateStr:dateStr];
            [self.birthdayPicker setDate:date];
        }
        self.birthdayLabel.text = [NSString stringWithFormat:@"您设置的生日为：%@",birthday];
    }
    
    switch (self.modyfyType) {
        case GZModifyNickname:
            self.infoTextField.text = user.nickName;
            break;
        case GZModifyTypeAge:
            self.infoTextField.hidden = YES;
            self.line.hidden = YES;
            break;
        case GZModifyHeight:
            self.infoTextField.placeholder = @"单位（厘米）";
            self.infoTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.infoTextField.text = [NSString stringWithFormat:@"%0.0f",user.height];
            break;
        default:
            self.infoTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.infoTextField.text = [NSString stringWithFormat:@"%0.0f",user.weight];
            self.infoTextField.placeholder = @"单位（千克）";
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemAction:(id)sender
{
    [MobClick event:User_Modify_Back_Click];
    [super leftBarItemAction:sender];
}

- (void)rightBarItemAction:(id)sender
{
    [MobClick event:User_Modify_Save_Click];
    if (self.modyfyType == GZModifyNickname) {
        NSString *str = [self.infoTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length == 0) {
            [self.infoTextField endEditing:YES];
            WS(weakSelf)
            HFAlertView *atler = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"昵称不能为空！" commpleteBlock:^(NSInteger buttonIndex) {
                [weakSelf.infoTextField becomeFirstResponder];
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [atler show];
            return;
        }else if (self.infoTextField.text.length > 8){
            [self.infoTextField endEditing:YES];
            WS(weakSelf)
            HFAlertView *atler = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"昵称长度不能超过8个字符" commpleteBlock:^(NSInteger buttonIndex) {
                [weakSelf.infoTextField becomeFirstResponder];
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [atler show];
            return;
        }
    }
    
    if (self.modyfyType == GZModifyHeight || self.modyfyType == GZModifyWeight) {
        if (self.infoTextField.text.length == 0) {
            [self.infoTextField endEditing:YES];
            WS(weakSelf)
            HFAlertView *atler = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"信息不能为空！" commpleteBlock:^(NSInteger buttonIndex) {
                [weakSelf.infoTextField becomeFirstResponder];
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [atler show];
            return;
        }
    }
    HFModifyInfoReq *req = [[HFModifyInfoReq alloc]init];
    if (self.modyfyType == GZModifyHeight) {
        [MobClick event:User_Height_Click];
        req.height = [self.infoTextField.text floatValue];
    }
    if (self.modyfyType == GZModifyWeight) {
        [MobClick event:User_Weight_Click];
        req.weight = [self.infoTextField.text floatValue];
    }
    if (self.modyfyType == GZModifyTypeAge) {
        [MobClick event:User_Birthday_Click];
        NSDate *date = self.birthdayPicker.date;
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth;
        NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:date];
        
        req.year = [NSString stringWithFormat:@"%@",@([dateComponent year])];
        req.month = [NSString stringWithFormat:@"%@",@([dateComponent month])];
        req.day = [NSString stringWithFormat:@"%@",@([dateComponent day])];
    }
    if (self.modyfyType == GZModifyNickname) {
        [MobClick event:User_Name_Click];
        req.nickName = self.infoTextField.text;
    }
    WS(weakSelf);
    [[[HIIProxy shareProxy]userProxy]modifyWithInfo:req success:^(BOOL finished) {
        if (finished) {
            [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}

- (IBAction)birthdayValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年M月d日"];
    NSString *dateStr = [formatter stringFromDate:sender.date];
    self.birthdayLabel.text = [NSString stringWithFormat:@"您设置的生日为：%@",dateStr];
}

#pragma text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.modyfyType == GZModifyHeight || self.modyfyType == GZModifyWeight) {
        if (textField.text.length >= 3 && string.length > 0) {
            return NO;
        }
    }
    return YES;
}

@end
