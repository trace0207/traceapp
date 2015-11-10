//
//  HFCollectionCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCollectionCell.h"

@interface HFCollectionCell()
{
    NSInteger mTitle;
    NSInteger mMax;
    NSInteger mVisiable;
}
@property(nonatomic,strong)UICollectionViewLayoutAttributes * attributes;
@end


@implementation HFCollectionCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)setTitlePage:(NSInteger)title
         withMAXPage:(NSInteger)max
    withVisiablePage:(NSInteger)visiable
{
    mTitle = title;
    mMax = max;
    mVisiable = visiable;
    
    [self layoutAttributes];
}

- (void)layoutAttributes
{
    if (mTitle <= 0 || mTitle > mMax)
    {
        self.hidden = YES;
        return;
    }
    
    self.hidden = NO;
    
    if (self.attributes.alpha == 1.0)
    {
        [self setCollectionCellStyle:CenterCell_Type];
    }
    else
    {
        if (mTitle <= mVisiable)
        {
            [self setCollectionCellStyle:nomarlCell_Type];
        }
        else
        {
            [self setCollectionCellStyle:NoVisiableCell_Type];
        }
        
    }
}

- (void)setCollectionCellStyle:(collectionStyle)style
{
    self.mTextLabel.text = [NSString stringWithFormat:@"%ld",mTitle];
    self.mTextLabel.adjustsFontSizeToFitWidth = YES;
    
    self.mStyle = style;
    
    if (style == nomarlCell_Type)
    {
        self.bgImageView.image = IMG(@"nomarlDay");
    }
    else if (style == CenterCell_Type)
    {
        self.mTextLabel.text = [NSString stringWithFormat:@"第%ld天",mTitle];
        self.bgImageView.image = IMG(@"currentDay");
    }
    else
    {
        self.bgImageView.image = IMG(@"tomorrowDay");
    }
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.attributes = layoutAttributes;
    [self layoutAttributes];
}

@end
