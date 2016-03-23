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
    CGFloat textHeight;// content文字的高度
    
    CGFloat constFieldHeight; //不可变化高度区域的 高度
    
    CGFloat picWidth;
    CGFloat picHeight; // 全部的高度
    
    CGFloat cellContentPaddingLeftAndRight;
    CGFloat picPaddingLeftAndRight;//  多张图片时，默认左右边距
    
    CGFloat parentViewWidth;
    CGFloat heightByWidth; // 长宽比
}


@end

@implementation TKIShowGoodsRowM


-(instancetype)init
{
    self = [super init];
    imageFieldHeight = 0.0f;
    constFieldHeight = 360 - 128 - 21;
    textHeight = 50;
    cellContentPaddingLeftAndRight = 0;//  cell contentView默认的边距 * 2
    picPaddingLeftAndRight = 5 * 2; //两边距离一共
    parentViewWidth = TKScreenWidth - 25 - 36 - 25 - 25;
    heightByWidth = 1.0f;
    return self;
}


-(CGFloat)rowHeight
{
    [self checkImageFieldHeightInit];
    return constFieldHeight + textHeight + imageFieldHeight;
}


-(void)checkImageFieldHeightInit
{
    if(imageFieldHeight == 0)// 默认值是 0
    {
        imageFieldHeight = [self countPicFieldHeight:self.showGoodsData.pics];
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


-(CGFloat)getContentTextHeight
{
    return textHeight;
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



-(CGFloat)getFrameX:(NSInteger)index
{
//    
//    CGFloat px = i%type * ([rowD getPicWidth] +[rowD getPicSeparation]) + [rowD getPicPaddingLeft];
//    CGFloat py = i/type * ([rowD getPicHeight] + [rowD getPicSeparation]);
    
    return index%2 *(picWidth + [self getPicSeparation]);
    
}
-(CGFloat)getFrameY:(NSInteger)index
{
    return (index/2)*(picWidth * heightByWidth +[self getPicSeparation]);
}


-(CGFloat)countPicFieldHeight:(NSMutableArray *)pics
{
    NSInteger count = pics.count;
    
    if(count == 0)
    {
        return 0.0f;
    }
    
    if(count == 1 || count == 2)
    {
        picWidth  = (parentViewWidth - cellContentPaddingLeftAndRight - [self getPicSeparation] - picPaddingLeftAndRight)/2;
        picHeight = picWidth * heightByWidth;
        return picHeight;
    }
    else //if(count == 3 || count == 4) // 最多只显示四张
    {
        picWidth  = (parentViewWidth - cellContentPaddingLeftAndRight - [self getPicSeparation] - picPaddingLeftAndRight)/2;
        picHeight = picWidth * heightByWidth;
        return  picWidth * heightByWidth *2 + [self getPicSeparation];
    }
    
    
    
    
//    if(count == 1 )
//    {
//        picWidth = parentViewWidth - cellContentPaddingLeftAndRight - picPaddingLeftAndRight;// 左右边距各 20
//        picHeight = picWidth * heightByWidth ;
//        return picHeight;
//    }
//    else
//        if(count == 2)
//    {
//        picWidth = (parentViewWidth - cellContentPaddingLeftAndRight - [self getPicSeparation] - picPaddingLeftAndRight)/2;
//        picHeight = picWidth * heightByWidth;
//        return picHeight;
//    }else
//    {
//        picWidth = (parentViewWidth - cellContentPaddingLeftAndRight - [self getPicSeparation] *2 - picPaddingLeftAndRight)/3;
//        picHeight = picWidth;
//        NSInteger row = count /3;
//     
//        NSInteger rowCount = count % 3; //  如果不是刚好一行三个，则高度要增加一个 imageHeight的高度
//        if(rowCount > 0)
//        {
//            row = row +1;
//        }
//        
//        return picHeight * row + (row -1)*10;
//    }

    
    
}


@end
