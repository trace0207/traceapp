//
//  TK_PublishRewardArg.h
//  tracedemo
//
//  Created by cmcc on 16/3/15.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseArg.h"

@interface TK_PublishRewardArg : HF_BaseArg


@property (nonatomic,strong) NSString *rewardPrice;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *picAddr1;
@property (nonatomic,strong) NSString *picAddr2;
@property (nonatomic,strong) NSString *picAddr3;
@property (nonatomic,strong) NSString *picAddr4;
@property (nonatomic,strong) NSString *picAddr5;
@property (nonatomic,strong) NSString *picAddr6;
@property (nonatomic,strong) NSString *picAddr7;
@property (nonatomic,strong) NSString *picAddr8;
@property (nonatomic,strong) NSString *picAddr9;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) NSString *receiverId;
@property (nonatomic,strong) NSString *brandId;
@property (nonatomic,strong) NSString *source; //0.晒单页发起 1.自主发起 2.悬赏页跟单
@property (nonatomic,strong) NSString *sourceId;// 晒单发起悬赏，填入晒单id；悬赏跟单，填入被跟悬赏id；自主发起传入用户id
@property (nonatomic,strong) NSString *requireDay;
@end
