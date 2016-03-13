//
//  BaseNavViewController.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/12.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>



@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    _gestureEnable = YES;
//    
//    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
//    gesture.enabled = NO;
//    UIView *gestureView = gesture.view;
//    
//    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
//    popRecognizer.delegate = self;
//    popRecognizer.maximumNumberOfTouches = 1;
//    [gestureView addGestureRecognizer:popRecognizer];
//
//    _navT = [[BaseNavigationInteractiveTransition alloc] initWithViewController:self];
//    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
//    
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
//    /**
//     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
//     */
//    
//    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
//    if (translation.x <= 0)
//    {
//        return NO;
//    }
//
//    if (!_gestureEnable)
//    {
//        return NO;
//    }
//    
//    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
//}




//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    return NO;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
