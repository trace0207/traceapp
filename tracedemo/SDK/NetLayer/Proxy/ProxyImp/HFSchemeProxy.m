//
//  HFSchemeProxy.m
//  GuanHealth
//
//  Created by luotianjia on 15/8/10.
//  Copyright (c) 2015年 cmcc. All rights reserved.
//

#import "HFSchemeProxy.h"
#import "GetSuggestAck.h"
#import "GetSuggestArg.h"
#import "HF_HttpClient.h"
#import "ModifySchemeStateAck.h"
#import "ModifySchemeStateArg.h"
#import "LoadSchemeInfoArg.h"
#import "LoadSchemeInfoAck.h"
#import "GetSportPageDataAck.h"
#import "GetSportPageDataArg.h"
#import "UploadSportDataArg.h"
#import "UploadStepCountArg.h"
#import "GetSchemeDayInfoArg.h"
#import "GetSchemeDayInfoAck.h"
#import "GetFoodsByDayAck.h"
#import "GetFoodsByDayArg.h"
#import "GetRunningDataArg.h"
#import "GetRunningDataAck.h"
#import "GetDiaryDataByDayArg.h"
#import "GetDiaryDataByDayAck.h"
#import "GetUserDietaryByDayAck.h"
#import "GetUserDietaryByDayAck.h"
#import "PublishUserDiaryArg.h"
#import "SaveDietaryInfoArg.h"
#import "OpenSchemeByStepArg.h"
#import "GetSchemeStepResultAck.h"
#import "GetSchemeStepResultArg.h"
#import "AddSchemeScoreArg.h"
#import "GetSportDataByDayArg.h"
#import "GetSportDataByDayAck.h"
#import "GetUserDietaryByDayArg.h"
#import "SubSchemeHomeArg.h"
#import "SubSchemeHomeAck.h"
#import "SchemeActionsAck.h"
#import "SchemeActionsArg.h"
#import "SchemePunchAck.h"
#import "SchemePunchArg.h"
#import "FinishSchemeAck.h"
#import "FinishSchemeArg.h"
#import "MainPageAdvanceSchemeArg.h"
#import "GetAdvanceSchemeMainPageArg.h"
#import "GetCommonProblemArg.h"
#import "MainPageAdvanceSchemeAck.h"
#import "GetAdvanceSchemeMainPageAck.h"
#import "GetCommonProblemAck.h"
#import "GetQuizSubjectAck.h"
#import "GetQuizConclusionAck.h"
#import "GiveUpQuizConclusionArg.h"
#import "GiveUpQuizConclusionAck.h"
#import "GetQuizSubjectAgainAck.h"
#import "GetOrUpdateSchemeArg.h"
#import "GetDiseaseIntroArg.h"
#import "GetDiseaseIntroAck.h"

@implementation HFSchemeProxy


/**
 获取锦囊妙计
 @parmar  schemeId   方案ID
 **/
