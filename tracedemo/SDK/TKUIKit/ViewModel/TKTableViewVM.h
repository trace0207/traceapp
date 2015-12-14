//
//  TKTableViewVM.h
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTableSectionM.h"
#import "TKTableViewRowM.h"
#import "TK_SettingCell.h"

@interface TKTableViewVM : NSObject
@property (nonatomic,strong) UITableView * mTableView;
@property (nonatomic,strong) NSMutableArray<__kindof TKTableSectionM *> * sectionData;


-(TKTableSectionM *)defaultSection;


#pragma  mark  UITableViewDelegate && UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
@end
