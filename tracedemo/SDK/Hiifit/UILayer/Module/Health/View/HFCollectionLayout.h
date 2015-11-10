//
//  HFCollectionLayout.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFCollectionLayoutDelegate <NSObject>

- (BOOL)showScaleCollectionCell:(BOOL)bShow AtIndexPath:(NSIndexPath *)indexPath;

- (void)centerCollectionCellAtIndex:(NSInteger)index;
@end

@interface HFCollectionLayout : UICollectionViewFlowLayout

@property(nonatomic,weak)id<HFCollectionLayoutDelegate>delegate;

@end
