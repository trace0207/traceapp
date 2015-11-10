//
//  HFSchemeProxy.h
//  GuanHealth
//
//  Created by luotianjia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HF_BaseAck.h"
#import "HF_BaseArg.h"
#import "HF_HttpClient.h"
#import "SaveDietaryInfoArg.h"
#import "PublishUserDiaryArg.h"
#import "AddSchemeScoreArg.h"
#import "GetQuizSubjectArg.h"
#import "GetQuizConclusionArg.h"
#import "GetQuizSubjectAgainArg.h"
#import "GetOrUpdateSchemeArg.h"

@interface HFSchemeProxy : NSObject


/**
 27.1获取锦囊妙计
 @parmar  schemeId   方案ID 
 **/
-(void)getSuggestBySchemeId:(NSInteger) schemeId withBlock:(hfAckBlock)block;


/**
 27.6修改方案状态， 1 开始方案， 2放弃方案， 3 完成方案
 **/
-(void)modifyScheme:(NSInteger)schemeId
       schemeStatus:(HFModifySchemeType)type
          withBlock:(hfAckBlock)block;

/*
 27.5加载首页方案信息
 */
-(void)loadSchemeInfo:(hfAckBlock)block;

/**
 27.2运动一下，获取 做运动页面数据
 **/
-(void)getSportPageData:(NSInteger)sportId type:(NSInteger)type withBlock:(hfAckBlock)block;

/**
 27.3上报运动数据
 **/
-(void)uploadSportData:(NSInteger)sportId type:(NSInteger)type dayIndex:(NSInteger)day withBlock:(hfAckBlock) block;


/*
 27.4上报记步数据
 */
-(void)uploadStepCount:(NSInteger)count date:(NSString *)date withBlock:(hfAckBlock)block;


/***
 27.7获取方案当前的信息  ， 用于方案主页 头部 和 全局信息展示
 **/
-(void)getSchemeInfoByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block;


/**
 27.8查询第N 天的  三餐数据
 **/
-(void)getFoodsByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block;

/*
 27.9查询第N天的记步数据
 行走的力量
 */
-(void)getRunningDataByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block;

/*
 27.10 获取指定第几天的 日记信息
 */
-(void)getDiaryDataByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block;

/*
 27.11 获取指定第几天的 运动一下 数据
 */
-(void)getSportDataByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block;


/*
 27.12 加载方案阶段完成后的总结
 */
-(void)getSchemeStepResult:(NSInteger)step withBlock:(hfAckBlock)block;

/*
 27.13 查询用户 三餐食谱 （历史 ）
 */
-(void)getUserDietaryByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block;


/*
 27.14 保存上传三餐饮食信息
 */
-(void)save:(SaveDietaryInfoArg *)arg withBlock:(hfAckBlock)block;

/*
 27.15 发表健康日记
 */
-(void)publishUserDiary:(PublishUserDiaryArg *)arg withBlock:(hfAckBlock)block;



/*
 27.16 方案阶段解锁
 */
-(void)openSchemeByStep:(NSInteger)step withBlock:(hfAckBlock)block;



/*
 28.1 领取积分
 */
-(void)addSchemeScore:(AddSchemeScoreArg *)arg withBlock:(hfAckBlock)block;

/*
 27.20 获取或更新调理方案
 */
- (void)getOrUpdateScheme:(GetOrUpdateSchemeArg *)arg withBlock:(hfAckBlock)block;

/*
 27.21 加载首页高级方案
 */
- (void)getAdvanceSchemeWithBlock:(hfAckBlock)block;

/*
 27.22 加载疾病介绍
 */
- (void)getDiseaseIntro:(NSInteger)schemeId withBlock:(hfAckBlock)block;

/*
 27.23 加载子方案主页（top）
 */
- (void)schemeTopWithId:(NSInteger)schemeId
            subSchemeId:(NSInteger)subSchemeId
              withBlock:(hfAckBlock)block;

/*
 27.24 加载子方案动作指导
 */

- (void)schemeActions:(NSInteger)schemeId
          subSchemeId:(NSInteger)subSchemeId
            withBlock:(hfAckBlock)block;

/*
 27.25 加载子方案打卡人员
 */

- (void)schemePunchCards:(NSInteger)schemeId withBlock:(hfAckBlock)block;

/*
 27.17 完成子方案
 */

- (void)finishSubScheme:(NSInteger)schemeId withBlock:(hfAckBlock)block;

/*
 27.21 加载高级方案主页
 */
- (void)getAdvanceSchemeMainPage:(NSInteger)schemeId withBlock:(hfAckBlock)block;

/*
 27.22 加载常见问题
 */
- (void)getCommenQuestion:(NSInteger)schemeId withBlock:(hfAckBlock)block;

/*
 32.1 方案测试题获得题目
 */
- (void)getQuizSubject:(GetQuizSubjectArg *)arg withBlock:(hfAckBlock)block;

/*
 32.2 方案测试题获得结论
 */
- (void)getQuizConclusion:(GetQuizConclusionArg *)arg withBlock:(hfAckBlock)block;

/*
 32.3 放弃结论
 */
- (void)giveUpQuizConclusion:(NSInteger)conclusionId withBlock:(hfAckBlock)block;
/*
 32.4 方案测试题重新获得题目
 */
- (void)getQuizSubjectAgain:(GetQuizSubjectAgainArg *)arg withBlock:(hfAckBlock)block;

@end
