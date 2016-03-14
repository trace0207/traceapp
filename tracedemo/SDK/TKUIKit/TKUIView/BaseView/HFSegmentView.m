//
//  HFSegmentView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/17.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFSegmentView.h"
#import "UIColor+TK_Color.h"
#import "UIImage+Scale.h"
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
    
    
    CGFloat higlitImageWidth = self.frame.size.width/titles.count;
    
    
    self.selectImageView.frame = CGRectMake(self.currentIndex*higlitImageWidth, 0, higlitImageWidth, self.frame.size.height);
    
    
    mLastTag = kSegmentBaseTag+self.currentIndex;
    
    CGFloat width = self.frame.size.width / 2;
    
    for (int i = 0; i < [titles count]; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        btn.tag = kSegmentBaseTag + i;
        
        if (i == self.currentIndex)
        {
            [btn setTitleColor:[UIColor tkActiveTextColorForNav] forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitleColor:[UIColor tkTextColorForNav] forState:UIControlStateNormal];
        }
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = self.textFont;
        [btn addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (UIFont *)textFont
{
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:17];
    }
    return _textFont;
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
        [lastBtn setTitleColor:[UIColor tkTextColorForNav] forState:UIControlStateNormal];
        
        UIButton * currentBtn = (UIButton *)[weakSelf viewWithTag:btn.tag];
        [currentBtn setTitleColor:[UIColor tkActiveTextColorForNav] forState:UIControlStateNormal];
        
        mLastTag = btn.tag;
        self.currentIndex = mLastTag - kSegmentBaseTag;
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
    self.bgImageView.image = [UIImage scaleWithImage:@"scheme_bg"];
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
        UIImage * image = [UIImage scaleWithImage:@"scheme_selected"];
        self.selectImageView.image = image;
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
