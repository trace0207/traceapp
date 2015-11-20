//
//  TKRegisterViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKRegisterViewController.h"
#import  "UIViewController+TKNavigationBarSetting.h"
#import "UIColor+TK_Color.h"
#import "TKSetPasswordViewController.h"
#import "TKUserCenter.h"

@interface TKRegisterViewController ()

@end

@implementation TKRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)TK_getBarTitle{

    return @"注册";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)cancelEvent{
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

- (IBAction)cancelBtn:(id)sender {
    [self TKI_leftBarAction];
}

- (IBAction)countrySelectBtn:(id)sender {
}

- (IBAction)nextStepBtn:(id)sender {
    
    
    
    NSString * phone = _phoneNumberInputText.text;
    [TKUserCenter instance].tempUserData.mobile = phone;
    TKSetPasswordViewController * passwordVC = [[TKSetPasswordViewController alloc] initWithNibName:@"TKSetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:passwordVC animated:YES];
    
}

- (IBAction)userProtocolBtn:(id)sender {
}
@end
