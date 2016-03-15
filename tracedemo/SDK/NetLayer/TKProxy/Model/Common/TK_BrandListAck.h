//
//  TK_BrandListAk.h
//  tracedemo
//
//  Created by cmcc on 16/3/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"


@interface BrandData : TK_BaseJsonModel
@property (nonatomic,copy)NSString * brandName;
@property (nonatomic,copy)NSString * createTime;
@property (nonatomic,copy)NSString * id;
@end

@protocol BrandData <NSObject>


@end

@interface TK_BrandListAck : HF_BaseAck
@property (nonatomic,strong) NSArray<BrandData> * data;


@end
