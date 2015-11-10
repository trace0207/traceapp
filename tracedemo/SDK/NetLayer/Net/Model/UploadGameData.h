//
//  UploadGameData.h
//  GuanHealth
//
//  Created by hermit on 15/5/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ResponseData.h"

@protocol UploadGameData
@end

@interface UploadGameData : ResponseData

@property (nonatomic, assign) int       rowNum;
@property (nonatomic, assign) int       userId;
@property (nonatomic, assign) int       spendTime;
@property (nonatomic,   copy) NSString  *nickName;
@property (nonatomic,   copy) NSString  *headPortraitUrl;

@end
