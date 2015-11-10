//
//  HFFoodListCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFFoodListCell.h"
#import "HFMixView.h"
#import "UIButton+MixButton.h"
#import "HFFoodPreScrollView.h"
#import "GetUserDietaryByDayAck.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "HFGuideView.h"
#import "HFInsightLargeImageView.h"
#define kFirstLunchDietView @"firstLunchDietView"
#define kFirstLunchThisView @"firstLunchThisView"
@interface HFFoodListCell()<HFFoodPreScrollViewDelegate>
{
    foodCellState mState;

}
@property(nonatomic,strong)UIImageView * mHeadImageView;
@property(nonatomic,strong)UILabel * mTitleLabel;
@property(nonatomic,strong)UILabel * mTimeLabel;
@property(nonatomic,strong)HFFoodPreScrollView * mFoodScrollView;
@property(nonatomic,strong)HFInsightLargeImageView * mFoodView;
@property(nonatomic,strong)UIButton * eatFinishBtn;
@property(nonatomic,strong)UIButton * eatOtherBtn;
@property(nonatomic,strong)HFMixView * mForgetView;
@property(nonatomic,strong)HFMixView * mFinishView;
@property(nonatomic,copy) NSString * imageURL;
@property(nonatomic,strong)HFGuideView * mFinishGuideView;
@property(nonatomic,strong)HFGuideView * mEatOtherGuideView;
@end

@implementation HFFoodListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        mState = unKnowState;
    }
    return self;
}


#pragma mark -
#pragma mark private
- (void)eatFinishAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(cellPhotoAction:atCell:)])
    {
        [_delegate cellPhotoAction:eat_Finish_State atCell:self];
    }
}

- (void)eatOtherAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(cellPhotoAction:atCell:)])
    {
        [_delegate cellPhotoAction:eat_Other_State atCell:self];
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

//重置set状态
- (void)resetDefult
{
    self.mTimeLabel.hidden = YES;
    self.mTitleLabel.hidden = YES;
    self.mFoodScrollView.hidden = YES;
    self.mFoodView.hidden = YES;
    self.eatFinishBtn.hidden = YES;
    self.eatOtherBtn.hidden = YES;
    self.mForgetView.hidden = YES;
    self.mFinishView.hidden = YES;
}

//- (void)checkLargeImage
//{
//    NSMutableArray * photoSources = [[NSMutableArray alloc] init];
//    
//    MJPhoto *photo = [[MJPhoto alloc] init];
//    if (self.mFoodView.image) {
//        photo.srcImageView = self.mFoodView;
//    }
//    
//    photo.url = [NSURL URLWithString:[UIKitTool getRawImage:self.imageURL]];
//    [photoSources addObject:photo];
//    
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = 0;
//    browser.photos = photoSources;
//    [browser show];
//}

#pragma mark -
#pragma mark public
- (void)setcontentData:(GetUserDietaryMealByDayData *)data withFoodstate:(foodCellState)state atTodoy:(BOOL)bToday
{
//    [self resetDefult];
    if (!data)
    {
        return;
    }

    self.imageURL = data.picAddr;
    
    if (mState != state && mState != unKnowState)
    {
        if (mState == PreviewState)
        {
            [self.mFoodScrollView removeFromSuperview];
            self.mFoodScrollView = nil;
            [self.eatFinishBtn removeFromSuperview];
            self.eatFinishBtn = nil;
            [self.eatOtherBtn removeFromSuperview];
            self.eatOtherBtn = nil;
        }
        else if (mState == FinishState)
        {
            [self.mFoodView removeFromSuperview];
            self.mFoodView = nil;
            [self.mFinishView removeFromSuperview];
            self.mFinishView = nil;
            
        }
        else if (mState == UnFinishState)
        {
            [self.mForgetView removeFromSuperview];
            self.mForgetView = nil;
        }
        else
        {
            [self.mFoodScrollView removeFromSuperview];
            self.mFoodScrollView = nil;
        }
    }
    
    [self.mHeadImageView setImage:IMG(@"wan_highlight")];
    
    if (data.mealType == 4 || !bToday)
    {
        self.mTitleLabel.text = [self retNameForMealType:data.mealType];
        [self.mTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(20);
            make.width.mas_equalTo(50);
        }];
        self.mTimeLabel.hidden = YES;
    }
    else
    {
        [self.mTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(17);
            make.width.mas_equalTo(50);
        }];
        self.mTimeLabel.hidden = NO;
        self.mTitleLabel.text = [self retNameForMealType:data.mealType];
        self.mTimeLabel.text = [NSString stringWithFormat:@"%@~%@",data.startTime,data.endTime];
    }
 
    
    
    if (state == PreviewState)
    {
        [self.mFoodScrollView setContentData:data.cookBookList];
        
        [self.eatOtherBtn setTitle:@"吃了别的" forState:UIControlStateNormal withOffset:-30 direction:button_horizontalType];
        [self.eatFinishBtn setTitle:@"完成了" forState:UIControlStateNormal withOffset:-30 direction:button_horizontalType];
    }
    else if (state == FinishState)
    {
        
        [self.mFoodView dd_setImageURL:[NSURL URLWithString:[UIKitTool getRawImage:data.picAddr]] withPlaceholder:IMG(@"food_dowanload_bg")];
        
        if ([data.content isEqualToString:@"吃了别的"])
        {
            [self.mFinishView setContextText:@"呵呵，我吃了别的" withImage:IMG(@"die_finish")];
        }
        else
        {
            [self.mFinishView setContextText:@"坚持就是胜利" withImage:IMG(@"die_finish")];
        }
        
    }
    else if (state == UnFinishState)
    {
        
        [self.mForgetView setContextText:@"忘记打卡了,下次注意哦" withImage:IMG(@"food_forget")];
    }
    else
    {
        [self.mFoodScrollView setContentData:data.cookBookList];
    }
    
    
    mState = state;
}

