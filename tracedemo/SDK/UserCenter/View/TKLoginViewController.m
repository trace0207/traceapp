//
//  TKLoginViewController.m
//  tracedemo
//
//  Created by cmcc on 15/11/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKLoginViewController.h"
#import "TKRegisterViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)registerBtn:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if(self.delegate){
    
        [self.delegate onRegisterClick];
    }
    
}
- (IBAction)loginBtn:(id)sender {
}

- (IBAction)forgetPassword:(id)sender {
}
@end
