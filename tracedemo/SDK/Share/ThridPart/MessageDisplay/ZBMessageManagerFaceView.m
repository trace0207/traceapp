//
//  MessageFaceView.m
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-12.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import "ZBMessageManagerFaceView.h"
#import "GrayPageControl.h"
#import "ZBMessageInputView.h"

#define FaceSectionBarHeight  36   // 表情下面控件
#define FacePageControlHeight 30  // 表情pagecontrol

#define Pages 5


@interface ZBMessageManagerFaceView()

@property (nonatomic, strong) GrayPageControl * pageControl;

@end
@implementation ZBMessageManagerFaceView

- (id)initWithFrame:(CGRect)frame textView:(ZBMessageTextView *)textView
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setup{
    
    self.backgroundColor = [UIColor colorWithRed:248.0f/255 green:248.0f/255 blue:255.0f/255 alpha:1.0];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f,0.0f,kScreenWidth,196-FacePageControlHeight-FaceSectionBarHeight)];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame)*Pages,CGRectGetHeight(scrollView.frame))];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emojiBackgroundClick)];
    [scrollView addGestureRecognizer:tapGesture];
    
    for (int i= 0;i<Pages;i++) {
        ZBFaceView *faceView = [[ZBFaceView alloc]initWithFrame:CGRectMake(i*kScreenWidth,0.0f,kScreenWidth,CGRectGetHeight(scrollView.bounds)) forIndexPath:i];
        [scrollView addSubview:faceView];
        faceView.delegate = self;
    }
    CGRect pageControlFrame = CGRectMake(0, CGRectGetMaxY(scrollView.frame), 0, 30);
    self.pageControl.frame = pageControlFrame;
    [self addSubview:self.pageControl];
    
//    ZBExpressionSectionBar *sectionBar = [[ZBExpressionSectionBar alloc]initWithFrame:CGRectMake(0.0f,CGRectGetMaxY(pageControl.frame),CGRectGetWidth(self.bounds), FaceSectionBarHeight)];
//    [self addSubview:sectionBar];
}
#pragma mark
#pragma mark lazyLoading
- (GrayPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[GrayPageControl alloc] init];
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        _pageControl.numberOfPages = Pages;
        _pageControl.currentPage   = 0;
    }
    return _pageControl;
}
#pragma mark  scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/320;
    self.pageControl.currentPage = page;
    
}

#pragma mark ZBFaceView Delegate
- (void)didSelecteFace:(NSString *)faceName andIsSelecteDelete:(BOOL)del{
    if ([self.delegate respondsToSelector:@selector(SendTheFaceStr:isDelete:)] && !del) {
        [self.delegate SendTheFaceStr:faceName isDelete:del];
    }else{
        [self.delegate deleteTheFaceStr];
    }
}
#pragma mark - privateFunction
- (void)emojiBackgroundClick
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
