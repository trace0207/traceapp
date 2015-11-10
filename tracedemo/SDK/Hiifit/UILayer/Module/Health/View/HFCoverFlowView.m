//
//  HFCoverFlowView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/7/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCoverFlowView.h"
#import "HFCollectionLayout.h"
#import "HFCollectionCell.h"

@interface HFCoverFlowView()<HFCollectionLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger mMaxNum;
    
    NSInteger mCurrentIndex;
    
    NSInteger mVisiableindex;
}

@end

@implementation HFCoverFlowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
}

#pragma mark -
#pragma mark private
- (void)setMaxCoverNum:(NSInteger)maxNum
       CurrentCoverNum:(NSInteger)nCurrent
         visiableCover:(NSInteger)nVisiable
{
    
    mMaxNum = maxNum;
    
    mCurrentIndex = nCurrent;
    
    mVisiableindex = nVisiable;
    
   // [self.mCollectionView reloadData];
    
    if ([self respondsToSelector:@selector(scrollCoverToShow)])
    {
        [self performSelector:@selector(scrollCoverToShow) withObject:nil afterDelay:0.5];
    }
    
}


- (void)scrollCoverToShow
{
    [self.mCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:mCurrentIndex + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(coverFlowSelectedAtIndex:)])
//    {
//        [_delegate coverFlowSelectedAtIndex:mCurrentIndex];
//    }
}

#pragma mark -
#pragma mark Getter
- (UICollectionView *)mCollectionView
{
    if (!_mCollectionView)
    {
        HFCollectionLayout * layout = [[HFCollectionLayout alloc] init];
        layout.delegate = self;
        _mCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
        _mCollectionView.backgroundColor = [UIColor clearColor];
        _mCollectionView.showsHorizontalScrollIndicator = NO;
        [_mCollectionView registerNib:[UINib nibWithNibName:@"HFCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CoverCell"];
        _mCollectionView.bounces = NO;
        [self addSubview:_mCollectionView];
    }
    
    return _mCollectionView;
}

#pragma mark -
#pragma mark HFCollectionLayoutDelegate
- (BOOL)showScaleCollectionCell:(BOOL)bShow AtIndexPath:(NSIndexPath *)indexPath
{

    return NO;
}

- (void)centerCollectionCellAtIndex:(NSInteger)index
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(coverFlowSelectedAtIndex:)])
    {
        [_delegate coverFlowSelectedAtIndex:index - 1];
    }
}

#pragma mark -
#pragma mark UICollectionViewDelegate  && DataSource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return mCurrentIndex + 4;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((self.frame.size.width - 40) / 5, (self.frame.size.width - 40) / 5);
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"cell  init");
    
    HFCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CoverCell" forIndexPath:indexPath];
    [cell setTitlePage:indexPath.item - 1 withMAXPage:mMaxNum withVisiablePage:mVisiableindex];
  //  cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
//  
//    cell.bgImageView.image = IMG(@"nomarlDay");
//    cell.mTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item - 1];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HFCollectionCell * cell = (HFCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.mStyle == NoVisiableCell_Type)
    {
        return;
    }
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (indexPath.item - 1 > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(coverFlowSelectedAtIndex:)])
        {
            [_delegate coverFlowSelectedAtIndex:indexPath.item - 1];
        }
    }
    
}

- (void)dealloc
{
    //_mCollectionView.collectionViewLayout = nil;
    _mCollectionView.dataSource = nil;
    _mCollectionView.delegate = nil;
    _mCollectionView = nil;
    
    NSLog(@"1111111111111");
//    [[NSRunLoop currentRunLoop] cancelPerformSelectorsWithTarget:self];
}

#pragma mark -
#pragma mark HFCollectionCellDelegate


@end
