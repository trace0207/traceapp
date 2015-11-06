//
//  TKGlobValue.h
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//


#ifndef TKGlobValue_h
#define TKGlobValue_h


//判定系统版本号
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)

#define IOS8VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IOS7VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define TKScreenBounds   [[UIScreen mainScreen]bounds]
#define TKScreenWidth    [[UIScreen mainScreen]bounds].size.width
#define TKScreenHeight   [[UIScreen mainScreen]bounds].size.height
#define TKScreenScale    (TKScreenWidth/320)

#endif