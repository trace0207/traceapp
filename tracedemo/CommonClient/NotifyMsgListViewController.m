//
//  NotifyMsgListViewController.m
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "NotifyMsgListViewController.h"

@interface NotifyMsgListViewController ()

@end

@implementation NotifyMsgListViewController


+(void)showBoxList:(NSInteger)boxType
{
    NotifyMsgListViewController * vc = [[NotifyMsgListViewController alloc] init];
    vc.vm.boxId = boxType;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.vm.pullRefreshView];
    [self.vm tkLoadDefaultData];
    [self.vm tkUpdateViewConstraint];
    
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


-(NotifyMsgListVM *)vm
{
    if(!_vm)
    {
        _vm = [[NotifyMsgListVM alloc] initWithFreshAbleTable];
    }
    return _vm;
}

@end
