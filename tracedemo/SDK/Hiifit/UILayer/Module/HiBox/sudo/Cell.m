//
//  Cell.m
//  ShuDu
//
//  Created by hermit on 15/3/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (instancetype)initWithX:(NSInteger)x andY:(NSInteger)y
{
    self = [super init];
    if (self) {
        
        self.blank = YES;
        self.value = 0;

        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, kCellWidth, kCellWidth);
        
        self.cellBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kCellWidth, kCellWidth)];
        self.cellBtn.tag = x*kGridNum+y;
        self.cellBtn.backgroundColor = [UIColor clearColor];
        [self.cellBtn setBackgroundImage:[UIImage imageNamed:@"num_blank"] forState:UIControlStateNormal];
        [self.cellBtn setBackgroundImage:[UIImage imageNamed:@"number"] forState:UIControlStateSelected];
        [self.cellBtn.titleLabel setFont:[UIFont fontWithName:@"Futura-Mediumltalic" size:18]];
        [self.cellBtn setTitle:@"" forState:UIControlStateNormal];
        [self.cellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.cellBtn];
        
        self.discreetLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kCellWidth, kCellWidth)];
        self.discreetLabel.tag = x*kGridNum+y;
        self.discreetLabel.backgroundColor = [UIColor clearColor];
        //self.discreetLabel.font = [UIFont fontWithName:@"Futura-Mediumltalic" size:18];
        self.discreetLabel.textColor = [UIColor colorWithRed:25.0f/255.0 green:166.0f/255.0 blue:248.0f/255.0 alpha:1];
        self.discreetLabel.numberOfLines = 0;
        self.discreetLabel.textAlignment = NSTextAlignmentCenter;
        self.discreetLabel.userInteractionEnabled = NO;
        [self addSubview:self.discreetLabel];
        
        self.higlitedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kHighlitedWidth, kHighlitedWidth)];
        [self.higlitedImageView setImage:[UIImage imageNamed:@"green_highlighted"]];
        self.higlitedImageView.tag = x*kGridNum+y;
        self.higlitedImageView.hidden = YES;
        self.higlitedImageView.userInteractionEnabled = NO;
        self.higlitedImageView.center = self.cellBtn.center;
        [self addSubview:self.higlitedImageView];
        
        CGPoint center = CGPointMake(y*(kCellWidth) + (y/3+1)*kCellSpace + kCellWidth/2, x*(kCellWidth) + kCellWidth/2 + (x/3+1)*kCellSpace);
        self.center = center;
    }
    return self;
}


- (void)setValue:(NSInteger)value isBlank:(BOOL)blank
{
    self.blank = blank;
    self.value = value;
    [self.cellBtn setTitle:[NSString stringWithFormat:@"%@",@(value)] forState:UIControlStateSelected];
    self.cellBtn.selected = !blank;
}

- (void)setValueMarkLabel:(NSString *)value
{
    if (value.length <= 1) {
        [self.discreetLabel setFont:[UIFont systemFontOfSize:18]];
    }else if (value.length <= 2) {
        [self.discreetLabel setFont:[UIFont systemFontOfSize:14]];
    }else if (value.length <= 7) {
        [self.discreetLabel setFont:[UIFont systemFontOfSize:12]];
    }else {
        [self.discreetLabel setFont:[UIFont systemFontOfSize:8]];
    }
    self.discreetLabel.text = value;
}

- (void)showTheNumber
{
    self.blank = NO;
    self.discreetLabel.text = @"";
    self.cellBtn.selected = YES;
}

@end
