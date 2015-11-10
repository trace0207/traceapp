//
//  RequestParameters.m
//  GuanHealth
//
//  Created by hermit on 15/2/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "RequestParameters.h"

@implementation RequestParameters

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(RequestParameters, shareInstance);

- (NSDictionary*)genParameters:(NSDictionary*)dic
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        [parameters addEntriesFromDictionary:dic];
    }
    
    //NSNumber *type = [NSNumber numberWithInt:1];
    NSString *deviceid = [GlobInfo shareInstance].deviceid;
    NSString *behaviorInfo = [GlobInfo shareInstance].behaviorInfo;
    //[parameters setObject:type forKey:kParamType];
    [parameters setObject:deviceid forKey:kParamDeviceId];
    [parameters setObject:behaviorInfo forKey:kParamBehavoirInfo];
    
    return parameters;
}

- (NSDictionary*)findPwdPhone:(NSString *)phone
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:kParamPhoneNumber];
    return [self genParameters:dic];
}

- (NSDictionary*)registerWithPhone:(NSString*)phoneNumber
                 sourceAccountType:(int)sourceAccountType
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNumber forKey:kParamPhoneNumber];
    [dic setObject:[NSNumber numberWithInt:sourceAccountType] forKey:@"sourceAccountType"];
    return [self genParameters:dic];
}

- (NSDictionary*)resetPassword:(NSString*)password
                      andPhone:(NSString*)phone
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:kParamPhoneNumber];
    [dic setObject:[password MD5Digest] forKey:kParamPassword];
    [dic setObject:[NSNumber numberWithInt:HIOSTypeIOS] forKey:@"deviceType"];
    return [self genParameters:dic];
}

- (NSDictionary*)registerWithPhone:(NSString*)phoneNumber
                          codeType:(int)codeType
                  verificationCode:(NSString*)verificationCode
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNumber forKey:kParamPhoneNumber];
    [dic setObject:[NSNumber numberWithInt:codeType] forKey:@"codeType"];
    [dic setObject:verificationCode forKey:@"code"];
    [dic setObject:@"Button0009" forKey:kParamModuleCode];
    
    return [self genParameters:dic];
}

- (NSDictionary*)registerWithPhone:(NSString *)phoneNumber
                          password:(NSString *)password
                 sourceAccountType:(int)sourceAccountType
                        deviceType:(int)deviceType
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNumber forKey:kParamPhoneNumber];
    NSString *pwd = [password MD5Digest];
    [dic setObject:pwd forKey:kParamPassword];
    [dic setObject:[NSNumber numberWithInt:sourceAccountType] forKey:@"sourceAccountType"];
    [dic setObject:[NSNumber numberWithInt:deviceType] forKey:@"deviceType"];
    [dic setObject:@"Button0009" forKey:kParamModuleCode];
    
    return [self genParameters:dic];
}

- (NSDictionary*)setUserInfo:(NSInteger)sex
                      height:(CGFloat)height
                      weight:(CGFloat)weight
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:sex] forKey:kParamSex];
    [dic setObject:[NSNumber numberWithFloat:height] forKey:kParamHeight];
    [dic setObject:[NSNumber numberWithFloat:weight] forKey:kParamWeight];
    [dic setObject:@"Page0002" forKey:kParamModuleCode];

    return [self genParameters:dic];
}

- (NSDictionary *)logoutParamers
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Button0055" forKey:kParamModuleCode];
    return [self genParameters:dic];
}
- (NSDictionary*)getUserInfo
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Button0021" forKey:kParamModuleCode];
    return [self genParameters:dic];
}

//add by shi_dongdong

//for 组成订阅消息拼接
- (NSDictionary *)subscribeInfo:(BOOL)bSubscribe
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (bSubscribe) {
        [dic setObject:[NSNumber numberWithInt:1] forKey:kParamIsSubscribe];
    }else{
        [dic setObject:[NSNumber numberWithInt:0] forKey:kParamIsSubscribe];
    }
    
    return [self genParameters:dic];
}
//add end

//add by shi_dongdong
//for 获取到点赞用户列表
- (NSDictionary *)likeUsersListWithType:(NSInteger)weiboType wbID:(NSInteger)weiboID
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInteger:weiboID] forKey:@"weiboId"];
    [dic setObject:[NSNumber numberWithInt:0] forKey:@"pageOffset"];
    [dic setObject:[NSNumber numberWithInt:100] forKey:@"pageSize"];
    return [self genParameters:dic];
}