#pragma mark -
#pragma mark HFFoodPreScrollViewDelegate
- (void)pushToCalorieInfoView:(NSInteger)calID
{
    if (_delegate && [_delegate respondsToSelector:@selector(pushCalorieDetailViewAction:)])
    {
        [_delegate pushCalorieDetailViewAction:calID];
    }
}


#pragma mark -
#pragma mark getter

- (UIImageView *)mHeadImageView
{
    if (!_mHeadImageView)
    {
        WS(weakSelf)
        _mHeadImageView = [[UIImageView alloc] init];
        _mHeadImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_mHeadImageView];
        [_mHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(weakSelf.contentView).with.offset(15);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
    }
    return _mHeadImageView;
}

- (UILabel *)mTimeLabel
{
    if (!_mTimeLabel)
    {
        _mTimeLabel = [[UILabel alloc] init];
        _mTimeLabel.font = [UIFont systemFontOfSize:14.0];
        _mTimeLabel.textColor = [UIColor HFColorStyle_2];
        [self.contentView addSubview:_mTimeLabel];
        [_mTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mHeadImageView.mas_right).with.offset(10);
            make.top.equalTo(self.mTitleLabel.mas_bottom).with.offset(2);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
        }];
        
    }
    return _mTimeLabel;
}


- (UILabel *)mTitleLabel
{
    if (!_mTitleLabel)
    {
        _mTitleLabel = [[UILabel alloc] init];
        _mTitleLabel.font = [UIFont systemFontOfSize:16.0];
        _mTimeLabel.textColor = [UIColor HFColorStyle_1];
        [self.contentView addSubview:_mTitleLabel];
        WS(weakSelf)
        [_mTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mHeadImageView.mas_right).with.offset(10);
            make.top.equalTo(weakSelf.contentView).with.offset(17);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
        }];
        
        
    }
    return _mTitleLabel;
}

- (UIScrollView *)mFoodScrollView
{
    if (!_mFoodScrollView)
    {
        _mFoodScrollView = [[HFFoodPreScrollView alloc] init];
        _mFoodScrollView.mDelegate = self;
        _mFoodScrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_mFoodScrollView];
        [_mFoodScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(15);
            make.top.equalTo(self.mHeadImageView.mas_bottom).with.offset(10);
            make.right.equalTo(self.contentView).with.offset(-10);
            make.height.mas_equalTo(150);
        }];
    }
    return _mFoodScrollView;
}

- (UIImageView *)mFoodView
{
    if (!_mFoodView)
    {
        WS(weakSelf)
        _mFoodView = [[HFInsightLargeImageView alloc] init];
        _mFoodView.clipsToBounds = YES;
        _mFoodView.userInteractionEnabled = YES;
        _mFoodView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_mFoodView];
        
        [_mFoodView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).with.offset(15);
            make.top.equalTo(weakSelf.mHeadImageView.mas_right).with.offset(15);
            make.width.mas_equalTo(165);
            make.height.mas_equalTo(135);
        }];
    }
    return _mFoodView;
}

