//
//  HFGiveUpView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFGiveUpView.h"

@implementation HFGiveUpView

- (id)init
{
    if ([super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor hexChangeFloat:@"000000" withAlpha:0.5];
        [self loadUI];
    }
    return self;
}
#pragma mark -
#pragma mark PrivateFunction
- (void)loadUI
{
    WS(weakSelf);

    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor HFColorStyle_6];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 50, (kScreenWidth - 60) * 1.09));
    }];
    
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor HFColorStyle_5];
    [bgView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).with.offset(0);
        make.left.equalTo(bgView.mas_left).with.offset(0);
        make.right.equalTo(bgView.mas_right).with.offset(0);
        make.height.mas_equalTo(64 * kScreenScale);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"确定要放弃调理计划?";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).with.offset(15);
        make.centerX.equalTo(topView.mas_centerX).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(180);
    }];

    
    UIView * emojiView = [[UIView alloc] init];
    emojiView.backgroundColor = [UIColor whiteColor];
    emojiView.layer.cornerRadius = 85 * kScreenScale / 2;
    [bgView addSubview:emojiView];
    [emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).with.offset(20 * kScreenScale);
        make.centerX.equalTo(bgView.mas_centerX).with.offset(0);
        make.height.mas_equalTo(85 * kScreenScale);
        make.width.mas_equalTo(85 * kScreenScale);
    }];
    
    UIImageView * emojiImageView = [[UIImageView alloc] init];
    emojiImageView.image = [UIImage imageNamed:@"healthCry.png"];
    [bgView addSubview:emojiImageView];
    [emojiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(emojiView);
        make.height.mas_equalTo(50 * kScreenScale);
        make.width.mas_equalTo(50 * kScreenScale);
    }];
    
    self.encourageLabel = [[UILabel alloc] init];
    self.encourageLabel.numberOfLines = 0;
    self.encourageLabel.textColor = [UIColor darkGrayColor];
    self.encourageLabel.text = @"一旦放弃，之前努力的数据都\n将消失！";
    self.encourageLabel.textAlignment = NSTextAlignmentCenter;
    self.encourageLabel.font = [UIFont systemFontOfSize:14.0];
    [bgView addSubview:self.encourageLabel];
    [_encourageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emojiView.mas_bottom).with.offset(15 * kScreenScale);
        make.left.equalTo(bgView.mas_left).with.offset(30);
        make.right.equalTo(bgView.mas_right).with.offset(-30);
        make.height.mas_equalTo(35);
    }];

    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).with.offset(-55 * kScreenScale);
        make.left.equalTo(bgView.mas_left);
        make.width.mas_equalTo(bgView);
        make.height.mas_equalTo(1);
    }];

    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setBackgroundImage:[UIImage imageNamed:@"cancleButton1.png"] forState:UIControlStateNormal];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
     [cancleButton addTarget:self action:@selector(cancleDoClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancleButton];
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.equalTo(lineView.mas_bottom).with.offset(10 * kScreenScale);
        make.right.equalTo(bgView.mas_centerX).with.offset(-13);
        make.height.mas_equalTo(35 * kScreenScale);
    }];
    cancleButton.layer.cornerRadius = 35 * kScreenScale / 2;
    
    UIButton * giveUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [giveUpButton setBackgroundImage:[UIImage imageNamed:@"giveUpPlan.png"] forState:UIControlStateNormal];
    [giveUpButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [giveUpButton setTitle:@"放弃计划" forState:UIControlStateNormal];
    giveUpButton.layer.cornerRadius = 35 * kScreenScale / 2;
    [giveUpButton addTarget:self action:@selector(giveUpDoClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:giveUpButton];
    [giveUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_centerX).with.offset(13);
        make.top.equalTo(cancleButton);
        make.right.equalTo(bgView.mas_right).with.offset(-13);
        make.height.mas_equalTo(35 * kScreenScale);
    }];

}
- (void)cancleDoClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleButtonClick)]) {
        [self.delegate cancleButtonClick];
    }
}
- (void)giveUpDoClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(giveUpButtonClick)]) {
        [self.delegate giveUpButtonClick];
    }
}

- (void)show
{
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
