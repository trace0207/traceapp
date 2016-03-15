
//
//  GlobConfig.h
//  GuanHealth
//
//  Created by hermit on 15/2/10.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#ifndef GuanHealth_GlobConfig_h
#define GuanHealth_GlobConfig_h

//判断设备的屏幕尺寸
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_SCREEN_47_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_SCREEN_55_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判定系统版本号
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)

#define IOS8VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IOS7VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define kScreenBounds   [[UIScreen mainScreen]bounds]
#define kScreenWidth    [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen]bounds].size.height
#define kScreenScale    (kScreenWidth/320.0f)
#define kWidthScale    (kScreenWidth/375.0f)
#define kHeightScale    (kScreenWidth/667.0f)

#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kFileManager        [NSFileManager defaultManager]
//#define  _T(x)           NSLocalizedString(x, nil)
//#define  IMG(x)          [UIImage imageNamed:x]

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
//颜色和透明度设置
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//URL

//#if DEBUG
#define kBaseURL    @"http://183.131.13.104:8080"  //开发环境
//#define kBaseURL    @"http://183.131.13.113:8080"  //测试环境
//#define kBaseURL    @"http://183.131.13.104"  //商用环境
//#define kBaseURL    @"http://183.131.13.113"  //预发布环境
//#define kBaseURL    @"http://192.168.50.33:8080"  //开发本地路径
//#else
//#define kBaseURL    @"http://183.131.13.104"     //商用环境
//#define kBaseURL    @"http://183.131.13.113"   //预发布环境
//#define kBaseURL    @"http://183.131.13.113:8080"   //测试环境

//#endif

//#define kURLCheckSelf   [NSString stringWithFormat:@"%@/test/healthtest.html",kBaseURL]
#define kURLActivity      [NSString stringWithFormat:@"%@/test/active.html",kBaseURL]

#define kURLHotFriends    [NSString stringWithFormat:@"%@/CloudHealth/web/friends.html?init=1",kBaseURL]

#define kURLMyFriends     [NSString stringWithFormat:@"%@/CloudHealth/web/friends.html",kBaseURL]

#define kURLHabitList     [NSString stringWithFormat:@"%@/CloudHealth/web/habitlist.html",kBaseURL]

//#define kURLHabitSet      [NSString stringWithFormat:@"%@/CloudHealth/web/habitadd.html",kBaseURL]
#define kURLHabitAdd      [NSString stringWithFormat:@"%@/CloudHealth/web/habitadd.html?id=",kBaseURL]

#define kURLModuleDisease [NSString stringWithFormat:@"%@/CloudHealth/web/mod_ills.html",kBaseURL]

#define kURLModuleCheckTool [NSString stringWithFormat:@"%@/CloudHealth/web/mod_selftest.html",kBaseURL]

#define kURLModuleHelp    [NSString stringWithFormat:@"%@/CloudHealth/web/mod_regimen.html",kBaseURL]

#define kURLModuleCheckHealth [NSString stringWithFormat:@"%@/CloudHealth/web/mod_selfcheck.html",kBaseURL]

#define kURLModuleCalorie [NSString stringWithFormat:@"%@/CloudHealth/web/mod_calorie.html",kBaseURL]

#define kURLModuleInformation [NSString stringWithFormat:@"%@/CloudHealth/web/mod_news.html",kBaseURL]

#define kURLRank [NSString stringWithFormat:@"%@/CloudHealth/web/ranking_list.html?type=friends",kBaseURL]

#define kURLShare [NSString stringWithFormat:@"%@/CloudHealth/web/sharepage/index.html",kBaseURL]

#define kURLShareScheme [NSString stringWithFormat:@"%@/CloudHealth/web/sharepage/index.html",kBaseURL]

#define kURLNewActivity [NSString stringWithFormat:@"%@/CloudHealth/web/active.html?id=",kBaseURL]
//健康咨询
#define kURLHealthNews [NSString stringWithFormat:@"%@/CloudHealth/web/mod_news.html?type=jingzhuitiaoli",kBaseURL]

//功能介绍页
#define kURLFunctionPage [NSString stringWithFormat:@"%@/CloudHealth/web/aboutus.html", kBaseURL]

//食物查询
#define kURLFoodSearch [NSString stringWithFormat:@"%@/CloudHealth/web/foods/index.html", kBaseURL]

#define KURLFoodCalorie(x)  [NSString stringWithFormat:@"%@/CloudHealth/web/mod_calorie_con.html?id=%ld",kBaseURL,x]
//日历的URL
#define KURLCalendar(x)    [NSString stringWithFormat:@"%@/CloudHealth/web/calendar.html?subSchemeId=%ld",kBaseURL,x]
//
#define KURLFAQ(x)    [NSString stringWithFormat:@"%@/CloudHealth/web/question.html?schemeId=%ld",kBaseURL,x]

#if APP_STORE ==1

#define CREDENTIAL_TYPE @"1";// 检查升级用的版本类型， 1 为 AppStore版本， 2 为企业发布版本

#else

#define CREDENTIAL_TYPE @"2";// 检查升级用的版本类型， 1 为 AppStore版本， 2 为企业发布版本

#endif








#endif
