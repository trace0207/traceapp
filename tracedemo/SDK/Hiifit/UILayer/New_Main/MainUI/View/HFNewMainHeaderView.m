//
//  HFNewMainHeaderView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/10/21.
//  Copyright © 2015年 ChinaMobile. All rights reserved.
//

#import "HFNewMainHeaderView.h"

#define kNewMainHeaderTag  10000

@interface HFNewMainHeaderView()
{
    CGFloat width;
    CGFloat bounds;
    
    NSInteger  mButtonTag;
}
@property(nonatomic,strong)UIView * mBottomLine;
@property(nonatomic,strong)UIImageView * seperatorLine;
@end

@implementation HFNewMainHeaderView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createTitles:titles];
    }
    return self;
}

- (void)createTitles:(NSArray *)titles
{
    width = self.frame.size.width / [titles count];
    bounds = 0.0;
    
    for (int i = 0; i < [titles count]; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = kNewMainHeaderTag + i;
        [button setTitleColor:[UIColor HFColorStyle_3] forState:UIControlStateNormal];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        button.frame = CGRectMake(bounds + i * width, 0, width, self.frame.size.height);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    mButtonTag = kNewMainHeaderTag + 0;

    self.seperatorLine.image = IMG(@"new_changeSeperateLine");
    [self resetButtonState:mButtonTag anmiation:NO];
}

- (void)resetButtonState:(NSInteger)tag anmiation:(BOOL)animation
{
    UIButton * lastBtn = (UIButton *)[self viewWithTag:mButtonTag];
    [lastBtn setTitleColor:[UIColor HFColorStyle_3] forState:UIControlStateNormal];
    
    UIButton * button = (UIButton *)[self viewWithTag:tag];
    [button setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    CGRect rect = self.mBottomLine.frame;
    rect.origin.x = (tag - kNewMainHeaderTag) * width;
    if (animation)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.mBottomLine.frame = rect;
        }];
    }
    else
    {
        self.mBottomLine.frame = rect;
    }
    
    mButtonTag = tag;
    
}


- (void)buttonClick:(UIButton *)btn
{
    if (btn.tag == mButtonTag)
    {
        return;
    }
    
    [self resetButtonState:btn.tag anmiation:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClick:)])
    {
        [_delegate buttonClick:btn.tag - kNewMainHeaderTag];
    }
}

- (UIView *)mBottomLine
{
    if (!_mBottomLine)
    {
        _mBottomLine = [[UIView alloc] initWithFrame:CGRectMake(bounds, self.frame.size.height - 2, width, 2)];
        _mBottomLine.backgroundColor = [UIColor HFColorStyle_5];
        [self addSubview:_mBottomLine];
    }
    return _mBottomLine;
}

- (UIImageView *)seperatorLine
{
    if (!_seperatorLine)
    {
        _seperatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(width, 10, 0.5, self.frame.size.height - 20)];
        [self addSubview:_seperatorLine];
    }
    return _seperatorLine;
}


@end
