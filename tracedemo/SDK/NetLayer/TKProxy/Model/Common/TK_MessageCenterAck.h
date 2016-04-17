//
//  TK_MessageCenterAck.h
//  tracedemo
//
//  Created by cmcc on 16/4/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "HF_BaseAck.h"

@protocol MSGData <NSObject>


@end

@interface MSGData : TK_BaseJsonModel
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
@property (nonatomic,assign) NSInteger  toUserRole;
@end

@interface BoxItemData : TK_BaseJsonModel
@property (nonatomic,strong) NSString * boxContent;
@property (nonatomic,assign) NSInteger  boxType;
@property (nonatomic,strong) NSString * createTime;
@property (nonatomic,strong) NSString * id;
@property (nonatomic,strong) NSString * modifyTime;
@property (nonatomic,strong) NSString * operatorId;
@property (nonatomic,strong) NSString * operatorRole;


@end

@interface MsgBoxAckData : TK_BaseJsonModel
@property (nonatomic,strong) BoxItemData * MSG_ORDER;
@property (nonatomic,strong) BoxItemData * MSG_PAY;
@property (nonatomic,strong) BoxItemData * MSG_SOCIAL;
@property (nonatomic,copy) NSArray<MSGData> * MSG_IM;
@end

@interface TK_MessageCenterAck : HF_BaseAck

@property (nonatomic,strong)MsgBoxAckData * data;


//[recode]: 200
//[data]: {
//    "MSG_IM" =     (
//                    {
//                        content = "";
//                        createTime = 0;
//                        fromHeaderUrl = "";
//                        fromNickName = "";
//                        fromUserId = 0;
//                        fromUserRole = 0;
//                        id = 0;
//                        toHeaderUrl = "";
//                        toNickName = "192s\U9501\U5b9a \U6c34\U7535\U8d39";
//                        toUserId = 3;
//                        toUserRole = 0;
//                    }
//                    );
//    "MSG_ORDER" =     {
//        boxContent = "\U60a8\U6709\U4e00\U7b14\U8ba2\U5355\U5df2\U7ecf\U5ef6\U671f\U53d1\U8d27\Uff0c\U7cfb\U7edf\U5df2\U7ecf\U5bf9\U60a8\U8fdb\U884c\U4e86\U8d54\U4ed8\Uff0c\U8be6\U60c5\U8bf7\U6253\U5f00app\U67e5\U770b";
//        boxType = 0;
//        createTime = 1460797200040;
//        id = 6;
//        modifyTime = 1460797200040;
//        operatorId = 1;
//        operatorRole = 1;
//    };
//    "MSG_PAY" = "<null>";
//    "MSG_SOCIAL" = "<null>";
//}
//[msg]: 响应正常

@end
