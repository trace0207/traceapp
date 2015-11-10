//
//  HFUnBindingViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFUnBindingViewController.h"
#import "BandCenter.h"
#import "HFDevInfoViewController.h"
#import "GlobNotifyDefine.h"
@interface HFUnBindingViewController ()
@end

@implementation HFUnBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor HFColorStyle_5];
    [self addNavigationTitle:@"解除绑定"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)unbindingAction:(id)sender
{
    //解绑过程中动画
    [self startAnimation];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    WS(weakSelf)
    [[BandCenter shareInstance] disBindBand:^(BOOL success) {
        if (success)
        {
            [MBProgressHUD showSuccess:@"解绑成功" toView:[UIKitTool getAppdelegate].window];
            for (UIViewController * obj in weakSelf.navigationController.viewControllers)
            {
                if ([obj isKindOfClass:[HFDevInfoViewController class]])
                {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:KUnBindBandNotication object:nil];
                    HFDevInfoViewController * devInfo = (HFDevInfoViewController *)obj
                    ;
                    [weakSelf.navigationController popToViewController:devInfo animated:YES];
                    break;
                }
            }
        }
        else{
            [MBProgressHUD showError:@"解绑失败" toView:[UIKitTool getAppdelegate].window];
        }
        [weakSelf stopAnimation];
        [HUD hide:YES];
    }];
    
}

- (IBAction)cancelAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startAnimation
{
    self.runCircleImage.hidden = NO;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.8f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAX_CANON;
    
    [self.runCircleImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimation
{
    [self.runCircleImage.layer removeAnimationForKey:@"rotationAnimation"];
    self.runCircleImage.hidden = YES;
}

@end
