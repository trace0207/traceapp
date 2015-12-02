//
//  TKLoginViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKLoginViewController.h"
#import "TKRegisterViewController.h"
#import "UIViewController+TKNavigationBarSetting.h"
#import "UIColor+TK_Color.h"
#import "TKProxy.h"

@interface TKLoginViewController ()

@end

@implementation TKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self TKsetRightBarItemText:@"注册"
                  withTextColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                      addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];

}

-(NSString *)TK_getBarTitle{

    return @"登录";
}

-(void)TKI_leftBarAction{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)cancelBtn:(id)sender {
    
    
}

- (IBAction)registerBtn:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if(self.delegate){
    
        [self.delegate onRegisterClick];
    }
    
}
- (IBAction)loginBtn:(id)sender {
    
    [[TKProxy proxy].userProxy login:nil withValue:nil withBlock:^(HF_BaseAck * ack){
        
//        HF_BaseAck * loginack = (HF_BaseAck *)ack;
        NSInteger code = [ack recode];
    
        DDLogInfo(@"loginAck code = %ld",code);
    }];
}

- (IBAction)forgetPassword:(id)sender {
}
@end
