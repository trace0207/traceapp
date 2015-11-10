//
//  UserRes.m
//  GuanHealth
//
//  Created by hermit on 15/3/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UserRes.h"

#define kBPraisePush @"bPraisePush"
#define kBCommPush @"bCommPush"
#define kBFunsPush @"bFunsPush"
@implementation UserRes
@synthesize isPush;
- (NSString *)getBirthdayStr
{
    if (_birthday.length<=0) {
        return @"";
    }else{
        NSString *birth = [_birthday stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
        birth = [birth stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
        //if (![birth hasSuffix:@"日"]) {
        birth = [NSString stringWithFormat:@"%@日",birth];
        //}
        return birth;
    }
}

- (NSString *)getSexStr
{
    if (_sex == 1){
        return @"女";
    }else{
        return @"男";
    }
}

- (NSString *)getHeight
{
    if (_height<0) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@cm",@(_height)];
}

- (NSString *)getWeight
{
    if (_weight<0) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@kg",@(_weight)];
}

- (NSString *)getAge
{
    if (_age<=0) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@岁",@(_age)];
}

- (BOOL)hasSetUserInfo
{
    return self.completionStatus == 1;
}

- (BOOL)isGirl
{
    return self.sex == 1;
}
//- (NSInteger)bPraisePush
//{
//    return [kUserDefaults integerForKey:kBPraisePush];
//}
//- (NSInteger)bFunsPush
//{
//    return [kUserDefaults integerForKey:kBFunsPush];
//}
//- (NSInteger)bCommPush
//{
//    return [kUserDefaults integerForKey:kBCommPush];
//}
//- (void)setBCommPush:(BOOL)bCommPush
//{
//    [kUserDefaults setBool:bCommPush forKey:kBCommPush];
//    NSLog(@"%d", [kUserDefaults boolForKey:kBCommPush]);
//}
//- (void)setBFunsPush:(BOOL)bFunsPush
//{
//    [kUserDefaults setBool:bFunsPush forKey:kBFunsPush];
//}
//- (void)setBPraisePush:(BOOL)bPraisePush
//{
//    [kUserDefaults setBool:bPraisePush forKey:kBPraisePush];
//}
//- (BOOL)hasBind
//{
//    return self.bindStatus == 1;
//}

@end
