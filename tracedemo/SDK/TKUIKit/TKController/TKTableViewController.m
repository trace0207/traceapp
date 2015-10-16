//
//  TKTableViewController.m
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKTableViewController.h"

@interface TKTableViewController ()<UITableViewDataSource,UITableViewDelegate>{

}

@end

@implementation TKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _tableView = [[UITableView alloc] init];
    if(_tableView){
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
    }
    //    _tableView.frame = self.view.frame;
//    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//    [self.view addSubview:_tableView];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    UILabel  * text = [[UILabel alloc]init];
    text.text = [@"cellLabel_" stringByAppendingString:[NSNumber numberWithLong:[indexPath row]].stringValue];
    
    
    text.frame = CGRectMake(0, 0, 150, 60);
    
    [cell addSubview:text];
    
    return cell;
    
}

@end
