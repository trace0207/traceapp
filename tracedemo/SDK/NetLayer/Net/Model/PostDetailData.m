//
//  PostDetailData.m
//  GuanHealth
//
//  Created by hermit on 15/5/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "PostDetailData.h"
#import "NSString+HFStrUtil.h"

@implementation PostDetailData
- (void)copyFromData:(Data*)data
{
    if (![data isKindOfClass:[Data class]]) {
        return;
    }
    self.title = data.title;
    self.type = data.weiboType;
    self.name = data.remark;
    self.praised = data.isPraise;
    self.weiboId = data.goalId;
    self.content = data.content;
    self.nickName = data.operatorName;
    self.commentNum = data.commentNum;
    self.praiseNum = data.praiseNum;
    self.authorId = data.operatorId;
    self.secondTime = data.createTimeUTC;
    self.headPortraitUrl = data.headPortraitUrl;
    self.picAddr1 = data.picAddr1;
    self.picAddr2 = data.picAddr2;
    self.picAddr3 = data.picAddr3;
    self.picAddr4 = data.picAddr4;
    self.picAddr5 = data.picAddr5;
    self.picAddr6 = data.picAddr6;
    self.picAddr7 = data.picAddr7;
    self.picAddr8 = data.picAddr8;
    self.picAddr9 = data.picAddr9;
    self.expandFlag = data.expandFlag;
}

- (void)transfrom
{
    _content = [_content URLDecodedForString];
    _title = [_title URLDecodedForString];
}

@end
