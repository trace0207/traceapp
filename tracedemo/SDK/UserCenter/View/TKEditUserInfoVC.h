//
//  TKEditUserInfoVC.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"


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

@interface TKEditUserInfoVC : TKIBaseNavWithDefaultBackVC

@end
