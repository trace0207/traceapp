//
//  TK_UserCenterVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/30.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_UserCenterVM.h"


@implementation TK_UserCenterVM


-(void)tkLoadDefaultData
{
    
    TKTableSectionM * section0 = [[TKTableSectionM alloc] init];
    section0.sectionHeadHeight = 10;
    section0.sectionFootHeight = 10;
    [section0 initDefaultRowData:1];
    
    TKTableSectionM * section1 = [[TKTableSectionM alloc] init];
    section1.sectionHeadHeight = 0.01;
    section1.sectionFootHeight = 10;
    [section1 initDefaultRowData:3];
    
    
    
    TKTableSectionM * section2 = [[TKTableSectionM alloc] init];
    section2.sectionHeadHeight = 0.01;
    section2.sectionFootHeight = 10;
    [section2 initDefaultRowData:5];
    
    
    NSMutableArray * sections = [[NSMutableArray alloc] initWithObjects:section0,section1,section2, nil];
    self.sectionData = sections;
}


@end