//评论列表
- (NSDictionary *)commentUsersListWithType:(NSInteger)weiboType wbID:(NSInteger)weiboID
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInteger:weiboID] forKey:@"weiboId"];
    [dic setObject:[NSNumber numberWithInt:100] forKey:@"pageSize"];
    [dic setObject:[NSNumber numberWithInt:0] forKey:@"pageIndex"];
    return [self genParameters:dic];
}

//发表评论
- (NSDictionary *)SubmitCommentsWithType:(NSInteger)weiboType
                                    wbID:(NSInteger)weiboID
                                authorID:(NSInteger)authorID
                                 content:(NSString *)content
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInteger:weiboID] forKey:@"weiboId"];
    if (authorID == -1)
    {
        [dic setObject:@"" forKey:@"authorId"];
    }
    else
    {
        [dic setObject:[NSNumber numberWithInteger:authorID] forKey:@"authorId"];
    }
    [dic setObject:content forKey:@"content"];
    return [self genParameters:dic];
}

//用户点赞
- (NSDictionary *)submitLikeWithType:(NSInteger)weiboType wbID:(NSInteger)weiboID
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInteger:weiboID] forKey:@"weiboId"];
    return [self genParameters:dic];
}

//add end

- (NSDictionary*)loginWithPhone:(NSString*)account
                       password:(NSString*)passWord
                          photo:(NSString*)photo
                       nickName:(NSString*)nickName
                            sex:(NSInteger)sex
                           type:(NSInteger)sourceAccountType
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:account forKey:@"account"];
    if (passWord.length>0) {
        NSString *pwd = [passWord MD5Digest];
        [dic setObject:pwd forKey:kParamPassword];
    }
    if (photo.length>0) {
        [dic setObject:photo forKey:@"photo"];
    }
    if (nickName.length>0) {
        [dic setObject:nickName forKey:@"nickName"];
    }
    if (sex>=0) {
        [dic setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
    }
    
    [dic setObject:[NSNumber numberWithInteger:sourceAccountType] forKey:@"sourceAccountType"];
    [dic setValue:[NSNumber numberWithInt:HIOSTypeIOS] forKey:@"deviceType"];
    [dic setValue:[GlobInfo shareInstance].token forKey:@"bdChannelId"];
    [dic setValue:[NSNumber numberWithLong:[GlobInfo shareInstance].lastUpdateTime] forKey:@"lastUpdateTime"];
    return [self genParameters:dic];
}





- (NSDictionary*)modifyNickName:(NSString*)nickName{
    
    return [self modifyNickName:nickName andSignature:nil andHeight:0 andWeight:0 andYear:0 andMonth:0 andDay:0 andSex:0 updateType:3];
}
- (NSDictionary*)modifySignature:(NSString*)signature;{
    return [self modifyNickName:nil andSignature:signature andHeight:0 andWeight:0 andYear:0 andMonth:0 andDay:0 andSex:0 updateType:2];
}
- (NSDictionary*)modifyHeight:(CGFloat)height;{
    return [self modifyNickName:nil andSignature:nil andHeight:height andWeight:0 andYear:0 andMonth:0 andDay:0 andSex:0 updateType:5];
}
- (NSDictionary*)modifyWeight:(CGFloat)weight;{
    return [self modifyNickName:nil andSignature:nil andHeight:0 andWeight:weight andYear:0 andMonth:0 andDay:0 andSex:0 updateType:6];
}
- (NSDictionary*)modifyBirthday:(NSString*)year
                       andMonth:(NSString*)month
                         andDay:(NSString*)day{
    return [self modifyNickName:nil andSignature:nil andHeight:0 andWeight:0 andYear:year andMonth:month andDay:day andSex:0 updateType:4];
}
- (NSDictionary*)modifySex:(int)sex{
    return [self modifyNickName:nil andSignature:nil andHeight:0 andWeight:0 andYear:0 andMonth:0 andDay:0 andSex:sex updateType:7];
}


