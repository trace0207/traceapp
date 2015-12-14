//
//  HFFeedbackController.h
//  GuanHealth
//
//  Created by hermit on 15/5/25.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"

@interface HFFeedbackController : TKIBaseNavWithDefaultBackVC

@property (nonatomic, strong)          UITextView   *textView;
@property (nonatomic, strong)          UILabel      *placehorderLabel;
@property (nonatomic,   weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView       *buttomView;

@property (nonatomic,   weak) IBOutlet UIView       *line1;
@property (nonatomic,   weak) IBOutlet UIView       *line2;
@property (nonatomic,   weak) IBOutlet UIView       *line3;

@property (nonatomic,   weak) IBOutlet UILabel       *wordsNumLabel;

@property (nonatomic,   weak) IBOutlet UITextField  *phoneTextField;
@property (nonatomic,   weak) IBOutlet UITextField  *emailTextField;

@end
