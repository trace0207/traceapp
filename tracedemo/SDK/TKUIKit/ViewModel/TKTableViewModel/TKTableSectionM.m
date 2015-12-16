//
//  TKTableSectionM.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableSectionM.h"

@implementation TKTableSectionM



-(instancetype)init
{
    self = [super init];
    _sectionHeadHeight = 10;
    _sectionFootHeight = 1.0f;
    _rowHeight = 44;
    return self;
}

-(NSMutableArray<__kindof TKTableViewRowM *> *)rowsData
{
    if(!_rowsData)
    {
        _rowsData = [[NSMutableArray alloc] init];
    }
    return _rowsData;
}


@end
