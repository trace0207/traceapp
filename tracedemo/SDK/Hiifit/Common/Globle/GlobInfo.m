//
//  GlobInfo.m
//  GuanHealth
//
//  Created by hermit on 15/2/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "GlobInfo.h"
#import "GlobConfig.h"
#import "GlobKey.h"
#import "HFDeviceInfo.h"

@implementation GlobInfo

@synthesize usr = _usr;
@synthesize bNeedReloadMain;
@synthesize bPush;
@synthesize mLastUpdateTime;
@synthesize bIsFullScreenState;
SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(GlobInfo, shareInstance);

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
    
}

- (NSString*)deviceid
{
    NSString *devid = [kUserDefaults valueForKey:kParamDeviceId];
    if (devid == nil || devid.length <= 0) {
        devid = [self setDeviceid];
    }
    return devid;
//    return @"112233";
}

- (NSString*)setDeviceid
{
    NSString *devid = [[HFDeviceInfo shareInstance]getDeviceId];
    [kUserDefaults setValue:devid forKey:kParamDeviceId];
    [kUserDefaults synchronize];
    return devid;
}

- (void)loginOut
{
    [kUserDefaults removeObjectForKey:kParamMobile];
    [kUserDefaults removeObjectForKey:kParamUserInfo];
    [kUserDefaults removeObjectForKey:kParamPassword];
    [kUserDefaults removeObjectForKey:kParamDisplayAD];
    [kUserDefaults synchronize];
}

- (void)setAccount:(NSString *)account
{
    if (account.length == 0) {
        return;
    }
    [kUserDefaults setValue:account forKey:kParamAccount];
    [kUserDefaults synchronize];
}

- (NSString*)account
{
    return [kUserDefaults valueForKey:kParamAccount];
}

- (void)setPassword:(NSString *)password
{
    if (password.length == 0) {
        return;
    }
    [kUserDefaults setValue:password forKey:kParamPassword];
    [kUserDefaults synchronize];
}

- (NSString*)password
{
    return [kUserDefaults valueForKey:kParamPassword];
}

- (void)setLastUpdateTime:(long)lastUpdateTime
{
    [kUserDefaults setObject:[NSNumber numberWithLong:lastUpdateTime] forKey:kParamLastDate];
    [kUserDefaults synchronize];
}

- (long)lastUpdateTime
{
    id number = [kUserDefaults objectForKey:kParamLastDate];
    
    if (![number isKindOfClass:[NSNumber class]])
    {
        return 0.0f;
    }
    
    if (number)
    {
        if ([number respondsToSelector:@selector(longValue)])
        {
            return [[kUserDefaults objectForKey:kParamLastDate] longValue];
        }
        return 0.0f;
    }
    else
    {
        return 0.0f;
    }
}

- (void)setFinishedInfo:(NSInteger)finishedInfo
{
    [kUserDefaults setInteger:finishedInfo forKey:kParamFinishedInfo];
    [kUserDefaults synchronize];
}

- (NSInteger)finishedInfo
{
    NSInteger finished = [kUserDefaults integerForKey:kParamFinishedInfo];
    if (finished == 0) {
        [self setFinishedInfo:NO_SET_USERINFO];
    }
    return [kUserDefaults integerForKey:kParamFinishedInfo];
}

- (NSString*)behaviorInfo
{
    NSString *info = [kUserDefaults objectForKey:kParamBehavoirInfo];
    if (!info) {
        return [[HFDeviceInfo shareInstance]getBehaviorInfo];
    }
    return info;
}

- (void)setMLastUpdateTime:(long long)lastUpdateTime
{
    [kUserDefaults setValue:[NSNumber numberWithLongLong:lastUpdateTime] forKey:kParmsLastUpdateTime];
    [kUserDefaults synchronize];
}

- (long long)mLastUpdateTime
{
    return [[kUserDefaults valueForKey:kParmsLastUpdateTime] longLongValue];
}

- (NSInteger)onlineSeconds
{
    return [[kUserDefaults valueForKey:kParmsLastOnlineSeconds] integerValue];;
}

