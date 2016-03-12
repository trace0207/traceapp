//
//  TKNotifycationViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/11.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKNotifycationViewController.h"

@interface TKNotifycationViewController ()

@end

@implementation TKNotifycationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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


+(void)showNotifyCation:(NSString *)text
{
    TKNotifycationViewController * vc = [[TKNotifycationViewController alloc] init];
    vc.textView.text = text;
    UIViewController *rootVC = [TKNotifycationViewController appRootViewController];
    
    
//    [[TKNotifycationViewController appRootViewController] presentViewController:vc animated:YES completion:^{
//        
//    } ];
    UIView * showContentView = vc.view;
//    showContentView.backgroundColor = [UIColor blackColor];
    [rootVC.view addSubview:showContentView];
//    centerX = Point.x - DefaultMenuWidth/2;
//    centerY = Point.y + DefaultMenuHeight/2;
//    contentView.center = CGPointMake(centerX,centerY);
//    eventResponseAreaView.center = contentView.center;
//    isShow = true;
    showContentView.frame = CGRectMake(-40, 0, TKScreenWidth, TKScreenHeight);
//    showContentView.center = CGPointMake(DefaultMenuWidth*3/2,DefaultMenuHeight/2);
    [UIView animateWithDuration:0.3f animations:^{
        showContentView.frame = CGRectMake(0, 0, TKScreenWidth, TKScreenHeight);
    } completion:^(BOOL finished) {
    }];
}


+(UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}
@end
