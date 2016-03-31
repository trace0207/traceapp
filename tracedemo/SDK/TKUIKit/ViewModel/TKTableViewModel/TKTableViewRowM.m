//
//  TKTableViewRowM.m
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableViewRowM.h"

@implementation TKTableViewRowM


static TKTableViewRowM * nullRow;

-(instancetype)init
{
    self = [super init];
    return self;
}


-(CGFloat)rowHeight
{
    
    //
    return  _rowHeight;
}


+(TKTableViewRowM *)null
{
    if(nullRow == nil)
    {
        nullRow = [[TKTableViewRowM alloc] init];
    }
    return nullRow;
}

@end
