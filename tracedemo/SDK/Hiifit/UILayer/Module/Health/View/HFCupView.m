//
//  HFCupView.m
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/17.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import "HFCupView.h"
#import "Masonry.h"

@implementation HFCupView

- (instancetype)initWithSchemeInfo:(FinishSchemeData *)data
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = kScreenBounds;
        
        
        UIView * bgView = [[UIView alloc] initWithFrame:kScreenBounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.5f;
        [self addSubview:bgView];
        
        WS(weakSelf);
        
        UIImageView * lightImage = [[UIImageView alloc] initWithImage:IMG(@"light")];
        [self addSubview:lightImage];
        [lightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.top.equalTo(weakSelf.mas_top);
            make.right.equalTo(weakSelf.mas_right);
            make.height.mas_equalTo(259.5 * kScreenScale);
        }];
        
        UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancleButton setBackgroundImage:IMG(@"cancle_x") forState:UIControlStateNormal];
        [self addSubview:cancleButton];
        [cancleButton addTarget:self action:@selector(cancleThisView) forControlEvents:UIControlEventTouchUpInside];
        [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(20);
            make.top.equalTo(weakSelf.mas_top).with.offset(40);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        if (data.status) {
            UILabel * getHiDou = [[UILabel alloc] init];
            getHiDou.textAlignment = NSTextAlignmentCenter;
            getHiDou.text = [NSString stringWithFormat:@"已获得%@个嗨豆！",@(data.score)];
            getHiDou.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
            getHiDou.textColor = [UIColor hexChangeFloat:@"ffed00"];
            [self addSubview:getHiDou];
            [getHiDou mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_top).with.offset(69);
                make.centerX.equalTo(weakSelf.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(180, 30));
            }];
        }
        
        UIImageView * cupImage = [[UIImageView alloc] init];
        cupImage.image = IMG(@"New_cup2");
        [self addSubview:cupImage];
        [cupImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).with.offset(99);
            make.width.mas_equalTo(211);
            make.height.mas_equalTo(196);
        }];
        
        UILabel * leftLabel = [[UILabel alloc] init];
        leftLabel.text = [NSString stringWithFormat:@"%@",@(data.continueDay)];
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_centerX).with.offset(- 22);
            make.top.equalTo(cupImage.mas_bottom).with.offset(25);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
        }];
        
        UILabel * rightLabel = [[UILabel alloc] init];
        rightLabel.text = [NSString stringWithFormat:@"%@",@(data.totalDay)];
        rightLabel.textColor = [UIColor whiteColor];
        rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_centerX).with.offset(22);
            make.top.equalTo(leftLabel.mas_top);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
        }];
        
        UILabel * leftUnderLabel = [[UILabel alloc] init];
        leftUnderLabel.textAlignment = NSTextAlignmentCenter;
        leftUnderLabel.text = @"连续完成天数";
        leftUnderLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        leftUnderLabel.textColor = [UIColor whiteColor];
        [self addSubview:leftUnderLabel];
        [leftUnderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftLabel.mas_bottom).with.offset(15);
            make.right.width.height.equalTo(leftLabel);
        }];
        
        UILabel * rightUnderLabel = [[UILabel alloc] init];
        rightUnderLabel.textColor = [UIColor whiteColor];
        rightUnderLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        rightUnderLabel.textAlignment = NSTextAlignmentCenter;
        rightUnderLabel.text = @"累计完成天数";
        [self addSubview:rightUnderLabel];
        [rightUnderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.width.equalTo(rightLabel);
            make.top.equalTo(leftUnderLabel);
        }];
        
        if (data.status) {
            UILabel * editThoughtLabel = [[UILabel alloc] init];
            editThoughtLabel.textAlignment = NSTextAlignmentCenter;
            editThoughtLabel.text = [NSString stringWithFormat:@"成功发表感想，再奖励%@个嗨豆哦~",@(data.score)];
            editThoughtLabel.textColor = [UIColor whiteColor];
            editThoughtLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
            [self addSubview:editThoughtLabel];
            [editThoughtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.mas_centerX);
                make.top.equalTo(leftLabel.mas_bottom).with.offset(35);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 25;
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor HFColorStyle_5];
        [button setTitle:@"发表感想" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-25);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}

- (void)doClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(thoughtsButtonClick:)]) {
        [self.delegate thoughtsButtonClick:self];
    }else {
        [self dismiss];
    }
}
- (void)cancleThisView
{
    [MobClick event:AdvanceScheme_FinishClose];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancle:)]) {
        [self.delegate cancle:self];
    }else {
        [self dismiss];
    }
}

- (void)show
{
    [[[UIKitTool getAppdelegate]window] addSubview:self];
}

- (void)dismiss
{
    WS(weakSelf)
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
