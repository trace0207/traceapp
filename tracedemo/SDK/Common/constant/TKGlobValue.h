//
//  TKGlobValue.h
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//




typedef NS_ENUM(NSInteger,HomePageType)
{
    C_AllReward = 4,// C悬赏池
    C_showGoods = 3,
    B_MyUserReward = 2,
    B_AllReward = 1
} ;

#ifndef TKGlobValue_h
#define TKGlobValue_h


//判定系统版本号
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)

#define IOS8VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IOS7VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define TKScreenBounds   [[UIScreen mainScreen]bounds]
#define TKScreenWidth    [[UIScreen mainScreen]bounds].size.width
#define TKScreenHeight   [[UIScreen mainScreen]bounds].size.height
#define TKScreenScale    (TKScreenWidth/320)


#define MainScreenScale [[UIScreen mainScreen]scale] //屏幕的分辨率 当结果为1时，显示的是普通屏幕，结果为2时，显示的是Retian屏幕
// App Frame Height&Width
#define Application_Frame  [[UIScreen mainScreen] applicationFrame] //除去信号区的屏幕的frame
#define APP_Frame_Height   [[UIScreen mainScreen] applicationFrame].size.height //应用程序的屏幕高度
#define App_Frame_Width    [[UIScreen mainScreen] applicationFrame].size.width  //应用程序的屏幕宽度
/*** MainScreen Height Width */

#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define Main_Screen_Height_without_top [[UIScreen mainScreen] bounds].size.height-64 //主屏幕的高度



// View 坐标(x,y)和宽高(width,height)
#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height

#define MinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define MinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define MidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define MidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

#define CONTRLOS_FRAME(x,y,width,height)     CGRectMake(x,y,width,height)

//    系统控件的默认高度
#define kStatusBarHeight   (20.f)
#define kTopBarHeight      (44.f)
#define kBottomBarHeight   (49.f)

#define kCellDefaultHeight (44.f)

#define KstatusBarAndNavigation (64.0)
// 当控件为全屏时的横纵左边
#define kFrameX             (0.0)
#define kFrameY             (0.0)


#define kPhoneWithStatusNoPhone5Height   (480.0)
#define kPhoneNoWithStatusNoPhone5Height (460.0)
#define kPhoneWithStatusPhone5Height     (568.0)
#define kPhoneNoWithStatusPhone5Height   (548.0)

#define kPadFrameWidth                   (768.0)
#define kPadWithStatusHeight             (1024.0)
#define kPadNoWithStatusHeight           (1004.0)

//中英状态下键盘的高度
#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

#pragma mark - Funtion Method (宏 方法)
//PNG JPG 图片路径
#define PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMG(NAME)              [UIImage imageNamed:NAME]

//字体大小（常规/粗体）
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME,FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//颜色（RGB）
#define RGBCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define BACKGROUND_COLOR         [UIColor colorWithRed:22/255.0f green:29/255.0f blue:38/255.0f alpha:1]
//当前版本
#define FSystenVersion            ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystenVersion            ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion            ([[UIDevice currentDevice] systemVersion])

//当前语言
#define CURRENTLANGUAGE           ([[NSLocale preferredLanguages] objectAtIndex:0])


//是否Retina屏
#define isRetina                  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) :NO)
//是否iPhone5
#define ISIPHONE                  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISIPHONE5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIPHONE6                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIPHONE6P                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//是否是iPad
#define isPad                      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define YELLO_APP [UIColor colorWithRed:255/255 green:148.0/255 blue:28.0/255 alpha:1]

// UIView - viewWithTag 通过tag值获得子视图
#define VIEWWITHTAG(_OBJECT,_TAG)   [_OBJECT viewWithTag : _TAG]

//应用程序的名字
#define AppDisplayName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

//RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define  _T(x)           NSLocalizedString(x, nil)
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif



#pragma mark ------- TKLocal
#define TKUserId  [[TKUserCenter instance] getUser].userId //  当前用户的  userId
// 服务器地址
#define TKBaseURL  [TKProxy proxy].tkBaseUrl;

//默认的 head 头像地址
#define TKDefaultHead  @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg"



// web 页面

//C 我的购买
#define CMyGoodsURL @"/web/apollo/order/orderlist.html?role=1"
//B 我的订单
#define BMyOrders @"/web/apollo/order/orderlist.html?role=0"
//账号详情B
#define BaccountDetailURL @"/web/apollo/my/accountB.html"
//账号详情C
#define CaccountDetailURL @"/web/apollo/my/accountC.html"
//C端我的账单
#define CPayListURL @"/web/apollo/my/bill.html"
//B端买手等级规则
#define BRuleURL @"/web/apollo/my/bRules.html"
//B端保证金
#define BDepositURL @"/web/apollo/my/securityDeposit.html"
//C端大牌币
#define CBigMoneyURL @"/web/apollo/my/wallet.html"
//B端提现
#define BGetMoneyURL @"/web/apollo/my/withdrawal.html"
//地址
#define AddressURL @"/web/apollo/address/list.html"

//软件服务协议
#define ServerAttentionURL @"/web/apollo/address/list.html"
//账单
#define  MyBillURL  @"/web/apollo/my/bill.html"


// 设置 image 头像
#define TKSetHeadImageView(imageView,url)  \
[imageView  sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:url]]  \
              placeholderImage:[UIImage imageNamed:@"tk_image_head_default"]];

#define TKSetLoadingImageView(imageView,url)  \
[imageView  sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:url]]  \
placeholderImage:[UIImage imageNamed:@"img_default"]];

#define TKSetLoadingRawImageView(imageView,url)  \
[imageView  sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getRawImage:url]]  \
placeholderImage:[UIImage imageNamed:@"img_default"]];

//  数字转换成 NSString
#define  TKStrFromNumber(number)   [NSNumber numberWithDouble:number].stringValue

// 读取全屏幕size 的 frame
#define TKMainViewFream   [[UIScreen mainScreen] bounds]

// 设置UItableView 的 代理
#define TKSetTableView(tableView,d1,d2)  tableView.dataSource =  d1 ; \
tableView.delegate = d2;

// 设置view 的边框
#define TKBorder(x)  [TKUITools setRoudBorderForView:x borderColor:[UIColor tkBorderColor] radius:2 borderWidth:1];



