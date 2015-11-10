//
//  HFCoverFlowView.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFCoverFlowViewDelegate <NSObject>

- (void)coverFlowSelectedAtIndex:(NSInteger)index;

@end

@interface HFCoverFlowView : UIView

@property(nonatomic,weak)id<HFCoverFlowViewDelegate>delegate;
@property(nonatomic,strong)UICollectionView * mCollectionView;
- (void)setMaxCoverNum:(NSInteger)maxNum
       CurrentCoverNum:(NSInteger)nCurrent
        visiableCover:(NSInteger)nVisiable;


@end
