//
//  HFStepCounterErrorViewController.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFStepCounterErrorViewController.h"

@interface HFStepCounterErrorViewController ()

@end

@implementation HFStepCounterErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor HFColorStyle_6];
    
    self.navigationItem.title = @"无法计步";
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 30)];
    titleLable.text = @"无法计步？";
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.view addSubview:titleLable];
    
    UILabel * reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x,  CGRectGetMaxY(titleLable.frame) + 10, 200, 30)];
    reasonLabel.text = @"可能由以下原因导致";
    reasonLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:reasonLabel];
    
    UILabel * reasonOne = [[UILabel alloc] initWithFrame:CGRectMake(reasonLabel.frame.origin.x, CGRectGetMaxY(reasonLabel.frame) + 10, 170, 30)];
    reasonOne.text = @"1.行走时，后台没有启动";
    reasonOne.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:reasonOne];
    
    UILabel * healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(reasonOne.frame), reasonOne.frame.origin.y, 70, 30)];
    healthLabel.text = @"\"嗨健康\"";
    healthLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [self.view addSubview:healthLabel];
    
    UILabel * softwareLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(healthLabel.frame), healthLabel.frame.origin.y, 60, 30)];
    softwareLabel.text = @"软件。";
    softwareLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:softwareLabel];
    
    UILabel * reasonTwo = [[UILabel alloc] initWithFrame:CGRectMake(reasonOne.frame.origin.x, CGRectGetMaxY(reasonOne.frame), 280, 30)];
    reasonTwo.text = @"2.您的手机自身不带有计步功能。";
    reasonTwo.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:reasonTwo];
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

@end