/**
 修改用户信息 总入口
*/
- (NSDictionary*)modifyNickName:(NSString*)nickName
                   andSignature:(NSString*)signature
                      andHeight:(CGFloat)height
                      andWeight:(CGFloat)weight
                        andYear:(NSString*)year
                       andMonth:(NSString*)month
                         andDay:(NSString*)day
                         andSex:(int)sex
                     updateType:(int)baseTypeUpdate
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [RequestParameters buildNumberDictionary:dic addKey:@"baseTypeUpdate" addValue:[NSNumber numberWithInt:baseTypeUpdate]];
    
    
    switch (baseTypeUpdate) {
        case 1: //  更新全部
            if(baseTypeUpdate == 1)
            {
                // 昵称
                [RequestParameters buildStrDictionary:dic addKey:kParamNickname addValue:nickName];
                // 签名
                signature = @"我想做出一些积极的改变";
                
                [RequestParameters buildStrDictionary:dic addKey:@"signature" addValue:signature];
                // 性别
                if(sex != 0 && sex != 1){
                    sex = 0;
                }
                [RequestParameters buildNumberDictionary:dic addKey:kParamSex addValue:[NSNumber numberWithInt:sex]];
                // 体重
                [RequestParameters buildNumberDictionary:dic addKey:kParamWeight addValue:[NSNumber numberWithFloat:weight]];
                // 身高
                [RequestParameters buildNumberDictionary:dic addKey:kParamHeight addValue:[NSNumber numberWithFloat:height]];
                
                // 年
                [RequestParameters buildStrDictionary:dic addKey:kParamYear addValue:year];
                // 月
                [RequestParameters buildStrDictionary:dic addKey:kParamMonth addValue:month];
                // 日
                [RequestParameters buildStrDictionary:dic addKey:kParamDay addValue:day];
                
            }
            break;
        case 2: // 更新签名
            [RequestParameters buildStrDictionary:dic addKey:@"signature" addValue:signature];
            break;
        case 3:// 昵称
            [RequestParameters buildStrDictionary:dic addKey:kParamNickname addValue:nickName];
            break;
        case 4:// 年龄
            // 年
            [RequestParameters buildStrDictionary:dic addKey:kParamYear addValue:year];
            // 月
            [RequestParameters buildStrDictionary:dic addKey:kParamMonth addValue:month];
            // 日
            [RequestParameters buildStrDictionary:dic addKey:kParamDay addValue:day];
            break;
        case 5:// 身高
            [RequestParameters buildNumberDictionary:dic addKey:kParamHeight addValue:[NSNumber numberWithFloat:height]];
            break;
        case 6:// 体重
            [RequestParameters buildNumberDictionary:dic addKey:kParamWeight addValue:[NSNumber numberWithFloat:weight]];
            break;
        case 7:// 性别
            if(sex != 0 && sex != 1){
                sex = 0;
            }
            [RequestParameters buildNumberDictionary:dic addKey:kParamSex addValue:[NSNumber numberWithInt:sex]];
            break;
            
        default:
            break;
            
    }
    
    return [self genParameters:dic];
}


/* 构建 NSString 类型的 字典item*/
+ (void)buildStrDictionary:(NSMutableDictionary *)dic
                addKey :(NSString *) key
               addValue:(NSString *)data{
    if(key && data){
        [dic setObject:data forKey:key];
    }
}

/* 构建 NSNumber 类型的 字典item*/
+ (void)buildNumberDictionary:(NSMutableDictionary *)dic
                   addKey :(NSString *) key
                  addValue:(NSNumber *)data{
    if(key && data){
        [dic setValue:data forKey:key];
    }
}






- (NSDictionary*)getTimeLineData:(int)messageId direction:(int)direction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:messageId] forKey:kParamId];
    [dic setObject:[NSNumber numberWithInt:10] forKey:@"size"];
    [dic setObject:[NSNumber numberWithInt:direction] forKey:kParamDirection];
    return [self genParameters:dic];
}

- (NSDictionary*)getUserModels
{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    return [self genParameters:nil];
}

- (NSDictionary*)deleteTimeLineMessage:(long)messageId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Button001" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithLong:messageId] forKey:kParamMessageId];
    return [self genParameters:dic];
}

- (NSDictionary*)getHiModulesList
{
    return [self genParameters:nil];
}

- (NSDictionary*)getMyModulesList:(int)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //[dic setObject:@"Button001" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:page] forKey:kParamPageOffSet];
    [dic setObject:[NSNumber numberWithInt:20] forKey:kParamPageSize];
    return [self genParameters:dic];
}

- (NSDictionary*)getMyHabitList
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    return [self genParameters:dic];
}

- (NSDictionary*)getHomePageInfo:(int)userId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:userId] forKey:kParamUserId];
    return [self genParameters:dic];
}

- (NSDictionary*)addOneModule:(int)moduleId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:moduleId] forKey:kParamModelId];
    return [self genParameters:dic];
}

