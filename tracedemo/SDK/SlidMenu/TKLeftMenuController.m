//
//  TKLeftMenuController.m
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKLeftMenuController.h"

@interface TKLeftMenuController (){

    NSInteger _maxWidth;
}

@end

@implementation TKLeftMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, _maxWidth, self.view.frame.size.height);
    
    self.tableView.bounces = NO;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(id)init{

    self = [super init];
    _maxWidth = 320 * TKScreenScale;
    return self;
}


-(id)initWithMaxWidth : (NSInteger) maxWidth
{

    self = [self init];
    _maxWidth = maxWidth;
    return self;
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
    
    return 6;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    UILabel  * text = [[UILabel alloc]init];
    text.text = [@"Menu_cell_index_" stringByAppendingString:[NSNumber numberWithLong:[indexPath row]].stringValue];
    
    
    text.frame = CGRectMake(0, 0, tableView.frame.size.width,60 * TKScreenScale);
    
    text.textAlignment  = UITextAlignmentCenter;
    
    [cell addSubview:text];
    
    return cell;
    
}

@end
