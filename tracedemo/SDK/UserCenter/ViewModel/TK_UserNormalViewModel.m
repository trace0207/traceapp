//
//  TK_UserNormalViewModel.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/17.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_UserNormalViewModel.h"

@implementation TK_UserNormalViewModel
@synthesize token;

-(instancetype)init{

    self = [super init];
//    _shareCategorys = [self getShareCategory];
    return self;
}



//-(NSMutableArray * )getShareCategory{
//    
//    NSMutableArray * array = [[NSMutableArray alloc]init];
//    [array addObject:[TK_ShareCategory setTitle:@"服饰" setId:1]];
//    [array addObject:[TK_ShareCategory setTitle:@"箱包" setId:2]];
//    [array addObject:[TK_ShareCategory setTitle:@"手袋" setId:3]];
//    [array addObject:[TK_ShareCategory setTitle:@"护肤" setId:4]];
//    [array addObject:[TK_ShareCategory setTitle:@"香水" setId:5]];
//    return array;
//}




-(void)resetCategorys:(TK_CategoryListAck*)ack
{
    [self.shareCategorys removeAllObjects ];
    
    NSArray<CategoryData> * data =  ack.data;
    
    for(CategoryData * ca in data)
    {
        [self.shareCategorys addObject:[TK_ShareCategory setTitle:ca.categoryName setId:ca.id time:ca.createTime sum:ca.sum]];
    }
}

-(void)resetBrandList:(TK_BrandListAck *)ack{
    
    [self.brandList removeAllObjects];
    for (BrandData * bd in ack.data) {
        
        TK_Brand * tkbd = [[TK_Brand alloc] init];
        tkbd.brandCreateTime = bd.createTime;
        tkbd.brandId = bd.id;
        tkbd.brandName = bd.brandName;
        [self.brandList addObject:tkbd];
        
    }
}


-(NSMutableArray *)shareCategorys
{
    if(!_shareCategorys)
    {
        _shareCategorys = [[NSMutableArray alloc] init];
    }
    return _shareCategorys;
}

-(NSMutableArray *)brandList
{
    if(!_brandList)
    {
        _brandList = [[NSMutableArray alloc] init];
    }
    return _brandList;
}

-(void)setToken:(NSString *)token1
{
    token = token1;
    
    [kUserDefaults setObject:token forKey:kParmsDeviceToken];
    [kUserDefaults synchronize];
    
}

-(NSString *)token
{
    if(!token)
    {
        token = [kUserDefaults objectForKey:kParmsDeviceToken];
    }
    return token;
}


@end
