//
//  TK_BoxListAck.h
//  tracedemo
//
//  Created by cmcc on 16/4/17.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"


@protocol BoxListData <NSObject>


@end

@interface BoxListData : TK_BaseJsonModel

@property (nonatomic,strong) NSString * boxContent;
@property (nonatomic,assign) NSInteger  boxType;
@property (nonatomic,assign) NSInteger  createTime;
@property (nonatomic,strong) NSString * id;
@property (nonatomic,strong) NSString * modifyTime;
@property (nonatomic,strong) NSString * operatorId;
@property (nonatomic,strong) NSString * operatorRole;


@end

@interface TK_BoxListAck : HF_BaseAck

@property (nonatomic,strong) NSArray<BoxListData> *data;

@end
