//
//  TKModifyNameViewController.h
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "TKTextView.h"

typedef NS_ENUM(NSUInteger, ModifyType) {
    ModifyName = 0,
    ModifySignature,
};

@interface TKModifyNameViewController : TKIBaseNavWithDefaultBackVC

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextFeild;
@property (weak, nonatomic) IBOutlet TKTextView *textView;
@property (assign, nonatomic) ModifyType modifyType;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveAction:(id)sender;

@end
