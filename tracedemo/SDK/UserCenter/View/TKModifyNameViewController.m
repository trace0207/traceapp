//
//  TKModifyNameViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKModifyNameViewController.h"
#import "UIView+Border.h"
#import "UIColor+TK_Color.h"
@interface TKModifyNameViewController ()

@end

@implementation TKModifyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    if (self.modifyType  == ModifyName) {
        self.textView.hidden = YES;
    }else if (self.modifyType  == ModifySignature) {
        self.nickNameTextFeild.hidden = YES;
        [self.textView setDefaultBorder];
        self.textView.placehorderText = @"请输入个性签名";
    }
    [self.saveButton setDefaultBorder];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    //保存
    [self.textView resignFirstResponder];
    [self.nickNameTextFeild resignFirstResponder];
}
@end
