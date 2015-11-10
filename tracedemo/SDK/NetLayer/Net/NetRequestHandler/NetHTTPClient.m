//
//  NetHTTPClient.m
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "NetHTTPClient.h"
#import "ResponseData.h"
#import "ParseResult.h"
#import "RequestParameters.h"
#import "Reachability.h"
@implementation NetHTTPClient
@synthesize netState = _netState;
SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(NetHTTPClient, shareInstance);

- (instancetype)init{
    self = [super initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",kBaseURL]]];
    if (!self) {
        return nil;
    }
    
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//    
//    
//    //由于AFNetwork异步执行，所以采用同步执行的Reachability
//    Reachability * reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    if ([reachability currentReachabilityStatus] == NotReachable)
//    {
//        _isNetReachable = NO;
//    }
//    else
//    {
//        _isNetReachable = YES;
//    }
//    
//    WS(weakSelf);
//    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        _netState = status;
//        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
//            [weakSelf setIsNetReachable:YES];
//        }else{
//            [weakSelf setIsNetReachable:NO];
//        }
//    }];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return self;
}

- (BOOL)checkNetWork
{
    return self.isNetReachable;
}


- (void)cancelNetHTTPClientOperations{
    NSOperationQueue* operationQueue = [[NetHTTPClient shareInstance] operationQueue];
    NSArray* operations = [operationQueue operations];
    for (AFURLConnectionOperation *operaion in operations) {
        [operaion cancel];
        [operaion setCompletionBlock:nil];
    }
}

- (void)httpAction:(E_HTTPMethod)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
        parseBlock:(ParseBlock)block
              show:(BOOL)isShow
          callback:(netCallBackBlock)callback
{
    [self httpAction:method path:path parameters:parameters imageParamter:nil parseBlock:block show:isShow callback:callback];
}

- (void)httpAction:(E_HTTPMethod)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
     imageParamter:(UIImage*)imageParamter
        parseBlock:(ParseBlock)block
              show:(BOOL)isShow
          callback:(netCallBackBlock)callback
{
//    if (![self isNetReachable]) {
//        ResponseData * data = [[ResponseData alloc] init];
//        if (callback)
//        {
//            callback(data);
//        }
//        [[HFHUDView shareInstance] ShowTips:data.msg delayTime:1.0 atView:NULL];
//        return ;
//    }
    if (isShow) {
        if (self.HUD != nil) {
            [self.HUD hide:YES];
        }
        
        self.HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication]keyWindow] animated:YES];
    }
    [self httpAction:method path:path parameters:parameters fileParameters:imageParamter appendOpetaion:^(AFHTTPRequestOperation *operation) {
    } parseBlock:block
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 DDLogDebug(@"ACK : %@/%@ \n data:%@",self.baseURL, path,responseObject);
                 
                 if (isShow)
                 {
                     [self.HUD hide:YES];
                 }
                 
                 ResponseData * data = [[ResponseData alloc] init];
                 [data parseJSON:responseObject];
                 
                 if ([data success])
                 {
                     
                     if (block)
                     {
                         data = block(responseObject);
                     }
                     
                     if (callback)
                     {
                         callback(data);
                     }
                 }
                 else
                 {
                     if (callback)
                     {
                         callback(data);
                     }
                     if (![data.msg isKindOfClass:[NSNull class]])
                     {
                         [[HFHUDView shareInstance] ShowTips:data.msg delayTime:1.0 atView:NULL];
                     }
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 DDLogDebug(@"ACK : 【%@/%@】【failure】/n error = %@", self.baseURL,path,error);
                 
                 ResponseData * data = [[ResponseData alloc] init];
                 if (callback)
                 {
                     callback(data);
                 }
                 
                 //进行错误码提示
                 if (isShow)
                 {
                     [self.HUD hide:YES];
                     [[HFHUDView shareInstance] ShowTips:_T(@"HF_Common_Check_Net") delayTime:1.0 atView:NULL];
                     
                 }
             }];
}

