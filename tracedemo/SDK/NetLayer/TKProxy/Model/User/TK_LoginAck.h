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

@property (nonatomic, copy)   NSString  *address;//
@property (nonatomic, copy)   NSString  *deviceId;//
@property (nonatomic, copy)   NSString  *id;//
@property (nonatomic, copy)   NSString  *inviteCode;//
@property (nonatomic, copy)   NSString  *isActive;//
@property (nonatomic, copy)   NSString  *lastLoginTime;//
@property (nonatomic, copy)   NSString  *mobile;//
@property (nonatomic, copy)   NSString  *modifyTime;//
@property (nonatomic, copy)   NSString  *nickName;//
@property (nonatomic, copy)   NSString  *password;//
@property (nonatomic, copy)   NSString  *registerTime;//
@property (nonatomic, copy)   NSString  *signature;//
@property (nonatomic, copy)   NSString  *version;//
@property (nonatomic, copy)   NSString  *headerUrl;//
@property (nonatomic, assign) NSInteger  hongbao;//

@end


@interface TK_LoginAck : HF_BaseAck

@property (nonatomic,strong)LoginAckData *data;

/**
 * 
 Ack : 【http://183.131.13.104:8080/apollo/nologin/login!login.action】
 Params:{
 data =     {
 address = "<null>";
 deviceId = 123;
 headerUrl = "http://www.baidu.com";
 hongbao = 0;
 id = 20975;
 inviteCode = MR72283A8;
 isActive = "<null>";
 lastLoginTime = 1448528141000;
 mobile = 18867102687;
 modifyTime = 1448528141000;
 nickName = "\U8ffd\U661f\U7684\U660e\U73e0";
 password = e10adc3949ba59abbe56e057f20f883e;
 registerTime = 1448528141000;
 signature = "<null>";
 version = 1000;
 };
 msg = "\U54cd\U5e94\U6b63\U5e38";
 recode = 200;
 }

 */



@end
