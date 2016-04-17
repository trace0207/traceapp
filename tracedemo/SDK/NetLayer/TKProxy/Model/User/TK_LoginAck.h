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



//defaultReceiver =         {
//    address = "Did xi lu. 550  ha0";
//    city = "\U676d\U5dde";
//    createTime = 1459145759000;
//    id = 34;
//    isDefault = 1;
//    modifyTime = 1459145777000;
//    postcode = 111110;
//    province = "\U6d59\U6c5f";
//    receiver = "Luo tian jia";
//    receiverMobile = 18867101952;
//    userId = 1;
//};

@interface Address : TK_BaseJsonModel

@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * createTime;
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * isDefault;
@property (nonatomic,copy) NSString * modifyTime;
@property (nonatomic,copy) NSString * postcode;
@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * receiver;
@property (nonatomic,copy) NSString * receiverMobile;
@property (nonatomic,copy) NSString * userId;

@end


@protocol CategoryListFromLogin <NSObject>

@end

@interface CategoryListFromLogin : TK_BaseJsonModel

@property (nonatomic,strong)NSString * categoryName;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *sum;

@end


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
@property (nonatomic, copy)   NSString  *bigMoney;
@property (nonatomic, copy)   NSString  *nickName;
@property (nonatomic, copy)   NSString  *inviteCode;

@property (nonatomic, strong) Address  *defaultReceiver;//
@property (nonatomic, strong) NSArray<CategoryListFromLogin>  *beSubscribeCateList;//

@end

@interface TK_LoginAck : HF_BaseAck



@property (nonatomic,strong)LoginAckData *data;

//data =     {
//    address = "";
//    bigMoney = "1503.6";
//    defaultReceiver =         {
//        address = "Did xi lu. 550  ha0";
//        city = "\U676d\U5dde";
//        createTime = 1459145759000;
//        id = 34;
//        isDefault = 1;
//        modifyTime = 1459145777000;
//        postcode = 111110;
//        province = "\U6d59\U6c5f";
//        receiver = "Luo tian jia";
//        receiverMobile = 18867101952;
//        userId = 1;
//    };
//    deviceId = "SU1FST0wMjU3QUI5MC02QzI2LTRFQjktODk2NC1FMzIwRDZFNTlCNDd8VkVSU0lPTj0xLjB8U05BTUU9KG51bGwpfERFVklDRT14ODZfNjR8T1NWRVJTSU9OPTkuMnxyb2xlPTE=";
//    headerUrl = "http://114.55.30.32/hiifit/header/zengbin.jpg";
//    id = 1;
//    inviteCode = P8342285A;
//    isActive = 0;
//    lastLoginTime = 111;
//    mobile = 18867102687;
//    modifyTime = 1459145651000;
//    nickName = "\U66fe\U658c";
//    password = e10adc3949ba59abbe56e057f20f883e;
//    registerTime = 11;
//    signature = "\U8eab\U5728\U4ed6\U4e61\U68a6\U5728\U8fdc\U65b9";
//    token = trace990;
//    version = 241;
//};
//msg = "\U54cd\U5e94\U6b63\U5e38";
//recode = 200;

@end
