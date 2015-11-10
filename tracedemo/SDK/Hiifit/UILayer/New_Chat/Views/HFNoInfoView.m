//
//  HFNoInfoView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/6/11.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFNoInfoView.h"

@implementation HFNoInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image  Text:(NSString *)text
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor HFColorStyle_6];
        [self loadUIWithText:text Image:image];
    }
    return self;
}

- (void)loadUIWithText:(NSString *)text Image:(UIImage *)image
{
    CGFloat orignX = (self.frame.size.width - image.size.width) / 2;
    CGFloat orignY = (self.frame.size.height - image.size.height)/2 - 40;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(orignX, orignY, image.size.width, image.size.height)];
    imageView.image = image;
    [self addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.origin.y + imageView.frame.size.height - 20, self.frame.size.width - 20*2, 100)];
    label.numberOfLines = 10;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor HFColorStyle_4];
    label.text = text;
    [self addSubview:label];
}
@end
