//
//  HFSegmentView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/17.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFSegmentView.h"

#define kSegmentBaseTag  1000

@interface HFSegmentView()
{
    NSInteger  mLastTag;
}
@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UIImageView * selectImageView;
@end


@implementation HFSegmentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self loadUI];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self loadUI];
    }
    return self;
}

- (void)setSegmentTitles:(NSArray *)titles
{
    //默认选中第一个
    UIImage * image = IMG(@"scheme_selected");
    CGSize rect = image.size;
    
    self.selectImageView.frame = CGRectMake(0, 0, rect.width, rect.height);
    self.selectImageView.image = image;
    
    mLastTag = kSegmentBaseTag;
    
    CGFloat width = self.frame.size.width / 2;
    
    for (int i = 0; i < [titles count]; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        btn.tag = kSegmentBaseTag + i;
        
        if (i == 0)
        {
            [btn setTitleColor:[UIColor mainStyleColor] forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)segmentClick:(UIButton *)btn
{
    if (btn.tag == mLastTag)
    {
        return;
    }
    
    NSInteger index = btn.tag - kSegmentBaseTag;
    
    
    WS(weakSelf)
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = weakSelf.selectImageView.frame;
        rect.origin.x = (btn.tag - kSegmentBaseTag) * weakSelf.selectImageView.frame.size.width;
        weakSelf.selectImageView.frame = rect;
        
        UIButton * lastBtn = (UIButton *)[weakSelf viewWithTag:mLastTag];
        [lastBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton * currentBtn = (UIButton *)[weakSelf viewWithTag:btn.tag];
        [currentBtn setTitleColor:[UIColor mainStyleColor] forState:UIControlStateNormal];
        
        mLastTag = btn.tag;
    }];
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectSegmentIndex:)])
    {
        [_delegate selectSegmentIndex:index];
    }
    
}


#pragma mark -
#pragma mark private

- (void)loadUI
{
    self.bgImageView.image = IMG(@"scheme_bg");
}


#pragma mark -
#pragma mark getter

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UIImageView *)selectImageView
{
    if (!_selectImageView)
    {
        _selectImageView = [[UIImageView alloc] init];
        [self addSubview:_selectImageView];
    }
    
    return _selectImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
