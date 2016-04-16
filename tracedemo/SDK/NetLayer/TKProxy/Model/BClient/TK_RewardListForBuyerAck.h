//
//  TK_RewardListForBuyerAck.h
//  tracedemo
//
//  Created by cmcc on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"



@protocol RewardData <NSObject>

@end


@interface RewardData : TK_BaseJsonModel


/**
 acceptTime = "<null>";
 address = "<null>";
 brandId = 1;
 brandName = PRADA;
 categoryId = 1;
 categoryName = "\U5305\U5305";
 clock = 109627023;
 content = "\U6c42\U8d2d \U6c42\U8d2d ";
 createTime = 1458047316809;
 finalTime = "<null>";
 id = 78;
 isPublic = 1;
 modifyTime = 1458133801000;
 picAddr1 = "http://114.55.30.32:80/hiifit/showorder/showorder_20160315210836_621_X.jpg";
 picAddr2 = "http://114.55.30.32:80/hiifit/showorder/showorder_20160315210836_474_X.jpg";
 picAddr3 = "<null>";
 picAddr4 = "<null>";
 picAddr5 = "<null>";
 picAddr6 = "<null>";
 picAddr7 = "<null>";
 picAddr8 = "<null>";
 picAddr9 = "<null>";
 priorPurchaserId = 1;
 productNum = 1;
 purchaserDay = "<null>";
 purchaserId = "<null>";
 receiverId = 1;
 releaseTime = 1458133800023;
 requireDay = 1;
 rewardPrice = 4;
 rewardStatus = 101;
 source = 1;
 sourceId = 1;
 userHeaderUrl = "http://114.55.30.32/hiifit/header/zengbin.jpg";
 userId = 1;
 userNickName = "\U66fe\U658c";
 userSignature = "\U8eab\U5728\U4ed6\U4e61\U68a6\U5728\U8fdc\U65b9";

 **/


@property (nonatomic,strong)NSString * acceptTime;
@property (nonatomic,strong)NSString * address;
@property (nonatomic,strong)NSString * brandId;
@property (nonatomic,strong)NSString * brandName;
@property (nonatomic,strong)NSString * categoryId;
@property (nonatomic,strong)NSString * categoryName;
@property (nonatomic,strong)NSString * clock;
@property (nonatomic,strong)NSString * content;
@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,strong)NSString * finalTime;
@property (nonatomic,strong)NSString * id;
@property (nonatomic,strong)NSString * isPublic;
@property (nonatomic,strong)NSString * modifyTime;
@property (nonatomic,copy)NSString * picAddr1;
@property (nonatomic,copy)NSString * picAddr2;
@property (nonatomic,strong)NSString * picAddr3;
@property (nonatomic,strong)NSString * picAddr4;
@property (nonatomic,strong)NSString * picAddr5;
@property (nonatomic,strong)NSString * picAddr6;
@property (nonatomic,strong)NSString * picAddr7;
@property (nonatomic,strong)NSString * picAddr8;
@property (nonatomic,strong)NSString * picAddr9;
@property (nonatomic,strong)NSString * priorPurchaserId;
@property (nonatomic,strong)NSString * productNum;
@property (nonatomic,strong)NSString * purchaserId;
@property (nonatomic,strong)NSString * receiverId;
@property (nonatomic,strong)NSString * releaseTime;
@property (nonatomic,strong)NSString * requireDay;
@property (nonatomic,strong)NSString * rewardPrice;
@property (nonatomic,strong)NSString * rewardStatus;
@property (nonatomic,strong)NSString * source;
@property (nonatomic,strong)NSString * sourceId;
@property (nonatomic,strong)NSString * userHeaderUrl;
@property (nonatomic,strong)NSString * userId;
@property (nonatomic,strong)NSString * userNickName;
@property (nonatomic,strong)NSString * userSignature;
@property (nonatomic,assign)NSInteger  followCount;



-(NSArray *)getPicsArrays;

@end


@interface TK_RewardListForBuyerAck : HF_BaseAck

@property (nonatomic,copy)NSArray<RewardData> *data;

@end
