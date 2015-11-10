//
//  HFFoodCardView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFoodCardView.h"
#import "GetFoodsByDayAck.h"

@interface HFFoodCardView()
{
    NSInteger mMealType;
}
@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UIImageView * mHeadImageView;
@property(nonatomic,strong)UILabel * mTitleLabel;
@property(nonatomic,strong)UILabel * mTimeLabel;
@property(nonatomic,strong)UIView * mLineView;
@property(nonatomic,strong)UILabel * mEatLabel;
@property(nonatomic,strong)UIButton * mAddButton;

@end

@implementation HFFoodCardView

#pragma mark -
#pragma mark public

- (void)awakeFromNib
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)setContentData:(GetFoodsByMealData *)data atHistory:(BOOL)histroy
{
    
    [self.mHeadImageView sd_setImageWithURL:[NSURL URLWithString:data.icon] placeholderImage:nil];
    self.mTitleLabel.text = [self retNameForMealType:data.mealType];
    self.mTimeLabel.text = [NSString stringWithFormat:@"%@~%@",data.startTime,data.endTime];
    
    mMealType = data.mealType;
   //
    
    if (data.isOK)
    {
        self.bgImageView.image = IMG(@"foodcard_Bg");
        self.mAddButton.hidden = YES;
        self.mEatLabel.hidden = NO;
        self.mEatLabel.text = data.content;
    }
    else
    {
        self.bgImageView.image = IMG(@"foodcard_dark");
        if (histroy)
        {
            self.mAddButton.hidden = YES;
            self.mEatLabel.hidden = NO;
            self.mEatLabel.text = @"空";
        }
        else
        {
            self.mEatLabel.hidden = YES;
            self.mAddButton.hidden = NO;
        }
        
    }
    [self sendSubviewToBack:self.bgImageView];
}

- (void)addFoodDetailAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(pushMealsDetail:)])
    {
        [_delegate pushMealsDetail:mMealType];
    }
}

#pragma mark -
#pragma private

- (void)tapAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(pushMealsDetail:)])
    {
        [_delegate pushMealsDetail:mMealType];
    }
}

- (NSString *)retNameForMealType:(NSInteger)type
{
    if (type == 1)
    {
        return @"早餐";
    }
    else if (type == 2)
    {
        return @"午餐";
    }
    else if (type == 3)
    {
        return @"晚餐";
    }
    else
    {
        return @"热饮";
    }
}


#pragma mark -
#pragma mark getter

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] init];
        [self addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _bgImageView;
}

- (UIImageView *)mHeadImageView
{
    if (!_mHeadImageView)
    {
        WS(weakSelf)
        _mHeadImageView = [[UIImageView alloc] init];
        [self addSubview:_mHeadImageView];
        [_mHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(10);
            make.top.equalTo(weakSelf.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
    }
    return _mHeadImageView;
}


- (UILabel *)mTimeLabel
{
    if (!_mTimeLabel)
    {
        WS(weakSelf)
        _mTimeLabel = [[UILabel alloc] init];
        _mTimeLabel.textColor = [UIColor hexChangeFloat:@"999999" withAlpha:1.0];
         [self addSubview:_mTimeLabel];
        [_mTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mHeadImageView.mas_right).with.offset(10);
            make.top.equalTo(weakSelf.mTitleLabel.mas_bottom).with.offset(2);
            make.size.mas_equalTo(CGSizeMake(100, 16));
        }];
       _mTimeLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _mTimeLabel;
}

- (UILabel *)mTitleLabel
{
    if (!_mTitleLabel)
    {
        _mTitleLabel = [[UILabel alloc] init];
        _mTitleLabel.textColor = [UIColor hexChangeFloat:@"333333" withAlpha:1.0];
        [self addSubview:_mTitleLabel];
        WS(weakSelf)
        [_mTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(8);
            make.left.equalTo(weakSelf.mHeadImageView.mas_right).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(100, 16));
        }];
        _mTitleLabel.font = [UIFont systemFontOfSize:14.0];
        
    }
    return _mTitleLabel;
}

- (UIView *)mLineView
{
    if (!_mLineView)
    {
        _mLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 1)];
        _mLineView.backgroundColor = [UIColor HFColorStyle_6];
        [self addSubview:_mLineView];
    }
    return _mLineView;
}

- (UILabel *)mEatLabel
{
    if (!_mEatLabel)
    {
        WS(weakSelf)
        _mEatLabel = [[UILabel alloc] init];
        _mEatLabel.textColor = [UIColor hexChangeFloat:@"333333" withAlpha:1.0];
        [self addSubview:_mEatLabel];
        [_mEatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(5);
            make.right.equalTo(weakSelf.mas_right).with.offset(-5);
            make.top.equalTo(weakSelf.mLineView.mas_bottom).with.offset(10);
            make.height.mas_equalTo(20);
        }];
        _mEatLabel.textAlignment = NSTextAlignmentCenter;
        _mEatLabel.font = [UIFont systemFontOfSize:14.0];
       // _mEatLabel.numberOfLines = 2;
    }
    return _mEatLabel;
}

- (UIButton *)mAddButton
{
    if (!_mAddButton)
    {
        _mAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mAddButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_mAddButton setBackgroundImage:IMG(@"foodcard_Add") forState:UIControlStateNormal];
        [_mAddButton addTarget:self action:@selector(addFoodDetailAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mAddButton];
        
        WS(weakSelf)
        [_mAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mLineView.mas_bottom).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(59, 22));
            
        }];
    }
    
    return _mAddButton;
}

@end
