//
//  TKIRewardVM.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/16.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKTableViewVM.h"

#import "TK_ShareCategory.h"
#import "TK_Brand.h"


@interface TKIRewardVM : TKTableViewVM
@property (nonatomic,strong)TK_Brand * brand;
@property (nonatomic,strong)TK_ShareCategory * category;
@property (nonatomic,assign)HomePageType rewardPageType;
@end
