//
//  GlobEnum.h
//  GuanHealth
//
//  Created by hermit on 15/2/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#ifndef GuanHealth_GlobEnum_h
#define GuanHealth_GlobEnum_h

typedef NS_ENUM (NSInteger,GZNetResponsCode){
    SUCCESS200              = 200,        //操作成功
    SUCCESS                 = 0,        //操作成功
    REQUEST_SUCCESS         = 1,        //请求成功
    NO_SET_USERINFO         = 2,        //未填写性别身高体重信息
    GETVERCODE_SUCCESS      = 9,        //发送验证码成功
    
    ERROR                   = -1,       //系统错误
    HASREGISTER             = -98,      //用户已注册
    NO_LOGIN                = -99,      //用户未登录
    NO_REGISTE              = -100,     //用户未注册
    PARAM_NULL              = -101,     //传入的参数为空
    USER_OR_PWD_ERROR       = -102,     //用户名或密码错误
    NO_RESULT               = -103,     //
    INSERT_ERROR            = -104,     //数据库新增失败
    UPDATE_ERROR            = -105,     //数据库更新失败
    DELETE_ERROR            = -106,     //数据库删除失败
    RECORD_EXISTS           = -107,     //记录已存在
    NO_INFORMATION          = -108,     //信息不完整
    SEND_CODE               = -109,     //未找到符合条件的记录
    CODE_ERROR              = -110,     //验证码错误
    POST_DELETE             = -40001    //心情贴被删除
};

typedef NS_ENUM(int, GZTimeLineType) {
    GZTimeLineTypeTips              = 1,    //健康小提示
    GZTimeLineTypeHabitTips         = 2,    //我的习惯提示信息
    GZTimeLineTypeBeFocus           = 3,    //我被某人关注
    GZTimeLineTypeShareModulariry   = 4,    //朋友分享了一个模块
    GZTimeLineTypeMyPostBeComment   = 5,    //被人评论
    GZTimeLineTypeFriendPost        = 6,    //朋友发的心情贴
};

typedef NS_ENUM(NSUInteger, HIModuleType) {
    HIModuleTypeTestTools           = 1,//自测工具
    HIModuleTypeSelfCheck           = 2,//健康自查
    HIModuleTypeHealthNews          = 3,//健康资讯
    HIModuleTypeDrugHelp            = 4,//用药助手
    HIModuleTypeCalorie             = 5,//卡里路查询
    HIModuleTypeDiseaseKnow         = 6,//疾病知识
    HIModuleTypeHabit               = 7,//习惯
    HIModuleTypeGame                = 8,//数独游戏
    HIModuleTypeBanner              = 9, //首页banner
    HIModuleTypeScheme              = 10, //颈椎调理方案
    HIModuleTypeActivity            = 11//活动界面
};

typedef NS_ENUM(NSInteger, MessageType) {
    MSGBOX_COMMENT_TYPE = 0,          //消息盒子评论
    MSGBOX_PRISE_TYPE,                //消息盒子点赞
    MSGBOX_FOLLOW_TYPE,               //消息盒子粉丝
    MSGBOX_SYSTEM_TYPE,               //消息盒子系统通知
};

typedef NS_ENUM(int, HIUploadImageType) {
    HIUploadImageTypePortrait   = 1, //头像
    HIUploadImageTypePost       = 2, //微博心情图片
    HIUploadImageTypeScheme     = 3, //方案贴吧
    HIUploadImageTypePack       = 4, //锦囊妙计
    HIUploadImageTypeDiary      = 5, //健康日记
    HIUploadImageTypeDie        = 6, //食谱
};

typedef NS_ENUM(int, HIWeiboType) {
    HIWeiboTypeHabit        = 1, //习惯微博
    HIWeiboTypeModule       = 2, //模块微博
    HIWeiboTypePostBar      = 3  //贴吧微博
};

typedef NS_ENUM(int, HIFindType) {
    HIFindTypeHot        = 1, //热门心情
    HIFindTypeInterest   = 2, //兴趣心情
    HIFindTypeFriends    = 3, //好友心情
};

