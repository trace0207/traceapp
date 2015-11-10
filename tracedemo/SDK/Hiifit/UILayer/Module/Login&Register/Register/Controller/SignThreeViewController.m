//
//  SignThreeViewController.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SignThreeViewController.h"
#import "WebViewController.h"

@interface SignThreeViewController ()

@end

@implementation SignThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavigationTitle:@"修改性别"];
    [self addRightBarItemWithTitle:_T(@"HF_Common_Finish")];
    
    UIImage *image = [[UIImage imageNamed:@"bg_login"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.boyBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.girlBtn setBackgroundImage:image forState:UIControlStateNormal];
    if ([GlobInfo shareInstance].usr.sex) {
        sex = 1;
        self.boyImage.highlighted = NO;
        self.girlImage.highlighted = YES;
    }else{
        sex = 0;
        self.boyImage.highlighted = YES;
        self.girlImage.highlighted = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarItemAction:(id)sender
{
    HFModifyInfoReq *req = [[HFModifyInfoReq alloc]init];
    req.sex = sex;
    WS(weakSelf)
    [[[HIIProxy shareProxy]userProxy]modifyWithInfo:req success:^(BOOL finished) {
        if (finished) {
            [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}

- (IBAction)chooseBoyAction:(id)sender
{
    self.boyImage.highlighted = YES;
    self.girlImage.highlighted = NO;
    sex = 0;
}

- (IBAction)chooseGirlAction:(id)sender
{
    self.boyImage.highlighted = NO;
    self.girlImage.highlighted = YES;
    sex = 1;
}

@end
