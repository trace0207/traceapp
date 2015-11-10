//
//  NetHTTPClient.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseHTTPClient.h"
#import "Singleton.h"

typedef void (^NetWorkStuatsBlock)(BOOL bNet);

@interface NetHTTPClient : BaseHTTPClient

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(NetHTTPClient, shareInstance);

@property (nonatomic, assign) BOOL isNetReachable;

@property (nonatomic, assign) AFNetworkReachabilityStatus netState;

@property (nonatomic, weak) MBProgressHUD *HUD;

- (void)cancelNetHTTPClientOperations;

- (void)checkPhone:(NSString*)number
          callback:(netCallBackBlock)callback;

- (void)registerWithPhone:(NSString*)phone
        sourceAccountType:(int)sourceAccountType
                 callback:(netCallBackBlock)callback;

- (void)checkVercode:(NSString*)number
            codeType:(int)codeType
             vercode:(NSString*)vercode
            callback:(netCallBackBlock)callback;

- (void)login:(NSString*)account
     password:(NSString*)passWord
     nickName:(NSString*)nickName
        photo:(NSString*)photo
          sex:(NSInteger)sex
         Type:(NSInteger)sourceAccountType
     callback:(netCallBackBlock)callback;

- (void)registerWithPhone:(NSString*)phone
                 password:(NSString*)password
        sourceAccountType:(int)sourceAccountType
               deviceType:(int)deviceType
                 callback:(netCallBackBlock)callback;

- (void)getUserInfo:(netCallBackBlock)callback;

- (void)modifyNickname:(NSString*)nickname
          andSignature:(NSString*)signature
             andHeight:(CGFloat)height
             andWeight:(CGFloat)weight
               andYear:(NSString*)year
              andMonth:(NSString*)month
                andDay:(NSString*)day
                andSex:(int)sex
            updateType:(int)type
              callback:(netCallBackBlock)callback;

- (void)logoutAction:(netCallBackBlock)callback;

- (void)getTimeLineData:(int)messageId
              direction:(int)direction
               callback:(netCallBackBlock)callback;

//add by shi_dongdong
//subscribe
- (void)switchSubscribeAppStauts:(BOOL)bStauts
                        callBack:(netCallBackBlock)callback;

- (void)requestLikeUsersListWithType:(NSInteger)weiboType
                                  ID:(NSInteger)weiboID
                            callback:(netCallBackBlock)callback;

- (void)requestCommentUsersListWithType:(NSInteger)weiboType
                                     ID:(NSInteger)weiboID
                               callback:(netCallBackBlock)callback;

- (void)submitCommentInfosWithType:(NSInteger)weiboType
                                ID:(NSInteger)weiboID
                          authorID:(NSInteger)authorID
                           content:(NSString *)content
                          callback:(netCallBackBlock)callback;

- (void)submitCommentLikeWithType:(NSInteger)weiboType
                               ID:(NSInteger)weiboID
                         callback:(netCallBackBlock)callback;
//add end

- (void)deleteTimeLineMessage:(long)messageId callback:(netCallBackBlock)callback;

- (void)getHiModulesList:(netCallBackBlock)callback;

- (void)getMyModuleList:(netCallBackBlock)callback;

- (void)getMyHabitList:(netCallBackBlock)callback;

- (void)getHomePage:(int)userId callback:(netCallBackBlock)callback;

- (void)addOneModule:(int)modelId callback:(netCallBackBlock)callback;

- (void)deleteOneModule:(int)modelId callback:(netCallBackBlock)callback;

- (void)subscriptionModules:(NSString*)subscriptionModelList callback:(netCallBackBlock)callback;

- (void)deleteOneHabit:(int)habitId callback:(netCallBackBlock)callback;

- (void)getFollows:(int)pageIndex andUserId:(int)userId callback:(netCallBackBlock)callback;

- (void)getFuns:(int)pageIndex andUserId:(int)userId callback:(netCallBackBlock)callback;

- (void)uploadImage:(UIImage *)image type:(int)type callback:(netCallBackBlock)callback;
- (void)uploadImage:(UIImage *)image type:(int)type showToast:(bool) show callback:(netCallBackBlock)callback;

- (void)publishPost:(int)weiboType
            content:(NSString*)content
            habitId:(int)HorMId
              paths:(NSArray*)paths
           callback:(netCallBackBlock)callback;

- (void)getPostDetailType:(int)weiboType andId:(int)weiboId callback:(netCallBackBlock)callback;

- (void)getPostListOffset:(int)pageOffSet andUserId:(long)userId callback:(netCallBackBlock)callback;

- (void)getPostListoffset:(int)pageOffSet
                  andType:(int)weiboType
                 moduleId:(int)modleId
                  habitId:(int)habitId
                 callback:(netCallBackBlock)callback;

- (void)followAction:(BOOL)isFollow andfollowId:(int)followId callback:(netCallBackBlock)callback;

- (void)getPostListoffset:(int)pageOffset findType:(int)type callback:(netCallBackBlock)callback;

- (void)setPassword:(NSString *)password andPhone:(NSString *)phone callback:(netCallBackBlock)callback;

- (void)getSudoKuAction:(netCallBackBlock)callback;

- (void)uploadGameId:(int)gameId
          withDegree:(int)degree
            withFlag:(int)flag
       withSpendTime:(int)spendTime
            callback:(netCallBackBlock)callback;

- (void)getFriendsRank:(netCallBackBlock)callback;

- (void)getWorldRank:(netCallBackBlock)callback;

- (void)showToMyFuns:(int)modelId callback:(netCallBackBlock)callback;

- (void)feedbackWithSuggest:(NSString *)suggest
                  withPhone:(NSString *)phone
                  withEmail:(NSString *)email
                   callback:(netCallBackBlock)callback;

- (BOOL)checkNetWork;

@end
