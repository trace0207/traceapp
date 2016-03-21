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
    
    CGFloat cellContentPaddingLeftAndRight;
    CGFloat picPaddingLeftAndRight;//  多张图片时，默认左右边距
}


@end

@implementation TKIShowGoodsRowM


-(instancetype)init
{
    self = [super init];
    imageFieldHeight = 0.0f;
    constFieldHeight = 360;
    cellContentPaddingLeftAndRight = 16;//  cell contentView默认的边距 * 2
    picPaddingLeftAndRight = 5 * 2; //两边距离一共
    return self;
}


-(CGFloat)rowHeight
{
    [self checkImageFieldHeightInit];
    return constFieldHeight ; // + imageFieldHeight;
}


-(void)checkImageFieldHeightInit
{
    if(imageFieldHeight == 0)// 默认值是 0
    {
        imageFieldHeight = [self getPicHeight:self.showGoodsData.pics];
    }

}



-(CGFloat)getPicWidth
{
    [self checkImageFieldHeightInit];
    return picWidth;
}
-(CGFloat)getPicSeparation
{
    return 6;
}

-(CGFloat)getImageFiledHeight
{
    [self checkImageFieldHeightInit];
    return imageFieldHeight;
}

-(CGFloat)getPicHeight
{
    [self checkImageFieldHeightInit];
    return picHeight;
}

-(CGFloat)getPicPaddingLeft
{
    return picPaddingLeftAndRight/2;
}



-(CGFloat)getPicHeight:(NSMutableArray *)pics
{
    NSInteger count = pics.count;
    
    if(count == 0)
    {
        return 0.0f;
    }
    if(count == 1)
    {
        picWidth = TKScreenWidth - cellContentPaddingLeftAndRight - picPaddingLeftAndRight;// 左右边距各 20
        picHeight = picWidth * 0.75 ;
        return picHeight;
    }else if(count == 4)
    {
        picWidth = (TKScreenWidth - cellContentPaddingLeftAndRight - [self getPicSeparation] - picPaddingLeftAndRight)/2;
        picHeight = picWidth * 0.75;
        return picHeight * 2 + 10;
    }else
    {
        picWidth = (TKScreenWidth - cellContentPaddingLeftAndRight - [self getPicSeparation] *2 - picPaddingLeftAndRight)/3;
        picHeight = picWidth;
        NSInteger row = count /3;
     
        NSInteger rowCount = count % 3; //  如果不是刚好一行三个，则高度要增加一个 imageHeight的高度
        if(rowCount > 0)
        {
            row = row +1;
        }
        
        return picHeight * row + (row -1)*10;
    }
}


@end
