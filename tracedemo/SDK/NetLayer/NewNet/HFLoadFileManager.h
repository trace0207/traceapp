//
//  HFLoadFileManager.h
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFLoadFileManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HFLoadFileManager, shareInstance)

//读取文件的大小
- (unsigned long long)fileSizeForPath:(NSString *)path;

//从Caches中得到文件的路径
- (NSString *)getFilePathFromCaches:(NSString *)fileName;

//从Documents中得到文件的路径
- (NSString *)getFilePathFromDocuments:(NSString *)fileName;
@property (nonatomic, assign, readonly) BOOL isLoading;//是否正在下载
/**
 *  下载文件，支持断点续传
 *
 *  @param fileUrl 文件的链接
 *  @param progress 下载进度回调
 *  @param success 成功回调
 *  @param faulure 失败回调
 */
- (void)loadFileWithUrl:(NSString *)fileUrl
               progress:(void(^)(CGFloat rate))progress
                success:(void(^)())success
                failure:(void(^)(NSError *error))faulure;

//停止下载
- (void)cancelLoad;

@end
