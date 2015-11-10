//
//  UploadGameRes.h
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"
#import "UploadGameData.h"

@interface UploadGameRes : ResponseData
//完成游戏后的各种排名
@property (nonatomic, assign) int rankInAll;
@property (nonatomic, assign) int rankInIdol;
@property (nonatomic, assign) int rankInFans;
//查看排行榜附加
@property (nonatomic, assign) int rowNum;//自己最好成绩
@property (nonatomic, assign) int spendTime;//自己最好成绩花费的时间
//@property (nonatomic,   copy) NSString *nickName;
//@property (nonatomic,   copy) NSString *headPortraitUrl;

@property (nonatomic, strong) NSArray<UploadGameData> *data;

@end
