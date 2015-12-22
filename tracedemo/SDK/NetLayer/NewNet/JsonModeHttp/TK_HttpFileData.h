//
//  TK_HttpFileData.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/21.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_BaseJsonModel.h"

@interface TK_HttpFileData : TK_BaseJsonModel

@property (nonatomic,strong) NSData<Ignore> * tkData;
@property (nonatomic,strong) NSString * displayName;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * type;

@end
