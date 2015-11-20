//
//  TK_BaseNavSettingViewController.m
//  tracedemo
//  全局的 navigation设置 ， 需要设置 navigation的 VC ，都在这里配
//  Created by 罗田佳 on 15/11/20.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_BaseNavSettingViewController.h"
#import "UIColor+TK_Color.h"

@interface TK_BaseNavSettingViewController ()

@end

@implementation TK_BaseNavSettingViewController

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
    [self TKremoveLeftBarButtonItem];
    [self TKremoveNavigationTitle];
    [self TKremoveRightBarButtonItem];
}



-(void)TKI_setBarDefaultLeftBack{
    
    [self TKsetMultipleLeftBarItem:IMG(@"icon_back")
                   withDescription:@"返回"
                      discripColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                         addTarget:self
                            action:@selector(TKI_leftBarAction)
                  forControlEvents:UIControlEventTouchUpInside];

}
-(void)TKI_setBarDefaultTitle:(NSString *) title{
    [self TKaddNavigationTitle:title];

}
-(void)TKI_setBarActiveLeftText:(NSString *)text{
    
    [self TKsetLeftBarItemText:text
                 withTextColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                     addTarget:self
                        action:@selector(TKI_leftBarAction)
              forControlEvents:UIControlEventTouchUpInside];
}


-(void)TKI_setBarRightDefaultText:(NSString *)text{

    [self TKsetRightBarItemText:text
                  withTextColor:[UIColor TKcolorWithHexString:TK_Color_nav_textDefault]
                      addTarget:self
                         action:@selector(TKI_rightBarAction)
               forControlEvents:UIControlEventTouchUpInside];
}


-(void)TKI_leftBarAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)TKI_rightBarAction{

    
}

@end
