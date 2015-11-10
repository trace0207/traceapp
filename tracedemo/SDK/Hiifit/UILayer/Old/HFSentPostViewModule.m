//
//  HFSentPostViewModule.m
//  GuanHealth
//
//  Created by 罗田佳 on 15/6/18.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFSentPostViewModule.h"
#import "UploadRes.h"
#import "NSString+HFStrUtil.h"
#import "GlobNotifyDefine.h"

@implementation SendData

@end


@interface HFSentPostViewModule()
{
    BOOL bUploadImage;
}
@property(nonatomic,strong)NSMutableArray *imagePaths;

@property(nonatomic,strong)uploadImageFinishBlock block;
@end

@implementation HFSentPostViewModule


#pragma mark -
#pragma mark PublishMoment
-(BOOL)sendMomentData:(SendData *) data{
    
    DDLogInfo(@"Send Data %@",data);
    
    // 检查条件
    NSString *tips = nil;
    NSString *testStr = [data.content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    testStr = [testStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (data.picArray.count == 0  && testStr.length == 0) {// 只检测纯空格 和 换行符的情况
        tips = @"不能发表空内容";
    }
    
    if (data.content.length > 400) {
        tips = @"发表内容不能超过400字！";
    }
    
    if (![UIKitTool checkSensitiveWords:data.content]) {
        tips = @"你发送的内容含有敏感词汇，请修改后发送。";
    }
    
    if (tips) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:tips commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        
        return NO;
    }
    
    
    
    bUploadImage = NO;
    
    
    if (data.picArray.count == 0) {
        [self publishMomentContent:data withImage:nil];
    }else{
        
        // 上传图片
        
        [self uploadImages:data.picArray imageType:HIUploadImageTypePost compeltion:^(NSArray *urls,BOOL success) {
            if (success) {
                [self publishMomentContent:data withImage:urls];
            }
        }];
    }
    return YES;
    
}

- (void)uploadImages:(NSArray *)picArray imageType:(HIUploadImageType)type compeltion:(uploadImageFinishBlock)block
{
    
    self.block = block;
    
    for (int i = 0; i < [picArray count]; i++)
    {
        [self.imagePaths addObject:@""];
    }
    
    if (picArray.count == 0)
    {
        DDLogDebug(@"上传的数组不能为空");
        return;
    }
    
    [self recursionUploadPics:picArray atIndex:0 withImageType:type];
    
}


- (void)recursionUploadPics:(NSArray *)picArray atIndex:(NSInteger)index withImageType:(HIUploadImageType)type
{
    UIImage *image = [picArray objectAtIndex:index];
    
    __block  NSInteger  picIndex = index;
    
    WS(weakSelf)
    [[NetHTTPClient shareInstance]uploadImage:image
                                         type:type
                                    showToast:NO
                                     callback:^(ResponseData *responseData) {
                                         UploadRes *res = (UploadRes*)responseData;
                                         if ([res success]) {
                                             [weakSelf.imagePaths replaceObjectAtIndex:picIndex withObject:res.path];
                                             picIndex++;
                                             
                                             if (picIndex != picArray.count)
                                             {
                                                 [weakSelf recursionUploadPics:picArray atIndex:picIndex withImageType:type];
                                                 //block(imagePaths,YES);
                                             }
                                             else
                                             {
                                                 weakSelf.block(weakSelf.imagePaths,YES);
                                             }
                                         }else{
                                             weakSelf.block(nil,NO);
                                            // block(nil,NO);
                                             
                                             if (!bUploadImage)
                                             {
                                                 bUploadImage = YES;
                                                 DDLogInfo(@"上传图片失败  msg = %@",responseData.msg);
                                                 [[HFHUDView shareInstance] ShowTips:@"上传图片失败" delayTime:1.0 atView:nil];
                                                 
                                             }
                                         }
                                     }];
}

/**
 发表心情帖 文本
 **/
- (void)publishMomentContent:(SendData *) data withImage:(NSArray *)imagePaths
{
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic setObject:[NSNumber numberWithInt:data.type] forKey:@"weiboType"];
    if (data.content.length>0) {
        [muDic setObject:[data.content URLEncodedForString] forKey:@"content"];
    }
    if (data.title.length > 0) {
        [muDic setObject:[data.title URLEncodedForString] forKey:@"title"];
    }
    if (data.id>0) {
        [muDic setObject:[NSNumber numberWithInteger:data.id] forKey:@"id"];
    }
    if (data.tiebaId>0) {
        [muDic setObject:[NSNumber numberWithInteger:data.tiebaId] forKey:kParamTiebaId];
    }
    
    for (NSUInteger i = 0; i < imagePaths.count; i++) {
        
        
        NSString *key = [NSString stringWithFormat:@"pic_addr_0%lu",(unsigned long)i+1];
        
        NSString *path = [imagePaths objectAtIndex:i];
        if (path.length>0) {
            [muDic setObject:path forKey:key];
        }
        
    }
    HFUploadPostReq *req = [[HFUploadPostReq alloc]initWithDictionary:muDic error:nil];
    if (req) {
        [[[HIIProxy shareProxy]weiboProxy]uploadPost:req completion:^(BOOL finished) {
            if (finished) {
                [[HFHUDView shareInstance] ShowTips:@" 发表成功" delayTime:1.0 atView:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:PublishSuccessNotification object:nil];
                [[[HIIProxy shareProxy]userProxy]getUserInfo:^(BOOL finished) {
                    
                }];
            }else {
                [[HFHUDView shareInstance] ShowTips:@" 发表失败" delayTime:1.0 atView:nil];
            }
        }];
    }

}

#pragma mark -
#pragma mark getter
- (NSMutableArray *)imagePaths
{
    if (!_imagePaths)
    {
        _imagePaths = [[NSMutableArray alloc] init];
    }
    return _imagePaths;
}


@end
