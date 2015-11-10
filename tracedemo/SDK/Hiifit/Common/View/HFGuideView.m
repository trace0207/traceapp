//
//  HFGuideView.m
//  NavigationMenu
//
//  Created by 朱伟特 on 15/8/18.
//  Copyright (c) 2015年 Ivan Sapozhnik. All rights reserved.
//

#import "HFGuideView.h"
#import "Masonry.h"

@interface HFGuideView()

@property (nonatomic, strong) UIView * bgImageView;

@end


@implementation HFGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    self.bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 6);
    self.smallImageView.frame = CGRectMake(self.frame.size.width / 2 - 3, CGRectGetMaxY(_bgImageView.frame), 12, 6);
    self.textLabel.frame = _bgImageView.frame;
}
- (UIView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIView alloc] init];
        [self addSubview:_bgImageView];
        _bgImageView.backgroundColor = [UIColor blackColor];
        _bgImageView.alpha = 0.9;
        _bgImageView.layer.cornerRadius = 5;
        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}
- (UIImageView *)smallImageView
{
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmall.png"]];
        [self addSubview:_smallImageView];
    }
    return _smallImageView;
}
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
@end
