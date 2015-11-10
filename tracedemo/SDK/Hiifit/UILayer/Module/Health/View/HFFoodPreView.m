//
//  HFFoodPreView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFoodPreView.h"
#import "HFTagView.h"
#import "GetUserDietaryByDayAck.h"
@interface HFFoodPreView()
{
    NSInteger mCalorieId;
}
@property(nonatomic,strong)UIImageView * mFoodImageView;
@property(nonatomic,strong)UILabel * mNameLabel;
@property(nonatomic,strong)HFTagView * mTagView;
@end

@implementation HFFoodPreView


- (id)init
{
    self = [super init];
    
    if (self)
    {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)setFoodViewData:(GetUserDietaryMealCookListByDayData *)data
{
    mCalorieId = data.calorieId;
    
    [self.mFoodImageView sd_setImageWithURL:[NSURL URLWithString:data.picAddr] placeholderImage:IMG(@"food_dowanload_bg")];
    self.mNameLabel.text = data.calorieName;
//    CGSize size = [data.calorieName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
//    [self.mNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(size.width, 20));
//    }];
    
    [self.mTagView setTagText:data.calorieTips];
}

#pragma mark -
#pragma mark private

- (void)tapClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(checkCalorieInfo:)])
    {
        [_delegate checkCalorieInfo:mCalorieId];
    }
}


#pragma mark -
#pragma mark getter
- (UIImageView *)mFoodImageView
{
    if (!_mFoodImageView)
    {
        _mFoodImageView = [[UIImageView alloc] init];
        _mFoodImageView.layer.cornerRadius = 5.0;
        _mFoodImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mFoodImageView.clipsToBounds = YES;
        [self addSubview:_mFoodImageView];
        WS(weakSelf)
        [_mFoodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(weakSelf).with.offset(0);
            make.bottom.equalTo(weakSelf).with.offset(-40);
            make.right.equalTo(weakSelf).with.offset(-5);
        }];
    }
    return _mFoodImageView;
}

- (UILabel *)mNameLabel
{
    if (!_mNameLabel)
    {
        _mNameLabel = [[UILabel alloc] init];
        _mNameLabel.textAlignment = NSTextAlignmentCenter;
        _mNameLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_mNameLabel];
        WS(weakSelf)
        [_mNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mTagView.mas_top).with.offset(-0);
            make.left.right.equalTo(weakSelf).with.offset(0);
            make.top.equalTo(weakSelf.mFoodImageView.mas_bottom).with.offset(5);
        }];
        
    }
    return _mNameLabel;
}


- (HFTagView *)mTagView
{
    if (!_mTagView)
    {
        _mTagView = [[HFTagView alloc] init];
        _mTagView.backgroundColor =[UIColor colorWithRed:247/255.0f green:178/255.0f blue:82/255.0f alpha:1.0];
        [self addSubview:_mTagView];
        WS(weakSelf)
        [_mTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mNameLabel.mas_centerX);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
    }
    
    return _mTagView;
}

@end