- (NSDictionary*)deleteOneModule:(int)moduleId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:moduleId] forKey:kParamModelId];
    return [self genParameters:dic];
}

- (NSDictionary*)subscriptionModules:(NSString *)subscriptionModelList
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:subscriptionModelList forKey:kParamsubscription];
    return [self genParameters:dic];
}

- (NSDictionary*)deleteOneHabit:(int)habitId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:habitId] forKey:kParamHabitId];
    return [self genParameters:dic];
}

- (NSDictionary*)getFollowFriends:(int)pageIndex userId:(int)userId;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:pageIndex] forKey:kParamPage];
    [dic setObject:[NSNumber numberWithInt:50] forKey:kParamPageSize];
    [dic setObject:[NSNumber numberWithInt:userId] forKey:kParamUserId];
    return [self genParameters:dic];
}

- (NSDictionary*)uploadImagetype:(int)type
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:type] forKey:kParamType];
    return [self genParameters:dic];
}

- (NSDictionary*)publishPost:(int)weiboType
                     content:(NSString*)content
                     habitId:(int)HOrMId
                       paths:(NSArray*)paths
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInt:HOrMId] forKey:@"id"];
    if (content) {
        [dic setObject:content forKey:@"content"];
    }
    for (int i = 0; i < paths.count; i++) {
        NSString *path = [paths objectAtIndex:i];
        if (path.length>0) {
            NSString *key = [NSString stringWithFormat:@"pic_addr_0%i",i+1];
            [dic setObject:path forKey:key];
        }else{
            break;
        }
    }
    return [self genParameters:dic];
}

- (NSDictionary*)getPostDetail:(int)weiboType
                       weiboId:(int)weiboId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInt:weiboId] forKey:@"weiboId"];
    return [self genParameters:dic];
}

- (NSDictionary*)getMyPost:(int)pageOffset
                    userId:(long)userId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:pageOffset] forKey:@"pageOffset"];
    [dic setObject:[NSNumber numberWithInt:100] forKey:@"pageSize"];
    [dic setObject:[NSNumber numberWithLong:userId] forKey:@"userId"];
    return [self genParameters:dic];
}

- (NSDictionary*)follow:(BOOL)isfollow followId:(int)followId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"Page0010" forKey:kParamModuleCode];
    [dic setObject:[NSNumber numberWithInt:followId] forKey:@"followId"];
    return [self genParameters:dic];
}

- (NSDictionary*)getPostListType:(int)weiboType
                        moduleId:(int)modelId
                         habitId:(int)habitId
                      pageOffset:(int)pageOffset
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:weiboType] forKey:@"weiboType"];
    [dic setObject:[NSNumber numberWithInt:pageOffset] forKey:@"pageOffset"];
    [dic setObject:[NSNumber numberWithInt:100] forKey:@"pageSize"];
    
    [dic setObject:[NSNumber numberWithInt:modelId] forKey:@"modelId"];
    [dic setObject:[NSNumber numberWithInt:habitId] forKey:@"habitId"];
    
    return [self genParameters:dic];
}

- (NSDictionary*)getPostFindType:(int)type pageOffset:(int)pageOffset
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [dic setObject:[NSNumber numberWithInt:pageOffset] forKey:@"pageOffset"];
    [dic setObject:[NSNumber numberWithInt:100] forKey:@"pageSize"];
    return [self genParameters:dic];
}

- (NSDictionary*)uploadSudoGameId:(int)gameId
                       withDegree:(int)degree
                         withFlag:(int)flag
                    withSpendTime:(int)spendTime
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:gameId] forKey:@"gameId"];
    [dic setObject:[NSNumber numberWithInt:degree] forKey:@"degree"];
    [dic setObject:[NSNumber numberWithInt:flag] forKey:@"flag"];
    [dic setObject:[NSNumber numberWithInt:spendTime] forKey:@"spendTime"];
    return [self genParameters:dic];
}

- (NSDictionary*)shareToMyFuns:(int)modelId
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:modelId] forKey:@"modelId"];
    return [self genParameters:dic];
}

- (NSDictionary*)suggestWithContent:(NSString*)suggest
                          withPhone:(NSString*)telephone
                          withEmail:(NSString*)email
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"source"];
    [dic setObject:suggest forKey:@"suggest"];
    [dic setObject:telephone forKey:@"telephone"];
    [dic setObject:email forKey:@"email"];
    return [self genParameters:dic];
}

@end
