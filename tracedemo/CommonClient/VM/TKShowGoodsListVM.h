//
//  TKShowGoodsListVM.h
//  tracedemo
//
//  Created by cmcc on 16/3/3.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKTableViewVM.h"
#import "TK_Brand.h"
#import "TK_ShareCategory.h"

@interface TKShowGoodsListVM : TKTableViewVM


@property (nonatomic,strong)TK_Brand * brand;
@property (nonatomic,strong)TK_ShareCategory * category;

@end
