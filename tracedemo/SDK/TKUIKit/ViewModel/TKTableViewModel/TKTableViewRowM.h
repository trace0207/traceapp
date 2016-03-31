//
//  TKTableViewRowM.h
//  tracedemo
//
//  Created by cmcc on 15/12/13.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TKTableViewRowM : NSObject

@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,strong) NSObject * rowData;
@property (nonatomic,assign) BOOL isEmptyData;


+(TKTableViewRowM *)null;

@end
