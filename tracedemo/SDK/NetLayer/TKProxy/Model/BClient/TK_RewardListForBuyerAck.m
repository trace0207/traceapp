//
//  TK_RewardListForBuyerAck.m
//  tracedemo
//
//  Created by cmcc on 16/3/16.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TK_RewardListForBuyerAck.h"
#import "NSString+HFStrUtil.h"
#import "UIKitTool.h"


@implementation RewardData



-(NSArray *)getPicsArrays
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if(![NSString isStrEmpty:self.picAddr1])
    {
//        + (NSString*)getRawImage:(NSString*)imageUrl;
        [array addObject: [UIKitTool getRawImage:self.picAddr1]];
    }
    
    if(![NSString isStrEmpty:self.picAddr2])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr2]];
    }
    if(![NSString isStrEmpty:self.picAddr3])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr3]];
    }
    if(![NSString isStrEmpty:self.picAddr4])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr4]];
    }
    if(![NSString isStrEmpty:self.picAddr5])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr5]];
    }
    if(![NSString isStrEmpty:self.picAddr6])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr6]];
    }
    if(![NSString isStrEmpty:self.picAddr7])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr7]];
    }
    if(![NSString isStrEmpty:self.picAddr8])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr8]];
    }
    if(![NSString isStrEmpty:self.picAddr9])
    {
        [array addObject:[UIKitTool getRawImage:self.picAddr9]];
    }
    
    return array;
}

@end

@implementation TK_RewardListForBuyerAck

@end
