//
//  RequestParameters.h
//  GuanHealth
//
//  Created by hermit on 15/2/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestParameters : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(RequestParameters, shareInstance);

- (NSDictionary*)genParameters:(NSDictionary*)dic;

- (NSDictionary*)registerWithPhone:(NSString*)phoneNumber
                 sourceAccountType:(int)sourceAccountType;

- (NSDictionary*)resetPassword:(NSString*)password
                      andPhone:(NSString*)phone;

- (NSDictionary*)findPwdPhone:(NSString *)phone;

- (NSDictionary*)registerWithPhone:(NSString*)phoneNumber
                          codeType:(int)codeType
                  verificationCode:(NSString*)verificationCode;

- (NSDictionary*)registerWithPhone:(NSString *)phoneNumber
                          password:(NSString *)password
                 sourceAccountType:(int)sourceAccountType
                        deviceType:(int)deviceType;

- (NSDictionary*)setUserInfo:(NSInteger)sex
                      height:(CGFloat)height
                      weight:(CGFloat)weight;

- (NSDictionary*)getUserInfo;

- (NSDictionary*)loginWithPhone:(NSString*)account
                       password:(NSString*)passWord
                          photo:(NSString*)photo
                       nickName:(NSString*)nickName
                            sex:(NSInteger)sex
                           type:(NSInteger)sourceAccountType;


- (NSDictionary*)logoutParamers;

- (NSDictionary*)modifyNickName:(NSString*)nickName
                   andSignature:(NSString*)signature
                      andHeight:(CGFloat)height
                      andWeight:(CGFloat)weight
                        andYear:(NSString*)year
                       andMonth:(NSString*)month
                         andDay:(NSString*)day
                         andSex:(int)sex
                     updateType:(int)baseTypeUpdate;

- (NSDictionary*)modifyNickName:(NSString*)nickName;
- (NSDictionary*)modifySignature:(NSString*)signature;
- (NSDictionary*)modifyHeight:(CGFloat)height;
- (NSDictionary*)modifyWeight:(CGFloat)weight;
- (NSDictionary*)modifyBirthday:(NSString*)year
                       andMonth:(NSString*)month
                         andDay:(NSString*)day;
- (NSDictionary*)modifySex:(int)sex;

- (NSDictionary*)getTimeLineData:(int)messageId direction:(int)direction;

- (NSDictionary*)getUserModels;

- (NSDictionary*)deleteTimeLineMessage:(long)messageId;

- (NSDictionary*)getHiModulesList;

- (NSDictionary*)getMyModulesList:(int)page;

- (NSDictionary*)getMyHabitList;

- (NSDictionary*)getHomePageInfo:(int)userId;

- (NSDictionary*)addOneModule:(int)moduleId;

- (NSDictionary*)deleteOneModule:(int)moduleId;

- (NSDictionary*)subscriptionModules:(NSString *)subscriptionModelList;

- (NSDictionary*)deleteOneHabit:(int)habitId;

- (NSDictionary*)getFollowFriends:(int)pageIndex userId:(int)userId;

- (NSDictionary*)uploadImagetype:(int)type;

//add for shi_dongdong
- (NSDictionary *)subscribeInfo:(BOOL)bSubscribe;

- (NSDictionary *)likeUsersListWithType:(NSInteger)weiboType wbID:(NSInteger)weiboID;

- (NSDictionary *)commentUsersListWithType:(NSInteger)weiboType wbID:(NSInteger)weiboID;

- (NSDictionary *)SubmitCommentsWithType:(NSInteger)weiboType
                                    wbID:(NSInteger)weiboID
                                authorID:(NSInteger)authorID
                                 content:(NSString *)content;

- (NSDictionary *)submitLikeWithType:(NSInteger)weiboType wbID:(NSInteger)weiboID;
//add end

- (NSDictionary*)publishPost:(int)weiboType
                     content:(NSString*)content
                     habitId:(int)HOrMId
                       paths:(NSArray*)paths;

- (NSDictionary*)getPostDetail:(int)weiboType
                       weiboId:(int)weiboId;

- (NSDictionary*)getMyPost:(int)pageOffset
                    userId:(long)userId;

- (NSDictionary*)follow:(BOOL)isfollow followId:(int)followId;

- (NSDictionary*)getPostListType:(int)weiboType
                        moduleId:(int)modelId
                         habitId:(int)habitId
                      pageOffset:(int)pageOffset;

- (NSDictionary*)getPostFindType:(int)type pageOffset:(int)pageOffset;

- (NSDictionary*)uploadSudoGameId:(int)gameId
                       withDegree:(int)degree
                         withFlag:(int)flag
                    withSpendTime:(int)spendTime;

- (NSDictionary*)shareToMyFuns:(int)modelId;

- (NSDictionary*)suggestWithContent:(NSString*)suggest
                          withPhone:(NSString*)telephone
                          withEmail:(NSString*)email;


@end
