//
//  TKEditTextViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 16/1/5.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKEditTextViewController.h"

@interface TKEditTextViewController ()

@end

@implementation TKEditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.inPutType) {
        case 0:
//            self.navTitle = @"性别";
            break;
            
        default:
            break;
    }
    
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

@end
