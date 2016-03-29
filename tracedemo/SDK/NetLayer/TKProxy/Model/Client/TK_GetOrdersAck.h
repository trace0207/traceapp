//
//  TK_GetOrdersAck.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/14.
//  Copyright © 2015年 trace. All rights reserved.
//


@protocol GetOrderData <NSObject>

@end


@interface GetOrderData : TK_BaseJsonModel

@property (nonatomic,copy) NSString  *brandId;
@property (nonatomic,copy) NSString  *brandName;
@property (nonatomic,copy) NSString  *categoryId;
@property (nonatomic,copy) NSString  *categoryName;
@property (nonatomic,copy) NSString  *content;
@property (nonatomic,copy) NSString  *createTime;
@property (nonatomic,copy) NSString  *followCount;
@property (nonatomic,copy) NSString  *id;
@property (nonatomic,copy) NSString  *modifyTime;
@property (nonatomic,copy) NSString  *operatorId;
@property (nonatomic,copy) NSString  *orderId;
@property (nonatomic,copy) NSString  *picAddr1;
@property (nonatomic,copy) NSString  *picAddr2;
@property (nonatomic,copy) NSString  *picAddr3;
@property (nonatomic,copy) NSString  *picAddr4;
@property (nonatomic,copy) NSString  *picAddr5;
@property (nonatomic,copy) NSString  *picAddr6;
@property (nonatomic,copy) NSString  *picAddr7;
@property (nonatomic,copy) NSString  *picAddr8;
@property (nonatomic,copy) NSString  *picAddr9;
@property (nonatomic,copy) NSString  *praiseCount;
@property (nonatomic,copy) NSString  *purchaserHeaderUrl;
@property (nonatomic,copy) NSString  *purchaserNickName;
@property (nonatomic,copy) NSString  *purchaserSignature;
@property (nonatomic,copy) NSString  *role;
@property (nonatomic,copy) NSString  *showPrice;
@property (nonatomic,copy) NSString  *userHeaderUrl;
@property (nonatomic,copy) NSString  *userSignature;
@property (nonatomic,copy) NSString  *userNickName;


@end

@class HF_BaseAck;


@interface TK_GetOrdersAck : HF_BaseAck
@property (nonatomic,copy) NSArray<GetOrderData> * data;



//brandId = 2;
//brandName = "POLO \U5723\U5927\U4fdd\U7f57";
//categoryId = 2;
//categoryName = "\U6bcd\U5a74";
//content = "\U8bf7\U8f93\U5165\U989c\U8272\U3001\U5c3a\U7801\U3001\U5c3a\U5bf8\U7b49\U76f8\U5173\U4fe1\U606f";
//createTime = 1459150864563;
//followCount = 0;
//id = 17;
//modifyTime = 1459150864563;
//operatorId = 1;
//orderId = 0;
//picAddr1 = "https://114.55.30.32:443/pictures/user/showorder/1/20160324215704867_X.jpg";
//picAddr2 = "https://114.55.30.32:443/pictures/user/showorder/1/20160324215704719_X.jpg";
//picAddr3 = "";
//picAddr4 = "";
//picAddr5 = "";
//picAddr6 = "";
//picAddr7 = "";
//picAddr8 = "";
//picAddr9 = "";
//praiseCount = 0;
//purchaserHeaderUrl = "http://114.55.30.32/hiifit/header/zengbin.jpg";
//purchaserNickName = "\U4e70\U624b\U66fe\U658c";
//purchaserSignature = "\U8fd9\U5e74\U5934\U505a\U751f\U610f\U4e0d\U5bb9\U6613";
//role = 0;
//showPrice = 2;
//userHeaderUrl = "";
//userNickName = "";
//userSignature = "";



@end
