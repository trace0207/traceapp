//
//  TK_PublishMakeSureView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/1.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_PublishMakeSureView.h"
#import "TK_UploadImageAck.h"
#import "TKPublishShowGoodsArg.h"

@implementation TK_PublishMakeSureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    self = [super init];
    self.frame = [UIScreen mainScreen].bounds;
     _errorImage.hidden = YES;
    _loading.hidden = NO;
    [_loading startAnimating];
    _loadingTips.text = @"正在上传图片...";
    [self performSelector:@selector(showLoadingError) withObject:nil afterDelay:30.0f];
    return self;
}


-(void)showLoadingError{

    _errorImage.hidden = NO;
    [_loading stopAnimating];
    _loading.hidden = YES;
    _loadingTips.text = @"发布悬赏超时，请重试";
    
}

/**
 图片上传结果返回
 **/
-(void)onImageUploadSuccess:(NSArray *)acks
{
    
    //        DDLogInfo(@"upload images array %@",acks);
    BOOL isAnyFailed = NO;
    NSMutableArray * picArray = [[NSMutableArray alloc] init];
    for(TK_UploadImageAck *a in acks)
    {
        if([a sucess])
        {
            [picArray addObject:a.data.imgUrl];
        }else
        {
            isAnyFailed = YES;
        }
    }
    
    if(isAnyFailed)
    {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLoadingError) object:nil];
        [self showLoadingError];
        
    }
    else
    {
        
        self.images = nil;
        
        TKPublishShowGoodsArg * arg = [[TKPublishShowGoodsArg alloc] init];
        if(picArray.count > 0)
        {
            arg.picAddr1 = picArray[0];
        }
        if(picArray.count > 1)
        {
            arg.picAddr2 = picArray[1];
        }
        if(picArray.count > 3)
        {
            arg.picAddr3 = picArray[2];
        }
        if(picArray.count > 4)
        {
            arg.picAddr4 = picArray[3];
        }
        if(picArray.count > 5)
        {
            arg.picAddr5 = picArray[4];
        }
        if(picArray.count > 6)
        {
            arg.picAddr6 = picArray[5];
        }
        if(picArray.count > 7)
        {
            arg.picAddr7 = picArray[6];
        }
        if(picArray.count > 8)
        {
            arg.picAddr8 = picArray[7];
        }
        if(picArray.count > 9)
        {
            arg.picAddr9 = picArray[8];
        }
        
        arg.content = self.content;
        arg.showPrice = self.showPrice;
#if B_Client == 0
       arg.role = 1;
#endif
        
    
        arg.brandId = 1;
        arg.categoryId = 3;
        
        WS(weakSelf)
        [[TKProxy proxy].mainProxy publishShowGoods:arg withBlock:^(HF_BaseAck *ack) {
            if(ack.sucess)
            {
                [weakSelf removeFromSuperview];
                weakSelf.images = nil;
            }
            else
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLoadingError) object:nil];
                [weakSelf showLoadingError];
            }
        }];
    }
    
    
    
}



- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
}


-(void)beginSend
{
    WS(weakSelf)
    [[TKProxy proxy].mainProxy uploadMutableImages:self.images withtype:1 withBlock:^(NSArray * acks) {

        [weakSelf onImageUploadSuccess:acks];
    } ];
}
@end
