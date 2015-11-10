//
//  HttpFileReq.h
//  GuanHealth
//
//  Created by cmcc on 15/7/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHttpReq.h"

@interface HttpFileReq : BaseHttpReq

@property (nonatomic,strong)NSString<Ignore>  * fileName;
@property (nonatomic,strong)NSString<Ignore>  * fileRemoteUrl;
@property (nonatomic,strong)NSString<Ignore>  * fileLocalPath;
@property (nonatomic,strong)NSString<Ignore> * relativeUrl;


//  for NFNetworking  below
@property (nonatomic,strong)NSData<Ignore>    * fileData;
@property (nonatomic,strong)NSString<Ignore> * mimeType;


//@param name The name to be associated with the specified data. This parameter must not be `nil`.
@property (nonatomic,strong)NSString<Ignore> * name;

@end
