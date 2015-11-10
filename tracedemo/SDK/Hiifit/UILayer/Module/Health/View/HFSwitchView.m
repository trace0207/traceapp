//
//  HFSwitchView.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/16.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFSwitchView.h"

@interface HFSwitchView ()

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation HFSwitchView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles
{
    self = [self initWithFrame:frame];
    if (self) {
        if (titles == nil || titles.count == 0) {
            return self;
        }
        _titles = [NSArray arrayWithArray:titles];
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        bgView.backgroundColor = RGBA(243, 243, 243, 1);
        bgView.alpha = 0.9f;
        [self addSubview:bgView];
        
        _centerLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(frame)-80)/2.0f, 0, 80, CGRectGetHeight(frame))];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_centerLabel];
        
        if (titles.count>1) {
            _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(frame))];
            [_leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_leftBtn];
            
            UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, (CGRectGetHeight(_leftBtn.frame)-12)/2.0, 7, 12)];
            [leftImage setImage:[UIImage imageNamed:@"arrow_left"]];
            [_leftBtn addSubview:leftImage];
            
            UIColor *color = [UIColor hexChangeFloat:@"333333" withAlpha:1];
            UIFont *font = [UIFont systemFontOfSize:14];
            
            _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftImage.frame)+5, 0, CGRectGetWidth(_leftBtn.frame)-CGRectGetMaxX(leftImage.frame), CGRectGetHeight(frame))];
            _leftLabel.textColor = color;
            _leftLabel.font = font;
            _leftLabel.backgroundColor = [UIColor clearColor];
            _leftLabel.userInteractionEnabled = NO;
            [_leftBtn addSubview:_leftLabel];
            _leftBtn.hidden = YES;
            
            
            _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(frame)-100, 0, 100, CGRectGetHeight(frame))];
            [_rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_rightBtn];
            
            UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_rightBtn.frame) - 15 -12, (CGRectGetHeight(_rightBtn.frame)-12)/2.0, 7, 12)];
            [rightImage setImage:[UIImage imageNamed:@"arrow_right"]];
            [_rightBtn addSubview:rightImage];
            
            _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0-5, 0, CGRectGetWidth(_rightBtn.frame)-12-15, CGRectGetHeight(frame))];
            _rightLabel.textAlignment = NSTextAlignmentRight;
            _rightLabel.font = font;
            _rightLabel.textColor = color;
            _rightLabel.userInteractionEnabled = NO;
            _rightLabel.text = [titles objectAtIndex:1];
            _rightLabel.backgroundColor = [UIColor clearColor];
            [_rightBtn addSubview:_rightLabel];
            _rightBtn.backgroundColor = [UIColor clearColor];
        }
        
        [self setCurrentPage:0];
    }
    return self;
}

- (void)leftAction:(UIButton *)btn
{
    _currentPage -= 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchDidSelectAtIndex:)]) {
        [self.delegate switchDidSelectAtIndex:_currentPage];
    }
    [self setCurrentPage:_currentPage];
}

- (void)rightAction:(UIButton *)btn
{
    _currentPage += 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchDidSelectAtIndex:)]) {
        [self.delegate switchDidSelectAtIndex:_currentPage];
    }
    [self setCurrentPage:_currentPage];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (currentPage < 0) {
        _currentPage = 0;
    }else if (currentPage >= self.titles.count) {
        _currentPage = self.titles.count - 1;
    }else {
        _currentPage = currentPage;
    }
    _leftBtn.hidden = NO;
    _rightBtn.hidden = NO;
    if (currentPage == 0) {
        _leftBtn.hidden = YES;
    }else if (currentPage == self.titles.count - 1) {
        _rightBtn.hidden = YES;
    }
    
    if (_currentPage > 0) {
        _leftLabel.text = [_titles objectAtIndex:_currentPage-1];
    }
    
    if (_currentPage < self.titles.count - 1) {
        _rightLabel.text = [_titles objectAtIndex:_currentPage+1];
    }
    
    NSString *string = [NSString stringWithFormat:@"%li/%lu",(long)_currentPage+1,(unsigned long)_titles.count];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = [string rangeOfString:@"/"];
    NSRange range1 = NSMakeRange(0, range.location);
    NSRange range2 = NSMakeRange(range.location, string.length-range.location);
    NSDictionary *dic1 = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    NSDictionary *dic2 = @{NSForegroundColorAttributeName:[UIColor hexChangeFloat:@"333333" withAlpha:1],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [attributeStr addAttributes:dic1 range:range1];
    [attributeStr addAttributes:dic2 range:range2];
    _centerLabel.attributedText = attributeStr;
}

@end
