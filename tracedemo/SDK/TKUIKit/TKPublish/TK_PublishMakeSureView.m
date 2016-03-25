//
//  TK_PublishMakeSureView.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/1.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_PublishMakeSureView.h"
#import "TK_UploadImageAck.h"
#import "TK_PublishRewardArg.h"
#import "TKUserCenter.h"
#import "TK_PayArg.h"
#import "TK_PublishRewardAck.h"
#import "TKPayProxy.h"
#import "TK_PayAck.h"

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


/**
 任意一个中间过程出现失败时显示
 **/
-(void)showLoadingError{

    _errorImage.hidden = NO;
    [_loading stopAnimating];
    _loading.hidden = YES;
    _loadingTips.text = @"发布悬赏超时，请重试";
    
}


/**
 悬赏发布成功，并且支付成功
 **/
-(void)onPaySuccess
{
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
        
        TK_PublishRewardArg * arg = [[TK_PublishRewardArg alloc] init];
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
//        arg.rewardPrice = [TK]self.showPrice * 100;
//#if B_Client == 0
//       arg.role = 1;
//#endif
//        
//    
//        arg.brandId = 1;
//        arg.categoryId = 3;
        
        arg.rewardPrice = self.showPrice;
        arg.content = self.content;
        arg.source = @"1";// 1 自主发起
        arg.sourceId = [[TKUserCenter instance] getUser].userId;
        arg.categoryId = @"2";
        arg.brandId = @"2";
        arg.receiverId = @"1";
        arg.requireDay = @"1";
        
        
        WS(weakSelf)
        [[TKProxy proxy].mainProxy publishReward:arg withBlock:^(HF_BaseAck *ack) {
            if(ack.sucess)
            {
                TK_PublishRewardAck * a = (TK_PublishRewardAck*)ack;
                [weakSelf requestPay:a.data.deposit postrewardId:a.data.rewardId];
            }
            else
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLoadingError) object:nil];
                [weakSelf showLoadingError];
            }
        }];
    }
}



-(void)requestPay:(NSString *) money postrewardId:(NSString *)postId
{
    
    TK_PayArg * arg = [[TK_PayArg alloc] init];
    arg.bigMoney = 0;
    arg.payAmount = money;
    
    arg.postrewardId = postId;
    arg.fundType = 0;//0 订金， 1 尾款， 2全款， 3 买手充值保证金
//    arg.clientIp = @"192.168.1.1";
    
    WS(weakSelf)
    
    [TKPayProxy pay:arg
          withBlick:^(NSInteger result) {
              if(result == 1)
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
