//
//  HFCollectionCell.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, collectionStyle) {
    nomarlCell_Type = 0,
    CenterCell_Type,
    NoVisiableCell_Type,
};

@interface HFCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet BasePortraitView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *mTextLabel;
@property (nonatomic) collectionStyle mStyle;


- (void)setTitlePage:(NSInteger)title
         withMAXPage:(NSInteger)max
    withVisiablePage:(NSInteger)visiable;


@end
