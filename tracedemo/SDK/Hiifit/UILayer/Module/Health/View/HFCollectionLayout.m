//
//  HFCollectionLayout.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCollectionLayout.h"
#import "HFCollectionCell.h"
#define ITEM_SIZE 60

@interface HFCollectionLayout()
{
    CGFloat sizeWidth;
}

@property(nonatomic)NSInteger cellCount;
@end

@implementation HFCollectionLayout

#define ACTIVE_DISTANCE 60
#define ZOOM_FACTOR 0.2

-(id)init
{
    self = [super init];
    if (self) {
        sizeWidth = ([UIScreen mainScreen].bounds.size.width - 66.0f) / 5.0f;
        self.itemSize = CGSizeMake(sizeWidth, sizeWidth);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        self.minimumLineSpacing = 10.0;
        
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / sizeWidth;
            
            CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
            attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
            
            BOOL bCenter = NO;
            
            if (ABS(distance) < self.itemSize.width) {
                bCenter = YES;
            }
        
            CGFloat alpha =  zoom > 1.0 ? 1.0 : zoom - 0.2;
            
            attributes.alpha = alpha;
            
        }
    }
    return array;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    NSInteger item = 0;
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
            item = layoutAttributes.indexPath.item;
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(centerCollectionCellAtIndex:)])
    {
        [_delegate centerCollectionCellAtIndex:item];
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


@end