- (void)checkPhone:(NSString*)number
          callback:(netCallBackBlock)callback;
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/user/user!findPassword.action"
          parameters:[[RequestParameters shareInstance]findPwdPhone:number]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)registerWithPhone:(NSString*)phone
        sourceAccountType:(int)sourceAccountType
                 callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/user/user!checkPhoneNumber.action"
          parameters:[[RequestParameters shareInstance]registerWithPhone:phone sourceAccountType:sourceAccountType]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)checkVercode:(NSString*)number
            codeType:(int)codeType
             vercode:(NSString*)vercode
            callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/sms/sms-message!verifySMSCode.action"
          parameters:[[RequestParameters shareInstance]registerWithPhone:number codeType:codeType verificationCode:vercode]
          parseBlock:nil
                show:YES
            callback:callback];
}

//- (void)setUserInfo:(NSInteger)sex
//          andHeight:(double)height
//          andWeight:(double)weight
//           callback:(netCallBackBlock)callback
//{
//    [self httpAction:E_POST
//                path:@"CloudHealth/req/mobile/common/user/user-base-info!doAddSimpleBaseInfo.action"
//          parameters:[[RequestParameters shareInstance]setUserInfo:sex height:height weight:weight]
//          parseBlock:nil
//                show:YES
//            callback:callback];
//}

- (void)getUserInfo:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/user/user-base-info!doGetBaseInfo.action"
          parameters:[[RequestParameters shareInstance]getUserInfo]
          parseBlock:nil
                show:NO
            callback:callback];
}

//控制打开推送和取消推送
- (void)switchSubscribeAppStauts:(BOOL)bStauts callBack:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/user/user-base-info!doSavePushSwitchByUserID.action"
          parameters:[[RequestParameters shareInstance] subscribeInfo:bStauts]
          parseBlock:nil
                show:YES
            callback:callback];
}

//获取点赞列表
- (void)requestLikeUsersListWithType:(NSInteger)weiboType
                                  ID:(NSInteger)weiboID
                            callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo!weiBoPraiseUserList.action"
          parameters:[[RequestParameters shareInstance] likeUsersListWithType:weiboType wbID:weiboID]
          parseBlock:nil
                show:NO
            callback:callback];
}

//请求评论详情列表
- (void)requestCommentUsersListWithType:(NSInteger)weiboType
                                     ID:(NSInteger)weiboID
                               callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo-comment!listWeiboComment.action"
          parameters:[[RequestParameters shareInstance] commentUsersListWithType:weiboType wbID:weiboID]
          parseBlock:nil
                show:NO
            callback:callback];
}
//提交评论
- (void)submitCommentInfosWithType:(NSInteger)weiboType
                                ID:(NSInteger)weiboID
                          authorID:(NSInteger)authorID
                           content:(NSString *)content
                          callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo-comment!publishWeiboComment.action"
          parameters:[[RequestParameters shareInstance] SubmitCommentsWithType:weiboType
                                                                          wbID:weiboID
                                                                      authorID:authorID
                                                                       content:content]
          parseBlock:nil
                show:YES
            callback:callback];
}
//点赞
- (void)submitCommentLikeWithType:(NSInteger)weiboType
                               ID:(NSInteger)weiboID
                         callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo!weiBoUserPraise.action"
          parameters:[[RequestParameters shareInstance] submitLikeWithType:weiboType wbID:weiboID]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)login:(NSString*)account
     password:(NSString*)passWord
     nickName:(NSString*)nickName
        photo:(NSString*)photo
          sex:(NSInteger)sex
         Type:(NSInteger)sourceAccountType
     callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/user/login!userLogin.action"
          parameters:[[RequestParameters shareInstance]loginWithPhone:account password:passWord photo:photo nickName:nickName sex:sex type:sourceAccountType]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)registerWithPhone:(NSString*)phone
                 password:(NSString*)password
        sourceAccountType:(int)sourceAccountType
               deviceType:(int)deviceType
                 callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/user/user!register.action"
          parameters:[[RequestParameters shareInstance]registerWithPhone:phone password:password sourceAccountType:sourceAccountType deviceType:deviceType]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)logoutAction:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/user/login!logout.action"
          parameters:[[RequestParameters shareInstance]logoutParamers]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)modifyNickname:(NSString*)nickname
          andSignature:(NSString*)signature
             andHeight:(CGFloat)height
             andWeight:(CGFloat)weight
               andYear:(NSString*)year
              andMonth:(NSString*)month
                andDay:(NSString*)day
                andSex:(int)sex
            updateType:(int)type
              callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/user/user-base-info!doModBaseInfo.action"
          parameters:[[RequestParameters shareInstance]modifyNickName:nickname andSignature:signature andHeight:height andWeight:weight andYear:year andMonth:month andDay:day andSex:sex updateType:type]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getTimeLineData:(int)messageId
              direction:(int)direction
               callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/user/user-timeline!getTimeLineRecord.action"
          parameters:[[RequestParameters shareInstance]getTimeLineData:messageId direction:direction]
          parseBlock:nil
                show:NO
            callback:callback];
}

