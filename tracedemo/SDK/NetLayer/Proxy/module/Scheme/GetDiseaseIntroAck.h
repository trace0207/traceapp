//
//  GetDiseaseIntroAck.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/28.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HF_BaseAck.h"


@interface GetDiseaseIntroData : TK_BaseJsonModel

@property (nonatomic, copy) NSString * picAddr;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * content;

@end

@interface GetDiseaseIntroAck : HF_BaseAck

@property (nonatomic, strong) GetDiseaseIntroData * data;

@end
