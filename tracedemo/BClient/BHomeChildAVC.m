//
//  BHomeChildAVC.m
//  tracedemo
//
//  Created by 罗田佳 on 16/2/18.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BHomeChildAVC.h"
#import "BHomeChildAScrolBox.h"
#import "TKIShowGoodsVM.h"
#import "TKIRewardVM.h"

@interface BHomeChildAVC ()
{
    TKIRewardVM * vm1;
}




@end


const NSInteger boxWidth  = 84;
@implementation BHomeChildAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initHeadScrollView];
    [self initContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)initHeadScrollView
{
    
    NSInteger  width = 5 * boxWidth;
    NSInteger height = _headScrollView.frame.size.height;
    [_headScrollView setContentSize: CGSizeMake(width,height)];
    
    _headScrollView.showsHorizontalScrollIndicator = NO;
    
    for(int i = 0;i<5;i++)
    {
        BHomeChildAScrolBox * box = [[[NSBundle mainBundle] loadNibNamed:@"BHomeCHildAScrollBox" owner:self options:nil] objectAtIndex:0];
        
        box.frame = CGRectMake(0 + i * boxWidth, 0, boxWidth, height);
        [_headScrollView addSubview:box];
    }
    
}


-(void)initContentView
{
    vm1 = [[TKIRewardVM alloc] initWithFreshAbleTable ];
    [self.contentView addSubview:vm1.pullRefreshView];
    [vm1 tkUpdateViewConstraint];
    [vm1 startPullDownRefreshing];
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
