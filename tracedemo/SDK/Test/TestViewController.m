//
//  TestViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/27.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TestViewController.h"
#import "Masonry.h"

@interface TestViewController ()
{

    UIView *aView;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   UIView  * view =  [[UIView alloc] init];
    self.view = view;
    view.backgroundColor = [UIColor blueColor];
    aView = [[UIView alloc] init];
    
    [self.view addSubview:aView];
    [aView setBackgroundColor:[UIColor redColor]];

    
    [aView mas_updateConstraints:^(MASConstraintMaker *make)
    {
        make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(100,100,100,100));
    }];

    
    
    
//        self.view.translatesAutoresizingMaskIntoConstraints = NO;
//        _Bview.translatesAutoresizingMaskIntoConstraints = NO;
//    
//        [_Bview mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//    
//        }];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    [self performSelector:@selector(update) withObject:self afterDelay:3.0];
    

//    _Bview.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    
//    [_Bview mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(100);
//    }];
//    
//    [_Bview setNeedsUpdateConstraints];
//
//    [_Bview layoutIfNeeded];
    
    
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
//    _Bview.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [_Bview mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//        
//    }];
    
}

-(void)update{

    
    [aView mas_updateConstraints:^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(0,0,0,0));
     }];
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
