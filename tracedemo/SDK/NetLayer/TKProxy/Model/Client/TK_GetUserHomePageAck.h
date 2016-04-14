//
//  TK_GetUserHomePageAck.h
//  tracedemo
//
//  Created by cmcc on 16/4/14.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"
#import "TK_LoginAck.h"


@interface GetUserHomePageData:TK_BaseJsonModel

@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * bigMoney;
@property (nonatomic,strong) Address  *defaultReceiver;
@property (nonatomic,strong) NSString * deviceId;
@property (nonatomic,strong) NSString * headerUrl;
@property (nonatomic,strong) NSString * id;
@property (nonatomic,strong) NSString * inviteCode;
@property (nonatomic,strong) NSString * isActive;
@property (nonatomic,strong) NSString * isForbidLogin;
@property (nonatomic,strong) NSString * isForbidPost;
@property (nonatomic,strong) NSString * isForbidShow;
@property (nonatomic,strong) NSString * lastLoginTime;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,strong) NSString * modifyTime;
@property (nonatomic,strong) NSString * nickName;
@property (nonatomic,strong) NSString * password;
@property (nonatomic,strong) NSString * registerTime;
@property (nonatomic,strong) NSString * signature;
@property (nonatomic,strong) NSString * token;
@property (nonatomic,strong) NSString * version;
@property (nonatomic,strong) NSString * purchaserName;
@property (nonatomic,strong) NSString * vip;

@end

@interface TK_GetUserHomePageAck : HF_BaseAck

@property (nonatomic,strong) GetUserHomePageData * data;

//
//Params:{d
//    data =     {
//        address = "";
//        bigMoney = 1512;
//        defaultReceiver = "<null>";
//        deviceId = "SU1FST1BNUI1RjJGNi1FRTQxLTRCOUYtQkJBOC0zQTJCMjVFMkJCNDR8VkVSU0lPTj0xLjB8U05BTUU95Lit5Zu956e75YqofERFVklDRT1pUGhvbmU3LDF8T1NWRVJTSU9OPTkuMC4yfHJvbGU9MQ==";
//        headerUrl = "http://114.55.30.32/hiifit/header/zengbin.jpg";
//        id = 1;
//        inviteCode = P8342285A;
//        isActive = 0;
//        isForbidLogin = 0;
//        isForbidPost = 0;
//        isForbidShow = 0;
//        lastLoginTime = 111;
//        mobile = 18867102687;
//        modifyTime = 1460591764000;
//        nickName = "\U66fe\U658c";
//        password = e10adc3949ba59abbe56e057f20f883e;
//        registerTime = 11;
//        signature = "\U8eab\U5728\U4ed6\U4e61\U68a6\U5728\U8fdc\U65b9";
//        token = trace990;
//        version = 578;
//    };
//    msg = "\U54cd\U5e94\U6b63\U5e38";
//    recode = 200;
//}



@end