-(void)getSuggestBySchemeId:(NSInteger)schemeId withBlock:(hfAckBlock)block{

    GetSuggestArg * arg = [[GetSuggestArg alloc] init];
    arg.schemeId = schemeId;
    arg.ackClassName = NSStringFromClass([GetSuggestAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}

/**
 修改方案状态， 1 开始方案， 2放弃方案， 3 完成方案
 **/
-(void)modifyScheme:(NSInteger)schemeId
       schemeStatus:(HFModifySchemeType)type
          withBlock:(hfAckBlock)block
{
    ModifySchemeStateArg * arg = [[ModifySchemeStateArg alloc] init];
    arg.ackClassName = NSStringFromClass([ModifySchemeStateAck class]);
    arg.schemeId = schemeId;
    arg.operateType = type;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/*
 加载首页方案信息
 */
-(void)loadSchemeInfo:(hfAckBlock)block{
    LoadSchemeInfoArg * arg = [[LoadSchemeInfoArg alloc] init];
    arg.ackClassName = NSStringFromClass([LoadSchemeInfoAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/**
 运动一下，获取 做运动页面数据
 **/
-(void)getSportPageData:(NSInteger)sportId type:(NSInteger)type withBlock:(hfAckBlock)block{
    GetSportPageDataArg * arg = [[GetSportPageDataArg alloc] init];
    arg.ackClassName = NSStringFromClass([GetSportPageDataAck class]);
    arg.type = type;
    arg.sportId = sportId;
    arg.showLoadingStr = @"YES";
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/**
 上报运动数据
 **/
-(void)uploadSportData:(NSInteger)sportId type:(NSInteger)type dayIndex:(NSInteger)day withBlock:(hfAckBlock) block{

    UploadSportDataArg * arg = [[UploadSportDataArg alloc] init];
    arg.sportId = sportId;
    arg.type = type;
    arg.schemeId = 1;
    arg.day = day;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 上报记步数据
 */
-(void)uploadStepCount:(NSInteger)count date:(NSString *)date withBlock:(hfAckBlock)block{
    UploadStepCountArg * arg = [[UploadStepCountArg alloc] init];
    arg.schemeId = 1;
    arg.step = count;
    arg.date = date;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/**
 获取方案当前的信息  ， 用于方案主页 头部 和 全局信息展示
 **/
-(void)getSchemeInfoByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block{

    GetSchemeDayInfoArg * arg  = [[GetSchemeDayInfoArg alloc] init];
    arg.schemeId = 1;
    arg.day = dayIndex;
    arg.ackClassName = NSStringFromClass([GetSchemeDayInfoAck class]);    
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];

}


/**
 查询第N 天的  三餐数据
 **/
-(void)getFoodsByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block{
    GetFoodsByDayArg * arg = [[GetFoodsByDayArg alloc] init];
    arg.schemeId = 1;
    arg.day = dayIndex;
    arg.ackClassName = NSStringFromClass([GetFoodsByDayAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/*
 27.9查询第N天的记步数据
 行走的力量
 */
-(void)getRunningDataByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block{
    GetRunningDataArg * arg = [[GetRunningDataArg alloc]init];
    arg.day = dayIndex;
    arg.schemeId = 1;
    arg.ackClassName = NSStringFromClass([GetRunningDataAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.10 获取指定第几天的 日记信息
 */
-(void)getDiaryDataByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block{
    
    GetDiaryDataByDayArg * arg = [[GetDiaryDataByDayArg alloc]init];
    arg.schemeId = 1;
    arg.day = dayIndex;
    arg.ackClassName = NSStringFromClass([GetDiaryDataByDayAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.11 获取指定第几天的 运动一下 数据
 */
-(void)getSportDataByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block{
    
    GetSportDataByDayArg * arg = [[GetSportDataByDayArg alloc]init];
    arg.schemeId = 1;
    arg.day = dayIndex;
    arg.ackClassName = NSStringFromClass([GetSportDataByDayAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/*
 27.12 加载方案阶段完成后的总结
 */
-(void)getSchemeStepResult:(NSInteger)step withBlock:(hfAckBlock)block{
    GetSchemeStepResultArg * arg = [[GetSchemeStepResultArg alloc]init];
    arg.schemeId = 1;
    arg.stageId = step;
    arg.ackClassName = NSStringFromClass([GetSchemeStepResultAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.13 查询用户 三餐食谱 （历史 ）
 */
-(void)getUserDietaryByDay:(NSInteger)dayIndex withBlock:(hfAckBlock)block{
    GetUserDietaryByDayArg *arg = [[GetUserDietaryByDayArg alloc]init];
    arg.schemeId = 1;
    arg.day = dayIndex;
    arg.ackClassName = NSStringFromClass([GetUserDietaryByDayAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/*
 27.14 保存上传三餐饮食信息
 */
-(void)save:(SaveDietaryInfoArg *)arg withBlock:(hfAckBlock)block{
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.15 发表健康日记
 */
-(void)publishUserDiary:(PublishUserDiaryArg *)arg withBlock:(hfAckBlock)block{
    
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
    
}



/*
 27.16 方案阶段解锁
 */
-(void)openSchemeByStep:(NSInteger)step withBlock:(hfAckBlock)block{
    OpenSchemeByStepArg * arg = [[OpenSchemeByStepArg alloc]init];
    arg.schemeId = 1;
    arg.stageId = step;
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}



/*
 28.1 领取积分
 */

-(void)addSchemeScore:(AddSchemeScoreArg *)arg withBlock:(hfAckBlock)block{
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/*
 27.23 加载子方案主页（top）
 */
- (void)schemeTopWithId:(NSInteger)schemeId
            subSchemeId:(NSInteger)subSchemeId
              withBlock:(hfAckBlock)block;
{
    SubSchemeHomeArg *arg = [[SubSchemeHomeArg alloc]init];
    arg.subSchemeId = subSchemeId;
    arg.parentSchemeId = schemeId;
    arg.ackClassName = NSStringFromClass([SubSchemeHomeAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.20 获取或更新调理方案
 */
- (void)getOrUpdateScheme:(GetOrUpdateSchemeArg *)arg withBlock:(hfAckBlock)block
{
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}
/*
 27.21 加载首页高级方案
 */

- (void)getAdvanceSchemeWithBlock:(hfAckBlock)block
{
    MainPageAdvanceSchemeArg * arg = [[MainPageAdvanceSchemeArg alloc] init];
    arg.ackClassName = NSStringFromClass([MainPageAdvanceSchemeAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 27.22 加载疾病介绍
 */
- (void)getDiseaseIntro:(NSInteger)schemeId withBlock:(hfAckBlock)block
{
    GetDiseaseIntroArg * arg = [[GetDiseaseIntroArg alloc] init];
    arg.schemeId = schemeId;
    arg.ackClassName = NSStringFromClass([GetDiseaseIntroAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 27.24 加载子方案动作指导
 */

- (void)schemeActions:(NSInteger)schemeId
          subSchemeId:(NSInteger)subSchemeId
            withBlock:(hfAckBlock)block
{
    SchemeActionsArg *arg = [[SchemeActionsArg alloc]init];
    arg.subSchemeId = subSchemeId;
    arg.parentSchemeId = schemeId;
    arg.ackClassName = NSStringFromClass([SchemeActionsAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.25 加载子方案打卡人员
 */

- (void)schemePunchCards:(NSInteger)schemeId withBlock:(hfAckBlock)block
{
    SchemePunchArg *arg = [[SchemePunchArg alloc]init];
    arg.subSchemeId = schemeId;
    arg.pageIndex = 0;
    arg.pageSize = 20;
    arg.ackClassName = NSStringFromClass([SchemePunchAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}

/*
 27.17 完成子方案
 */

- (void)finishSubScheme:(NSInteger)schemeId withBlock:(hfAckBlock)block
{
    FinishSchemeArg *arg = [[FinishSchemeArg alloc]init];
    arg.subSchemeId = schemeId;
    arg.showLoadingStr = @"YES";
    arg.ackClassName = NSStringFromClass([FinishSchemeAck class]);
    [[HF_HttpClient httpClient]sendRequestForHiifit:arg withBolck:block];
}


/*
 27.21 加载高级方案主页
 */
- (void)getAdvanceSchemeMainPage:(NSInteger)schemeId withBlock:(hfAckBlock)block
{
    GetAdvanceSchemeMainPageArg * arg = [[GetAdvanceSchemeMainPageArg alloc] init];
    arg.schemeId = schemeId;
    arg.ackClassName = NSStringFromClass([GetAdvanceSchemeMainPageAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 27.21 加载常见问题
 */
- (void)getCommenQuestion:(NSInteger)schemeId withBlock:(hfAckBlock)block
{
    GetCommonProblemArg * arg = [[GetCommonProblemArg alloc] init];
    arg.schemeId = schemeId;
    arg.pageIndex = 0;
    arg.pageSize = 20;
    arg.ackClassName = NSStringFromClass([GetCommonProblemAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 32.1 方案测试题获得题目
 */
- (void)getQuizSubject:(GetQuizSubjectArg *)arg withBlock:(hfAckBlock)block
{
    arg.ackClassName = NSStringFromClass([GetQuizSubjectAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 32.2 方案测试题获得结论
 */
- (void)getQuizConclusion:(GetQuizConclusionArg *)arg withBlock:(hfAckBlock)block
{
    arg.ackClassName = NSStringFromClass([GetQuizConclusionAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 32.3 放弃结论
 */
- (void)giveUpQuizConclusion:(NSInteger)conclusionId withBlock:(hfAckBlock)block
{
    GiveUpQuizConclusionArg * arg = [[GiveUpQuizConclusionArg alloc] init];
    arg.conclusionId = conclusionId;
    arg.ackClassName = NSStringFromClass([GiveUpQuizConclusionAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

/*
 32.4 方案测试题重新获得题目
 */
- (void)getQuizSubjectAgain:(GetQuizSubjectAgainArg *)arg withBlock:(hfAckBlock)block
{
    arg.ackClassName = NSStringFromClass([GetQuizSubjectAgainAck class]);
    [[HF_HttpClient httpClient] sendRequestForHiifit:arg withBolck:block];
}

@end
