//
//  TK_LoginAck.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/2.
//  Copyright © 2015年 trace. All rights reserved.
//

@class HF_BaseAck;

//@protocol LoginAckData <NSObject>
//@end

@interface LoginAckData:TK_BaseJsonModel

//@property (nonatomic, copy)   NSString  *address;//
//@property (nonatomic, copy)   NSString  *deviceId;//
//@property (nonatomic, copy)   NSString  *id;//
//@property (nonatomic, copy)   NSString  *inviteCode;//
//@property (nonatomic, copy)   NSString  *isActive;//
//@property (nonatomic, copy)   NSString  *lastLoginTime;//
//@property (nonatomic, copy)   NSString  *mobile;//
//@property (nonatomic, copy)   NSString  *modifyTime;//
//@property (nonatomic, copy)   NSString  *nickName;//
//@property (nonatomic, copy)   NSString  *password;//
//@property (nonatomic, copy)   NSString  *registerTime;//
//@property (nonatomic, copy)   NSString  *signature;//
//@property (nonatomic, copy)   NSString  *version;//
//@property (nonatomic, copy)   NSString  *headerUrl;//
//@property (nonatomic, assign) NSInteger  hongbao;//

@property (nonatomic, copy)   NSString  *guarantee;//
@property (nonatomic, copy)   NSString  *headerUrl;//
@property (nonatomic, copy)   NSString  *id;//
@property (nonatomic, copy)   NSString  *mobile;//
@property (nonatomic, copy)   NSString  *modifyTime;//
@property (nonatomic, copy)   NSString  *purchaserName;//
@property (nonatomic, copy)   NSString  *quantity;//
@property (nonatomic, copy)   NSString  *quota;//
@property (nonatomic, copy)   NSString  *registerTime;//
@property (nonatomic, copy)   NSString  *signature;//
@property (nonatomic, copy)   NSString  *token;//
@property (nonatomic, copy)   NSString  *version;//
@property (nonatomic, copy)   NSString  *vip;//
@end


@interface TK_LoginAck : HF_BaseAck

@property (nonatomic,strong)LoginAckData *data;

/**
 * 
 Ack : 【http://183.131.13.104:8080/apollo/nologin/login!login.action】
 Params:{
 data =     {
 account = 0;
 deviceId = "SU1FST0wMjU3QUI5MC02QzI2LTRFQjktODk2NC1FMzIwRDZFNTlCNDd8VkVSU0lPTj0xLjB8U05BTUU9KG51bGwpfERFVklDRT14ODZfNjR8T1NWRVJTSU9OPTkuMg==";
 guarantee = 100000000;
 headerUrl = "http://www.baidu.com";
 id = 2;
 isActive = 1;
 lastLoginTime = 20151130170014;
 mobile = 18867101952;
 modifyTime = 1456843697000;
 password = e10adc3949ba59abbe56e057f20f883e;
 purchaserName = "\U4e70\U624b\U5c0f\U7530";
 quantity = 0;
 quota = 200000000;
 registerTime = 20151130170011;
 signature = "<null>";
 token = trace990;
 version = 28;
 vip = 8;
 };
 msg = "\U54cd\U5e94\U6b63\U5e38";
 recode = 200;

 */



@end
