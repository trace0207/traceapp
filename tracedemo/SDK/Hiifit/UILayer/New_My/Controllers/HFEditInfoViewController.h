//
//  HFEditInfoViewController.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, GZModifyType)
{
    GZModifyPortrait        = 0,
    GZModifyNickname        = 1,
    GZModifyTypeSex         = 2,
    GZModifyTypeAge         = 3,
    GZModifyHeight          = 4,
    GZModifyWeight          = 5,
    GZModifySignature       = 6,
    GZModifyBangding        = 7,
    GZModifyBand            = 8,
};

@interface HFEditInfoViewController : BaseViewController

@end
