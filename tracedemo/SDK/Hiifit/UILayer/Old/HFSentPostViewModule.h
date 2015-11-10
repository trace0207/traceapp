//
//  HFSentPostViewModule.h
//  GuanHealth
//
//  Created by 罗田佳 on 15/6/18.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^uploadImageFinishBlock)(NSArray * urls ,BOOL success);

@interface SendData : NSObject

@property (nonatomic, copy) NSString * title;
@property(nonatomic, strong)NSString *  content;
@property(nonatomic, strong)NSMutableArray * picArray;
@property(nonatomic, assign)HIWeiboType type;
@property(nonatomic, assign)NSInteger id;
@property(nonatomic, assign)NSInteger tiebaId;

@end


@interface HFSentPostViewModule : NSObject


/**
 *  上传图片接口
 *
 *  @param picArray 图片数组
 *  @param block    url的数组
 */
- (void)uploadImages:(NSArray *)picArray imageType:(HIUploadImageType)type compeltion:(uploadImageFinishBlock)block;

-(BOOL)sendMomentData:(SendData *) data;
@end
