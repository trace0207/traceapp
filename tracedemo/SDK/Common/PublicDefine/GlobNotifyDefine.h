//
//  GlobNotifyDefine.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/28.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#ifndef GuanHealth_GlobNotifyDefine_h
#define GuanHealth_GlobNotifyDefine_h

//Notification
//#define kNotificationWeather            @"getWeather"
#define kNotificationHabitRefresh       @"refreshHabitData"
#define ReloadMianForLocalNotification  @"reloadMianForLocalNotification"

#define DeletePostNoticaition           @"deletePostNoticaition"

#define PublishSuccessNotification      @"publishSuccessNotification"

#define HFApplicationWillResignActive   @"applicationWillResignActive"
#define HFApplicationDidBecomeActive    @"applicationDidBecomeActive"
#define HFGoHabitViewController         @"goHabitViewController"
#define HFCheckMessageUnreadCount       @"checkMessageUnreadCount"


#define KUnBindBandNotication           @"kUnBindBandNotication"
#define KBindBandNotication             @"kBindBandNotication"



#define TKUserLoginSuccess              @"tk_userLoginSuccessed"// 用户登录请求成功，或者等价登录请求成功
#define TKUserInfoChange                @"tk_userInfoChanged" //用户信息更新
#define TKUserLoginBackEvent            @"tk_userLoginBackEvent"// 班开放式登录页面登录成功后 通知响应的UI刷新
#define TKBrandCategoryReady            @"tk_BrandAndCategoryReady"// 类目和品牌准备OK
#define TKPayNotify                     @"tk_pingppPayResult"// 支付成功
#define TKUserLoginOut                  @"tk_userLoginOut"// 用户退出

#define TKPubishRewardSuccess           @"tk_publishrewardSuccess" //发布悬赏成功
#define TKPublishShowGoodsSuccess       @"tk_publishShowGoodsSuccess"// 发布晒单成功

#endif
