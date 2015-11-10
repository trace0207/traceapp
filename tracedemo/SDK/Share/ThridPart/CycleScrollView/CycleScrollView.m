//
//  CycleScrollView.m
//  CycleScrollDemo
//
//  Created by Weever Lu on 12-6-14.
//  Copyright (c) 2012年 linkcity. All rights reserved.
//

#import "CycleScrollView.h"

@implementation CycleScrollView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame cycleDirection:(CycleDirection)direction pictures:(NSArray *)pictureArray startIndex:(int)index
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor blackColor];
        indexArr = [[NSMutableArray alloc]init];
        for (int i = 0; i<pictureArray.count; i++) {
            [indexArr addObject:@"1"];
        }
        //NSLog(@"%@",[indexArr description]);
        scrollFrame = frame;
        scrollDirection = direction;
        totalPage = (int)pictureArray.count;
        curPage = index;                                    // 显示的是图片数组里的第一张图片
        curImages = [[NSMutableArray alloc] init];
        imagesArray = [[NSArray alloc] initWithArray:pictureArray];
        
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.backgroundColor = [UIColor blackColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
       
        
        scrollView.delegate = self;
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, 20, 100, 20)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = [NSString stringWithFormat:@"%d/%d",curPage,totalPage];
        
        selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-44, 20, 24, 24)];
        [selectImageView setImage:[UIImage imageNamed:@"unchecked"]];
        [selectImageView setHighlightedImage:[UIImage imageNamed:@"checked"]];
        selectImageView.highlighted = YES;
        
        selectBt = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBt.frame = CGRectMake(self.frame.size.width-60, 0, 60, 60);
        [selectBt addTarget:self action:@selector(cancelPhoto:) forControlEvents:UIControlEventTouchUpInside];
        //NSLog(@"333333333333");
        [self addSubview:scrollView];
        //[self insertSubview:titleLabel aboveSubview:scrollView];
        // 在水平方向滚动
        if (pictureArray.count>1) {
            if(scrollDirection == CycleDirectionLandscape) {
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3,
                                                    scrollView.frame.size.height);
                scrollView.alwaysBounceHorizontal = YES;
                scrollView.alwaysBounceVertical = NO;
            }
            // 在垂直方向滚动
            if(scrollDirection == CycleDirectionPortait) {
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,
                                                    scrollView.frame.size.height * 3);
                scrollView.alwaysBounceHorizontal = NO;
                scrollView.alwaysBounceVertical = YES;
            }
            scrollView.pagingEnabled = YES;
        }else {
            scrollView.bounces = NO;
        }
        
        
        [self addSubview:scrollView];
        [self refreshScrollView];
    }
    
    return self;
}

- (void)refreshScrollView {
    
    NSArray *subViews = [scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:curPage];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollFrame];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [curImages objectAtIndex:i];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
        [singleTap release];
        
        // 水平滚动
        if(scrollDirection == CycleDirectionLandscape) {
            imageView.frame = CGRectOffset(imageView.frame, scrollFrame.size.width * i, 0);
        }
        // 垂直滚动
        if(scrollDirection == CycleDirectionPortait) {
            imageView.frame = CGRectOffset(imageView.frame, 0, scrollFrame.size.height * i);
        }
        [scrollView addSubview:imageView];
        [imageView release];
    }
    [self insertSubview:titleLabel aboveSubview:scrollView];
    [self insertSubview:selectImageView aboveSubview:scrollView];
    [self insertSubview:selectBt aboveSubview:scrollView];
    if (scrollDirection == CycleDirectionLandscape) {
        [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0)];
    }
    if (scrollDirection == CycleDirectionPortait) {
        [scrollView setContentOffset:CGPointMake(0, scrollFrame.size.height)];
    }
}
- (void)cancelPhoto:(UIButton *)bt
{
    NSString *str = [indexArr objectAtIndex:curPage-1];
    if ([str isEqualToString:@"1"]) {
        selectImageView.highlighted = NO;
        [indexArr replaceObjectAtIndex:curPage-1 withObject:@"0"];
    }else{
        selectImageView.highlighted = YES;
        [indexArr replaceObjectAtIndex:curPage-1 withObject:@"1"];
    }
}
- (NSArray *)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:curPage-1];
    int last = [self validPageValue:curPage+1];
    
    if([curImages count] != 0) [curImages removeAllObjects];
    
    [curImages addObject:[imagesArray objectAtIndex:pre-1]];
    [curImages addObject:[imagesArray objectAtIndex:curPage-1]];
    [curImages addObject:[imagesArray objectAtIndex:last-1]];
    
    return curImages;
}

- (int)validPageValue:(int)value {
    if(value == 0){
        value = totalPage;// value＝1为第一张，value = 0为前面一张
    }
    if(value == totalPage + 1){
        value = 1;
    }
    return value;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    int y = aScrollView.contentOffset.y;
    //NSLog(@"did  x=%d  y=%d", x, y);
    
    // 水平滚动
    if(scrollDirection == CycleDirectionLandscape) {
        // 往下翻一张
        if(x >= (2*scrollFrame.size.width)) { 
            curPage = [self validPageValue:curPage+1];
            [self refreshScrollView];
        }
        if(x <= 0) {
            curPage = [self validPageValue:curPage-1];
            [self refreshScrollView];
        }
    }
    
    // 垂直滚动
    if(scrollDirection == CycleDirectionPortait) {
        // 往下翻一张
        if(y >= 2 * (scrollFrame.size.height)) { 
            curPage = [self validPageValue:curPage+1];
            [self refreshScrollView];
        }
        if(y <= 0) {
            curPage = [self validPageValue:curPage-1];
            [self refreshScrollView];
        }
    }
    
    if ([delegate respondsToSelector:@selector(cycleScrollViewDelegate:didScrollImageView:)]) {
        [delegate cycleScrollViewDelegate:self didScrollImageView:curPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    //int x = aScrollView.contentOffset.x;
    //int y = aScrollView.contentOffset.y;
    
    //NSLog(@"--end  x=%d  y=%d", x, y);
    
    if (scrollDirection == CycleDirectionLandscape) {
        [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0) animated:YES];
        
    }
    if (scrollDirection == CycleDirectionPortait) {
        [scrollView setContentOffset:CGPointMake(0, scrollFrame.size.height) animated:YES];
    }
    titleLabel.text = [NSString stringWithFormat:@"%d/%d",curPage,totalPage];
    NSString *str = [indexArr objectAtIndex:curPage-1];
    if ([str isEqualToString:@"0"]) {
        selectImageView.highlighted = NO;
    }else{
        selectImageView.highlighted = YES;
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([delegate respondsToSelector:@selector(cycleScrollViewDelegate:didSelectImageView:)]) {
        [delegate cycleScrollViewDelegate:self didSelectImageView:indexArr];
    }
}

- (void)deallocF
{
    [imagesArray release];
    [curImages release];
    [titleLabel release];
    [selectImageView release];
    [selectBt release];
    [scrollView release];
    [super dealloc];
}

@end
