//
//  TK_MessageListByTypeAck.h
//  tracedemo
//
//  Created by cmcc on 16/4/28.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"


@protocol ChatMsg <NSObject>

@end

@interface ChatMsg : TK_BaseJsonModel

//content = Ddfg;
//createTime = 1461738769388;
//fromHeaderUrl = "https://114.55.30.32:443/pictures/user/showorder/20978/20160417201019016_X.jpg";
//fromNickName = "\U6211\U662f\U5927\U5934";
//fromUserId = 20978;
//fromUserRole = 1;
//id = 32;
//toHeaderUrl = "";
//toNickName = "";
//toUserId = 20979;
//toUserRole = 1;

@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * createTime;
@property (nonatomic,strong) NSString * fromHeaderUrl;
@property (nonatomic,strong) NSString * fromNickName;
@property (nonatomic,strong) NSString * fromUserId;
@property (nonatomic,strong) NSString * fromUserRole;
@property (nonatomic,strong) NSString * id;
@property (nonatomic,strong) NSString * toHeaderUrl;
@property (nonatomic,strong) NSString * toNickName;
@property (nonatomic,strong) NSString * toUserId;
@property (nonatomic,strong) NSString * toUserRole;
@end


@interface TK_MessageListByTypeAck : HF_BaseAck
@property (nonatomic,copy) NSArray<ChatMsg> *data;

@end
