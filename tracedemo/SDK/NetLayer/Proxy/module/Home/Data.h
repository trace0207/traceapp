//
//  Data.h
//  GuanHealth
//
//  Created by hermit on 15/4/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "HabitList.h"
@protocol Data
@end

@interface Data : ResponseData

@property (nonatomic, assign) NSInteger      id;                     //用户时间轴信息ID
@property (nonatomic, assign) NSInteger       flag;                   //是否被阅读 1：已阅读  0：未读
@property (nonatomic,   copy) NSString  *title;                 //消息标题
@property (nonatomic,   copy) NSString  *content;               //消息内容
@property (nonatomic, assign) NSInteger      createTimeUTC;          //发送消息UTC时间精确到秒
@property (nonatomic, assign) NSInteger       userId;                 //用户ID
@property (nonatomic, assign) NSInteger       goalId;                 //目标项ID

/*消息来源
 1、温馨提示
 2、我的习惯签到
 3、我被关注
 4、好友给我分享的模块
 5、我被评论
 6、好友记录的心情贴
 */
@property (nonatomic, assign) NSInteger       source;

/*微博心情或者评论类型
 1：若是心情则表示习惯心情；若是评论，则表示习惯心情评论
 2：若是模块则表示模块心情；若是评论，则表示模块心情评论
 */
@property (nonatomic, assign) NSInteger       weiboType;
@property (nonatomic, assign) NSInteger       finished;
@property (nonatomic, assign) NSInteger       operatorId;             //操作人ID
@property (nonatomic, assign) NSInteger       modelId;                //模块ID
@property (nonatomic, assign) NSInteger      habitId;                //习惯ID
@property (nonatomic,   copy) NSString  *picAddr;               //第一张图片URL
@property (nonatomic,   copy) NSString  *operatorName;              //操作人名称我被关注，朋友给我分享，我被评论
@property (nonatomic,   copy) NSString  *modelName;             //模块名称
@property (nonatomic,   copy) NSString  *habitName;             //习惯名称
@property (nonatomic,   copy) NSString  *headPortraitUrl;       //头像
@property (nonatomic,   copy) NSString  *remark;                //类型提示信息
@property (nonatomic,   copy) NSString  *goalContent;           //原心情内容
@property (nonatomic,   copy) NSString  *clockTime;             //习惯闹钟时间
//帖子内容
@property (nonatomic,   copy) NSString *picAddr1;
@property (nonatomic,   copy) NSString *picAddr2;
@property (nonatomic,   copy) NSString *picAddr3;
@property (nonatomic,   copy) NSString *picAddr4;
@property (nonatomic,   copy) NSString *picAddr5;
@property (nonatomic,   copy) NSString *picAddr6;
@property (nonatomic,   copy) NSString *picAddr7;
@property (nonatomic,   copy) NSString *picAddr8;
@property (nonatomic,   copy) NSString *picAddr9;
@property (nonatomic, assign) NSInteger       praiseNum;
@property (nonatomic, assign) NSInteger       commentNum;
@property (nonatomic, assign) NSInteger       isPraise;

//非服务器数据
@property (nonatomic)PostCellExpandState expandFlag;

- (void)copyFromHabit:(HabitList*)habit;

@end