//- (void)getModules:(netCallBackBlock)callback
//{
//    [self httpAction:E_POST
//                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!listUserModel.action"
//          parameters:[[RequestParameters shareInstance]getUserModels]
//          parseBlock:parseModules
//                show:NO
//            callback:callback];
//}


- (void)deleteTimeLineMessage:(long)messageId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/user/user-timeline!deleteTimelineMessage.action"
          parameters:[[RequestParameters shareInstance]deleteTimeLineMessage:messageId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getHiModulesList:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!listModel.action"
          parameters:[[RequestParameters shareInstance]getHiModulesList]
          parseBlock:nil
                show:NO
            callback:callback];
}

- (void)getMyModuleList:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!listUserModel.action"
          parameters:[[RequestParameters shareInstance]getUserModels]
          parseBlock:nil
                show:NO
            callback:callback];
}

- (void)getMyHabitList:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/habit/habit!loadHabitPage.action"
          parameters:[[RequestParameters shareInstance]getMyHabitList]
          parseBlock:nil
                show:NO
            callback:callback];
}

- (void)getHomePage:(int)userId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/homepage/personal-home-page!getHomePageInfo.action"
          parameters:[[RequestParameters shareInstance]getHomePageInfo:userId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)addOneModule:(int)modelId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!subscribeSingleModel.action"
          parameters:[[RequestParameters shareInstance]addOneModule:modelId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)deleteOneModule:(int)modelId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!unSubscribeSingleModel.action"
          parameters:[[RequestParameters shareInstance]deleteOneModule:modelId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)subscriptionModules:(NSString*)subscriptionModelList callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!subscriptionModel.action"
          parameters:[[RequestParameters shareInstance]subscriptionModules:subscriptionModelList]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)deleteOneHabit:(int)habitId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/habit/habit!deleteHabit.action"
          parameters:[[RequestParameters shareInstance]deleteOneHabit:habitId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getFollows:(int)pageIndex andUserId:(int)userId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/homepage/personal-home-page!getFollow.action"
          parameters:[[RequestParameters shareInstance]getFollowFriends:pageIndex userId:userId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getFuns:(int)pageIndex andUserId:(int)userId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/homepage/personal-home-page!getFans.action"
          parameters:[[RequestParameters shareInstance]getFollowFriends:pageIndex userId:userId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)uploadImage:(UIImage *)image type:(int)type callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/upload/single-img-upload!upload.action"
          parameters:[[RequestParameters shareInstance]uploadImagetype:type]
       imageParamter:image
          parseBlock:nil
                show:NO
            callback:callback];
}

- (void)uploadImage:(UIImage *)image type:(int)type showToast:(bool) show callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/upload/single-img-upload!upload.action"
          parameters:[[RequestParameters shareInstance]uploadImagetype:type]
       imageParamter:image
          parseBlock:nil
                show:show
            callback:callback];
}

