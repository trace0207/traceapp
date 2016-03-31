//
//  TK_UserNormalViewModel.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/17.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TK_ShareCategory.h"
#import "TK_CategoryListAck.h"
#import "TK_BrandListAck.h"
#import "TK_Brand.h"
#import "TK_ShareCategory.h"
#import "TK_LoginAck.h"

@interface TK_UserNormalViewModel : NSObject
@property (nonatomic,copy) NSMutableArray<__kindof TK_ShareCategory*> * shareCategorys;
@property (nonatomic,copy) NSMutableArray<__kindof TK_Brand*> * brandList;
@property (nonatomic,copy) NSMutableArray<__kindof TK_ShareCategory*> * buyerCateList;

@property (nonatomic,strong)NSString * token;


-(void)resetCategorys:(TK_CategoryListAck*)ack;

-(void)resetBrandList:(TK_BrandListAck *)ack;

-(void)restBuyerCateList:(NSArray< __kindof CategoryListFromLogin*> *)brands;

@end
