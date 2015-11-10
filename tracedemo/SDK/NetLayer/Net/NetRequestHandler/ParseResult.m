//
//  ParseResult.m
//  GuanHealth
//
//  Created by hermit on 15/2/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "ParseResult.h"
#import "LoginRes.h"
#import "RegisterRes.h"
#import "VercodeRes.h"
#import "UserRes.h"
#import "DataRes.h"
#import "PostRes.h"
#import "TimeLineRes.h"
#import "ModuleRes.h"
#import "ActivitiesRes.h"
#import "HiModuleListRes.h"
#import "FriendsRes.h"
#import "HabitRes.h"
#import "HomePageRes.h"
#import "UploadRes.h"
#import "PostDetailRes.h"
#import "MyPostListRes.h"
#import "GetSudoKuRes.h"
#import "UploadGameRes.h"
#import "HFCommentLikeListRes.h"
#import "HFCommentUsersRes.h"
#import "HFSubmitLikeRes.h"





@implementation ParseResult


typedef ResponseData* (^ParseTemplateBlock)(NSDictionary *json, Class class);

//ParseTemplateBlock parseTemplate = ^(NSDictionary *json, Class class) {
//    NSError* error = nil;
//    id Res = [[class alloc] initWithDictionary:json error:&error];
//    [Res transfrom];
//    //NSLog(@"Res :%@, ", [Res description]);
//    return Res;
//};
//
//ParseBlock parseLogin = ^(NSDictionary *json) {
//    return parseTemplate(json, [LoginRes class]);
//};
//
//ParseBlock parseRegister = ^(NSDictionary *json) {
//    return parseTemplate(json, [VercodeRes class]);
//};
//
//ParseBlock parseUserInfo = ^(NSDictionary *json) {
//    return parseTemplate(json, [DataRes class]);
//};
//ParseBlock parseTimeLineInfo = ^(NSDictionary *json) {
//    return parseTemplate(json, [TimeLineRes class]);
//};
//ParseBlock parseModules = ^(NSDictionary *json) {
//    return parseTemplate(json, [ModuleRes class]);
//};
//ParseBlock parseActivities = ^(NSDictionary *json) {
//    return parseTemplate(json, [ActivitiesRes class]);
//};
//ParseBlock parseHimodulesList = ^(NSDictionary *json) {
//    return parseTemplate(json, [HiModuleListRes class]);
//};
////ParseBlock parseMyModulesList = ^(NSDictionary *json, ResponseData *response) {
////    return parseTemplate(json, response, [MyModulesListRes class]);
////};
//ParseBlock parseMyHabitList = ^(NSDictionary *json) {
//    return parseTemplate(json, [HabitRes class]);
//};
//ParseBlock parseHomePage = ^(NSDictionary *json) {
//    return parseTemplate(json, [HomePageRes class]);
//};
//ParseBlock parseGetFollows = ^(NSDictionary *json) {
//    return parseTemplate(json, [FriendsRes class]);
//};
//ParseBlock parseUploadImage = ^(NSDictionary *json) {
//    return parseTemplate(json, [UploadRes class]);
//};
//ParseBlock parseGetPostDetail = ^(NSDictionary *json) {
//    return parseTemplate(json, [PostDetailRes class]);
//};
//ParseBlock parseGetPostList = ^(NSDictionary *json) {
//    return parseTemplate(json, [MyPostListRes class]);
//};
//ParseBlock parseGetSudoKu = ^(NSDictionary *json) {
//    return parseTemplate(json, [GetSudoKuRes class]);
//};
//ParseBlock parseUploadGame = ^(NSDictionary *json) {
//    return parseTemplate(json, [UploadGameRes class]);
//};
////点赞列表Block
//ParseBlock parseLikeList = ^(NSDictionary * json){
//    return parseTemplate(json, [HFCommentLikeListRes class]);
//};
////评论列表Block
//ParseBlock parseCommentUsersList = ^(NSDictionary * json){
//    return parseTemplate(json,[HFCommentUsersRes class]);
//};
////点赞
//ParseBlock parseSubmitLike = ^(NSDictionary * json){
//    return parseTemplate(json,[HFSubmitLikeRes class]);
//};


@end