- (void)setOnlineSeconds:(NSInteger)onlineSeconds
{
    [kUserDefaults setValue:[NSNumber numberWithInteger:onlineSeconds] forKey:kParmsLastOnlineSeconds];
    [kUserDefaults synchronize];
}

- (void)setOnlineDate:(NSString *)onlineDate
{
    [kUserDefaults setObject:onlineDate forKey:kParmsOnlineDate];
    [kUserDefaults synchronize];
}

- (void)saveBandInfo:(NSDictionary *)bandInfo
{
    [kUserDefaults setObject:bandInfo forKey:kParamBandInfo];
    [kUserDefaults synchronize];
}

- (NSString *)onlineDate
{
    return [kUserDefaults objectForKey:kParmsOnlineDate];
}

- (void)setActiveDay:(CGFloat)activeDay
{
    [kUserDefaults setObject:[NSNumber numberWithFloat:activeDay] forKey:kParamActiveDay];
    [kUserDefaults synchronize];
}

- (CGFloat)activeDay
{
    return [[kUserDefaults objectForKey:kParamActiveDay]floatValue];
}

- (UserRes*)usr
{
    if (_usr == nil)
    {
        _usr = [[UserRes alloc]init];
    }
    NSDictionary *userInfo = [kUserDefaults objectForKey:kParamUserInfo];
    if (userInfo && [userInfo isKindOfClass:[NSDictionary class]])
    {
        [_usr mergeFromDictionary:userInfo useKeyMapping:NO];
    }
    return _usr;
}

- (void)setUserInfo:(NSDictionary*)user
{
    
    bPush = [[user objectForKey:@"isPush"] boolValue];
    
    if (user && [user isKindOfClass:[NSDictionary class]]) {
        [kUserDefaults setObject:user forKey:kParamUserInfo];
        [kUserDefaults synchronize];
    }
}

- (void)setWeather:(NSDictionary *)weather
{
    if (weather == nil || ![weather isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [kUserDefaults setObject:weather forKey:kParamWeather];
    [kUserDefaults synchronize];
}

- (NSDictionary *)weather
{
    return [kUserDefaults objectForKey:kParamWeather];
}

- (BOOL)isLatestVersion
{
    NSString *lastVersion = [kUserDefaults valueForKey:kParamUpdate];
    NSString *nowVersion = [[HFDeviceInfo shareInstance]getAppVersion];
    if (!lastVersion) {
        [kUserDefaults setValue:nowVersion forKey:kParamUpdate];
        [kUserDefaults synchronize];
        return YES;
    }
    if (![nowVersion isEqualToString:lastVersion]) {
        [kUserDefaults setValue:nowVersion forKey:kParamUpdate];
        [kUserDefaults synchronize];
        return YES;
    }
    
    return NO;
}

- (void)saveDeviceToken:(NSString *)token
{
    if (!token) {
        token = @"";
    }
    [kUserDefaults setObject:token forKey:kParmsDeviceToken];
    [kUserDefaults synchronize];
}


- (void)setCity:(NSString *)city
{
    if (!city) {
        city = @"";
    }
    [kUserDefaults setObject:city forKey:kParamCity];
    [kUserDefaults synchronize];
}

- (NSString *)city
{
    return [kUserDefaults objectForKey:kParamCity];
}

- (void)setUserType:(NSInteger)userType
{
    [kUserDefaults setObject:[NSNumber numberWithInteger:userType] forKey:kParamUserType];
    [kUserDefaults synchronize];
}

- (NSInteger)userType
{
    return [[kUserDefaults objectForKey:kParamUserType]integerValue];
}

- (NSString *)token
{
    return [kUserDefaults objectForKey:kParmsDeviceToken];
}

- (void)setBDisplayBandView:(BOOL)bDisplayBandView
{
    [kUserDefaults setObject:[NSNumber numberWithBool:bDisplayBandView] forKey:@"bDisplayBandViewKey"];
    [kUserDefaults synchronize];
}

- (BOOL)bDisplayBandView
{
    return [[kUserDefaults objectForKey:@"bDisplayBandViewKey"]boolValue];
}

- (BOOL) hasLogined
{
    if (self.account.length>0) {
        return YES;
    }
    return NO;
}

@end