- (void)publishPost:(int)weiboType
            content:(NSString*)content
            habitId:(int)HorMId
              paths:(NSArray*)paths
           callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo!recordWeibo.action"
          parameters:[[RequestParameters shareInstance]publishPost:weiboType content:content habitId:HorMId paths:paths]
          parseBlock:nil
                show:NO
            callback:callback];
}

- (void)getPostDetailType:(int)weiboType andId:(int)weiboId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo!weiBoInfo.action"
          parameters:[[RequestParameters shareInstance]getPostDetail:weiboType weiboId:weiboId]
          parseBlock:nil
                show:NO
            callback:callback];
}

- (void)getPostListOffset:(int)pageOffSet andUserId:(long)userId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo!userWeiBoList.action"
          parameters:[[RequestParameters shareInstance]getMyPost:pageOffSet userId:userId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getPostListoffset:(int)pageOffSet
                  andType:(int)weiboType
                 moduleId:(int)modleId
                  habitId:(int)habitId
                 callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/weibo/weibo!listWeiboByType.action"
          parameters:[[RequestParameters shareInstance]getPostListType:weiboType moduleId:modleId habitId:habitId pageOffset:pageOffSet]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)followAction:(BOOL)isFollow andfollowId:(int)followId callback:(netCallBackBlock)callback
{
    NSString *url = nil;
    if (isFollow) {
        url = @"CloudHealth/req/mobile/common/homepage/personal-home-page!follow.action";
    }else{
        url = @"CloudHealth/req/mobile/common/homepage/personal-home-page!cancelFollow.action";
    }
    [self httpAction:E_POST
                path:url
          parameters:[[RequestParameters shareInstance]follow:isFollow followId:followId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getPostListoffset:(int)pageOffset findType:(int)type callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/find/find!findMoodByType.action"
          parameters:[[RequestParameters shareInstance]getPostFindType:type pageOffset:pageOffset]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)setPassword:(NSString *)password andPhone:(NSString *)phone callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/mobile/common/user/user!resetPassWord.action"
          parameters:[[RequestParameters shareInstance]resetPassword:password andPhone:phone]
          parseBlock:nil
                show:YES
            callback:callback];
}

//- (void)getSudoKuAction:(netCallBackBlock)callback
//{
//    [self httpAction:E_POST
//                path:@"CloudHealth/req/mobile/common/game/sudoku!getSudoku.action"
//          parameters:[[RequestParameters shareInstance]genParameters:nil]
//          parseBlock:parseGetSudoKu
//                show:YES
//            callback:callback];
//}

- (void)uploadGameId:(int)gameId
          withDegree:(int)degree
            withFlag:(int)flag
       withSpendTime:(int)spendTime
            callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/game/sudoku!insertCompletionTime.action"
          parameters:[[RequestParameters shareInstance]uploadSudoGameId:gameId withDegree:degree withFlag:flag withSpendTime:spendTime]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getFriendsRank:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/game/sudoku!selectRankListInIdol.action"
          parameters:[[RequestParameters shareInstance]genParameters:nil]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)getWorldRank:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/game/sudoku!selectRankListInAll.action"
          parameters:[[RequestParameters shareInstance]genParameters:nil]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)showToMyFuns:(int)modelId callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/haimodule/hai-module!shareToMyFans.action"
          parameters:[[RequestParameters shareInstance]shareToMyFuns:modelId]
          parseBlock:nil
                show:YES
            callback:callback];
}

- (void)feedbackWithSuggest:(NSString *)suggest
                  withPhone:(NSString *)phone
                  withEmail:(NSString *)email
                   callback:(netCallBackBlock)callback
{
    [self httpAction:E_POST
                path:@"CloudHealth/req/mobile/common/feedback/feed-back!saveUserSuggestion.action"
          parameters:[[RequestParameters shareInstance]suggestWithContent:suggest withPhone:phone withEmail:email]
          parseBlock:nil
                show:YES
            callback:callback];
}

@end
