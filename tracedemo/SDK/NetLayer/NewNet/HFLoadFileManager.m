//
//  HFLoadFileManager.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/7.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFLoadFileManager.h"

@interface HFLoadFileManager()
{
    AFHTTPRequestOperation *operation;
}
@end

@implementation HFLoadFileManager
SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HFLoadFileManager, shareInstance)

//获取已下载的文件大小
- (unsigned long long)fileSizeForPath:(NSString *)path {
    unsigned long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

//从Caches中得到文件的路径
- (NSString *)getFilePathFromCaches:(NSString *)fileName
{
    NSArray *arr = [fileName componentsSeparatedByString:@"/"];
    NSString *file = [arr lastObject];
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileDirectory = [cacheDirectory stringByAppendingPathComponent:file];
    return fileDirectory;
}

//从Documents中得到文件的路径
- (NSString *)getFilePathFromDocuments:(NSString *)fileName
{
    NSArray *arr = [fileName componentsSeparatedByString:@"/"];
    NSString *file = [arr lastObject];
    NSString *DocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileDirectory = [DocumentsDirectory stringByAppendingPathComponent:file];
    return fileDirectory;
}

//把缓存的文件移到documents目录下，然后删除缓存文件
- (BOOL)moveFileToDocumentsWithFileName:(NSString *)fileName
{
    NSString *cachesPath = [self getFilePathFromCaches:fileName];
    NSString *documentsPath = [self getFilePathFromDocuments:fileName];
    NSFileManager *fileManager = [NSFileManager new];
    if ([fileManager fileExistsAtPath:documentsPath]) {
        [fileManager removeItemAtPath:documentsPath error:nil];
    }
    BOOL result = [fileManager copyItemAtPath:cachesPath toPath:documentsPath error:nil];
    if (result) {
        [fileManager removeItemAtPath:cachesPath error:nil];
    }
    return result;
}

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
{
    _isLoading = YES;
    NSString *downloadPath = [self getFilePathFromCaches:fileUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    
    //检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
        //获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:downloadPath];
        if (downloadedBytes > 0) {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    //不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    //下载请求
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //下载路径
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:downloadPath append:YES];
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        if (totalBytesExpectedToRead > 0) {
            CGFloat rate = (CGFloat)(totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
            if (progress) {
                progress(rate);
            }
        }else {
            if (faulure) {
                faulure(nil);
            }
        }

    }];
    WS(weakSelf)
    //成功和失败回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([weakSelf moveFileToDocumentsWithFileName:fileUrl]) {
            if (success) {
                success();
            }
        }else {
            if (faulure) {
                faulure(nil);
            }
        }
        _isLoading = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (faulure) {
            faulure(error);
        }
        _isLoading = NO;
    }];
    [operation start];
}

//停止下载
- (void)cancelLoad
{
    _isLoading = NO;
    [operation cancel];
    [operation setCompletionBlock:nil];
}

@end