- (UIButton *)eatFinishBtn
{
    if (!_eatFinishBtn)
    {
        _eatFinishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eatFinishBtn addTarget:self action:@selector(eatFinishAction) forControlEvents:UIControlEventTouchUpInside];
        [_eatFinishBtn setBackgroundImage:IMG(@"eat_finish") forState:UIControlStateNormal];
        _eatFinishBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [self.contentView addSubview:_eatFinishBtn];
        WS(weakSelf)
        [_eatFinishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(15);
            make.bottom.equalTo(weakSelf).with.offset(-15);
            make.right.equalTo(weakSelf.eatOtherBtn.mas_left).with.offset(-15);
            make.width.mas_equalTo(weakSelf.eatOtherBtn);
            make.height.mas_equalTo(40);
        }];
    }
    
    return _eatFinishBtn;
}

- (UIButton *)eatOtherBtn
{
    
    if (!_eatOtherBtn)
    {
        _eatOtherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eatOtherBtn setBackgroundImage:IMG(@"eat_other") forState:UIControlStateNormal];
        _eatOtherBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_eatOtherBtn addTarget:self action:@selector(eatOtherAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_eatOtherBtn];
        
        WS(weakSelf)
        [_eatOtherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).with.offset(-15);
            make.bottom.equalTo(weakSelf).with.offset(-15);
            make.left.equalTo(weakSelf.eatFinishBtn.mas_right).with.offset(15);
            make.width.mas_equalTo(weakSelf.eatFinishBtn);
            make.height.mas_equalTo(40);
        }];
        
    }
    return _eatOtherBtn;
}

- (HFMixView *)mFinishView
{
    if (!_mFinishView)
    {
        _mFinishView = [[HFMixView alloc] init];
        _mFinishView.mType = horizontalType;
        [self.contentView addSubview:_mFinishView];
        WS(weakSelf)
        [_mFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(15);
            make.top.equalTo(weakSelf.mFoodView.mas_bottom).with.offset(15);
            make.bottom.right.equalTo(weakSelf).with.offset(-15);
        }];
        
        
    }
    return _mFinishView;
}

- (HFMixView *)mForgetView
{
    if (!_mForgetView)
    {
        _mForgetView = [[HFMixView alloc] init];
        _mForgetView.mType = verticalType;
        [self.contentView addSubview:_mForgetView];
        WS(weakSelf)
        [_mForgetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(15);
            make.top.equalTo(weakSelf.mas_top).with.offset(50);
            make.right.equalTo(weakSelf).with.offset(-15);
            make.bottom.equalTo(weakSelf).with.offset(0);
        }];
    }
    return _mForgetView;
}
- (HFGuideView *)mEatOtherGuideView
{
    if (!_mEatOtherGuideView) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:kFirstLunchDietView]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLunchDietView];
            _mEatOtherGuideView = [[HFGuideView alloc] init];
            _mEatOtherGuideView.textLabel.text = @"吃了推荐食谱\n点这里拍照打卡";
            WS(weakSelf);
            [_mEatOtherGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).with.offset(-33);
                make.bottom.equalTo(weakSelf.eatOtherBtn).with.offset(0);
                make.right.equalTo(weakSelf.eatFinishBtn.mas_left).with.offset(7);
                make.width.mas_equalTo(weakSelf.eatFinishBtn);
                make.height.mas_equalTo(70);
            }];
        }
    }
    return _mEatOtherGuideView;
}
- (HFGuideView *)mFinishGuideView
{
    if (!_mFinishGuideView) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:kFirstLunchThisView]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLunchThisView   ];
            _mFinishGuideView = [[HFGuideView alloc] init];
            _mFinishGuideView.textLabel.text = @"吃了推荐食谱\n点这里拍照打卡";
            WS(weakSelf);
            [_mEatOtherGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).with.offset(33);
                make.bottom.equalTo(weakSelf.eatFinishBtn).with.offset(0);
                make.right.equalTo(weakSelf.eatOtherBtn.mas_left).with.offset(-7);
                make.width.mas_equalTo(weakSelf.eatOtherBtn);
                make.height.mas_equalTo(70);
            }];
        }
    }
    return _mFinishGuideView;
}
@end
