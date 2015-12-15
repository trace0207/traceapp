//
//  TKIShowGoodsRowM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIShowGoodsRowM.h"

@implementation TKShowGoodsRowData


-(NSMutableArray *)pics
{
    if(!_pics)
    {
        _pics = [[NSMutableArray alloc] init];
    }
    return _pics;
}

@end

@interface TKIShowGoodsRowM()
{

    CGFloat imageFieldHeight; // 图片区域的高度
    CGFloat constFieldHeight; //不可变化高度区域的 高度
    
    CGFloat picWidth;
    CGFloat picHeight;
}

@end

@implementation TKIShowGoodsRowM


-(instancetype)init
{
    self = [super init];
    imageFieldHeight = 0.0f;
    constFieldHeight = 250;
    return self;
}


-(CGFloat)rowHeight
{
    
    imageFieldHeight = [self getPicHeight:self.showGoodsData.pics];
    
    return constFieldHeight + imageFieldHeight;
}


-(CGFloat)getPicWidth
{
    return picWidth;
}
-(CGFloat)getPicSeparation
{
    return 10;
}

-(CGFloat)getPicHeight
{
    return picHeight;
}



-(CGFloat)getPicHeight:(NSMutableArray *)pics
{
    NSInteger count = pics.count;
    
    if(count == 1)
    {
        picWidth = TKScreenWidth - 20;// 左右边距各 20
        picHeight = picWidth * 0.75 ;
        return picHeight;
    }else if(count == 4)
    {
        picWidth = (TKScreenWidth - 20 - 10)/2;
        picHeight = picWidth * 0.75;
        return picHeight * 2 + 10;
    }else
    {
        picWidth = (TKScreenWidth - 20 - 10 *2)/3;
        picHeight = picWidth;
        NSInteger row = count /3;
        return picWidth * row + (row -1)*10;
    }
}


@end