typedef NS_ENUM(int, HICheckVercodeType) {
    HICheckVercodeTypeRegister             = 1, //注册验证码
    HICheckVercodeTypeForgetPassword       = 2, //找回密码验证码
};

typedef NS_ENUM(int, HIUserType) {
    HIUserTypeMobile      = 0, //嗨健康账号登录
    HIUserTypeWeiBo       = 1, //新浪微博账号登录
    HIUserTypeWeChat      = 2, //微信账号登陆
    HIUserTypeWeQQ        = 3, //qq账号登录
};


typedef NS_ENUM(int , UpdateType) {
    UPDATE_ALL          = 1, // 所有信息更新
    UPDATE_SIGN         = 2, //签名
    UPDATE_NICK         = 3, // 昵称
    UPDATE_AGE          = 4, //年龄
    UPDATE_HEIGHT       = 5, //身高
    UPDATE_WEIGHT       = 6, //体重
    UPDATE_SEX          = 7, //性别

};

typedef NS_ENUM(int, HIOSType) {
    HIOSTypeAndroid      = 3, //android用户
    HIOSTypeIOS          = 4, //ios用户
};

typedef NS_ENUM(NSUInteger, HFItemType) {
    HFItemTypeHabit      = 0, //习惯数据类型
    HFItemTypeModule     = 1, //模块数据类型
    HFItemTypeAlarmClock = 2, //闹钟数据类型
};




typedef NS_ENUM(NSInteger, HFRequestError){

    HFNetDisable = - 10085, // 网络不可用
    HFRequestTimeOut = -10086,//  请求超时
    HFRequestParamError = -10087,// 请求参数异常
    HFResponseParamError = -10088,// 反回的参数异常
    HFRequestSendError = - 10089,//  请求过程异常， 可能是网络问题
};
typedef NS_ENUM(NSInteger,ZBMessageViewState) {
    ZBMessageViewStateShowFace,//展示表情键盘
    ZBMessageViewStateShowShare,//展示分享页
    ZBMessageViewStateShowNone,//展示系统键盘
};
typedef NS_ENUM(NSInteger, HFSendPostType) {
    HFSendPost = 1,//发送的是心情贴
    HFSendDiscussion,//发送的是讨论贴
    HFSendDiary//发送的是健康日记
};

typedef NS_ENUM(NSInteger, HFModifySchemeType) {
    HFModifySchemeTypeStart = 1,//开始方案
    HFModifySchemeTypeGiveUp,//放弃方案
    HFModifySchemeTypeFinished//完成方案
};
typedef NS_ENUM(NSInteger, HFPushType) {
    HFPushPraise = 0,
    HFpushComm,
    HFPushFuns
};

/**
 *  等待刷新的状态
 */
typedef NS_OPTIONS(NSInteger, WaitRefreshState){
    Wait_Refresh_None                = 0,                  //状态未知
    Wait_Refresh_Banner              = 1 << 0,             //刷新活动banner
//    Wait_Refresh_Scheme              = 1 << 1,             //刷新方案
    Wait_Refresh_Habit               = 1 << 1,             //刷新习惯
    Wait_Refresh_TimeLine            = 1 << 2,             //刷新时间轴
    Wait_Refresh_MsgBox              = 1 << 3,             //刷新消息盒子的数据
    Wait_Refresh_AdScheme            = 1 << 4,             //刷新高级方案
    Wait_Refresh_ALL                 = Wait_Refresh_Banner |
                                       Wait_Refresh_Habit |
                                       Wait_Refresh_TimeLine |
                                       Wait_Refresh_AdScheme |
                                       Wait_Refresh_MsgBox,             //刷新全部
};

typedef NS_ENUM(NSInteger ,PostCellExpandState) {
    PostExpandUnkonw = 0,
    PostExpandUnExpand,
    PostExpandExpand,
    PostExpandNone,
};

#endif
