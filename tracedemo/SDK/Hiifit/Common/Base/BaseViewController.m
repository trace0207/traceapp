//
//  BaseViewController.m
//  rentCar
//
//  Created by duonuo on 14-6-26.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import "BaseViewController.h"
//#import "libFrame.h"

@interface BaseViewController ()

@end

@implementation BaseViewController



- (instancetype)init{
    self = [super init];
//    if (self)
//    {
//        [self reLayout];
//    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        [self reLayout];
//        
//    }
    return self;
}

//- (void)reLayout
//{
//    // 设置  xib 从导航底部开始布局
//    if (IOS7_OR_LATER) {
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.modalPresentationCapturesStatusBarAppearance= NO;
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor HFColorStyle_6];
	// Do any additional setup after loading the view.
    //[[self view] setBackgroundColor:[UIColor whiteColor]];
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count>0) {
            [self addDefaultLeftBarItem];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (self.navigationController) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
