//
//  HFBandViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFBandViewController.h"
#import "BandCenter.h"
@interface HFBandViewController ()

@end

@implementation HFBandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor HFColorStyle_5];
    
  //  [[BandCenter shareInstance] connnetLib];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bandAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissBandView:)]) {
        [self.delegate dismissBandView:self];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
