//
//  TK_CategoryListAck.h
//  tracedemo
//
//  Created by cmcc on 16/3/6.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"

@interface CategoryData : TK_BaseJsonModel


@property (nonatomic,copy)NSString * categoryName;
@property (nonatomic,copy)NSString * createTime;
@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString * sum;

@end

@protocol CategoryData <NSObject>

@end

@interface TK_CategoryListAck : HF_BaseAck

@property (nonatomic,strong) NSArray<CategoryData> * data;



@end
