//
//  HFAdvanceSchemeCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFAdvanceSchemeCell.h"
#import "HFSchemeItem.h"
#import "UIButton+MixButton.h"
@interface HFAdvanceSchemeCell()<HFSchemeItemDelegate>
{
    AdvanceSchemeType mType;
    
    
    NSInteger   adSchemeID;
}
@property(nonatomic,strong)HFSchemeItem * itemOne;
@property(nonatomic,strong)HFSchemeItem * itemTwo;
@property(nonatomic,strong)HFSchemeItem * itemThree;
@property(nonatomic,strong)UIButton  * detailBtn;
@property(nonatomic,strong)MainPageAdvanceSchemeData * mData;
@end


@implementation HFAdvanceSchemeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)useAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(beginUseAction:)])
    {
        [_delegate beginUseAction:adSchemeID];
    }
}

- (IBAction)singleSchemeAction:(UIButton *)sender
{
    MainPageAdvanceSubSchemeData * info = [self.mData.subSchemeList objectAtIndex:0];
    
    if (_delegate && [_delegate respondsToSelector:@selector(mainSchemeClick:schemeName:)])
    {
        [_delegate mainSchemeClick:info.subSchemeId schemeName:info.subName];
    }
}

- (void)setContentData:(MainPageAdvanceSchemeData *)data
{
    
    self.mData = data;
    
    mType = [HFAdvanceSchemeCell cellTypeForData:data];
    
    adSchemeID = data.id;
    
    if (mType != AdvanceScheme_Begin)
    {
        [self.detailBtn setImage:IMG(@"new_arrow") forState:UIControlStateNormal withOffset:35 direction:button_horizontalType];
        [self.detailBtn setTitle:@"" forState:UIControlStateNormal withOffset:20 direction:button_horizontalType];
    }
   
    switch (mType) {
        case AdvanceScheme_None:
        {
            [self.none_HeadImageView sd_setImageWithURL:[NSURL URLWithString:data.iconAddr] placeholderImage:IMG(@"heabit")];
            self.none_TitleLabel.text = data.name;
            self.none_introduceLabel.text = [NSString stringWithFormat:@"适用人群: %@",data.crowd];
        }
            break;
        case AdvanceScheme_One:
        {
            [self.one_HeadImageView sd_setImageWithURL:[NSURL URLWithString:data.iconAddr] placeholderImage:IMG(@"heabit")];
            self.one_TitleLabel.text = data.name;
            self.one_introduceLabel.text = [NSString stringWithFormat:@"适用人群: %@",data.crowd];
            
            MainPageAdvanceSubSchemeData * info = [data.subSchemeList objectAtIndex:0];
            self.mSchemeOneLabel.text = info.subName;
            self.mShemeOneTime.text = [NSString stringWithFormat:@"%ld",info.days];
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:data.picAddr] placeholderImage:IMG(@"heabit")];
            self.bgImageView.layer.cornerRadius = 5.0;
        }
            break;
        case AdvanceScheme_Two:
        {
            [self removeItem];
            
            [self.more_HeadImageView sd_setImageWithURL:[NSURL URLWithString:data.iconAddr] placeholderImage:IMG(@"heabit")];
            self.more_TitleLabel.text = data.name;
            self.more_introduceLabel.text = [NSString stringWithFormat:@"适用人群: %@",data.crowd];
            
            for (int i = 0; i < [data.subSchemeList count]; i++)
            {
                MainPageAdvanceSubSchemeData * info = [data.subSchemeList objectAtIndex:i];
                NSInteger subSchemeID = info.subSchemeId;
                NSString * title = [NSString stringWithFormat:@"%ld",info.days];
                if (i == 0)
                {
                    [self.itemOne setContentTitle:title bgImage:info.iconAddr withName:info.subName withtypeID:subSchemeID];
                }
                else
                {
                    [self.itemTwo setContentTitle:title bgImage:info.iconAddr withName:info.subName withtypeID:subSchemeID];
                }
            }
            
            
        }
            break;
        case AdvanceScheme_Three:
        {
            [self removeItem];
            
            [self.more_HeadImageView sd_setImageWithURL:[NSURL URLWithString:data.iconAddr] placeholderImage:IMG(@"heabit")];
            self.more_TitleLabel.text = data.name;
            self.more_introduceLabel.text = [NSString stringWithFormat:@"适用人群: %@",data.crowd];
            for (int i = 0; i < [data.subSchemeList count]; i++)
            {
                MainPageAdvanceSubSchemeData * info = [data.subSchemeList objectAtIndex:i];
                NSInteger subSchemeID = info.subSchemeId;
                NSString * title = [NSString stringWithFormat:@"%ld",info.days];
                if (i == 0)
                {
                    [self.itemOne setContentTitle:title bgImage:info.iconAddr withName:info.subName withtypeID:subSchemeID];
                }
                else if (i == 1)
                {
                    [self.itemTwo setContentTitle:title bgImage:info.iconAddr withName:info.subName withtypeID:subSchemeID];
                }
                else
                {
                    [self.itemThree setContentTitle:title bgImage:info.iconAddr withName:info.subName withtypeID:subSchemeID];
                }
            }
        }
            break;
        case AdvanceScheme_Begin:
        {
            [self.begin_HeadImageView sd_setImageWithURL:[NSURL URLWithString:data.iconAddr] placeholderImage:IMG(@"heabit")];
            self.begin_TitleLabel.text = data.name;
            self.begin_introduceLabel.text = [NSString stringWithFormat:@"适用人群: %@",data.crowd];
            self.begin_SubscribeLabel.text = [NSString stringWithFormat:@"%ld人进行中",data.subscribeNum];
            [self.begin_SubscribeLabel sizeToFit];
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:data.picAddr] placeholderImage:IMG(@"heabit")];
            self.bgImageView.layer.cornerRadius = 5.0;
            if (data.isNew)
            {
                self.begin_newImageView.hidden = NO;
            }
            else
            {
                self.begin_newImageView.hidden = YES;
            }
            
        }
            break;
        default:
            break;
    }
    
}

+ (CGFloat)cellHeightForData:(MainPageAdvanceSchemeData *)data atIndex:(NSInteger)index
{
    
    if (data == nil)
    {
        return 0.0;
    }
    
    AdvanceSchemeType type = [HFAdvanceSchemeCell cellTypeForData:data];
    
    switch (type) {
        case AdvanceScheme_None:
            return 175.0;
            break;
        case AdvanceScheme_One:
            return 155.0;
            break;
        case AdvanceScheme_Two:
        case AdvanceScheme_Three:
            return 220.0;
            break;
        case AdvanceScheme_Begin:
            return 140.0;
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark private

- (void)removeItem
{
    //移除已经有的状态
    for (id obj in self.contentView.subviews)
    {
        if ([obj isKindOfClass:[HFSchemeItem class]])
        {
            HFSchemeItem * item = (HFSchemeItem *)obj;
            [item removeFromSuperview];
            if (item.tag == 1000)
            {
                _itemOne = nil;
            }
            else if (item.tag == 1001)
            {
                _itemTwo = nil;
            }
            else
            {
                _itemThree = nil;
            }
        }
    }
}

+ (AdvanceSchemeType)cellTypeForData:(MainPageAdvanceSchemeData *)data
{
    if (data.isSubscribe)
    {
        if ([data.subSchemeList count] == 1)
        {
            return  AdvanceScheme_One;
        }
        else if ([data.subSchemeList count] == 2)
        {
            return  AdvanceScheme_Two;
        }
        else if ([data.subSchemeList count] == 3)
        {
            return AdvanceScheme_Three;
        }
        else
        {
            return AdvanceScheme_None;
        }
        
    }
    else
    {
        return AdvanceScheme_Begin;
    }
}


- (void)detailClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(detailSchemeClick:)])
    {
        [_delegate detailSchemeClick:adSchemeID];
    }
}

#pragma mark -
#pragma mark getter

- (HFSchemeItem *)itemOne
{
    if (!_itemOne)
    {
        _itemOne = [[HFSchemeItem alloc] init];
        _itemOne.delegate = self;
        _itemOne.tag = 1000;
        [self.contentView addSubview:_itemOne];
        WS(weakSelf)
        [_itemOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(83, 113));
            make.bottom.equalTo(weakSelf).with.offset(-15);
            if (mType == AdvanceScheme_Two)
            {
                make.left.equalTo(weakSelf).with.offset(69);
            }
            else
            {
                make.left.equalTo(weakSelf).with.offset(30);
            }
        }];
    }
    return _itemOne;
}

- (HFSchemeItem *)itemTwo
{
    if (!_itemTwo)
    {
        _itemTwo = [[HFSchemeItem alloc] init];
        _itemTwo.delegate = self;
        _itemTwo.tag = 1001;
        [self.contentView addSubview:_itemTwo];
        WS(weakSelf)
        [_itemTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(83, 113));
            make.bottom.equalTo(weakSelf).with.offset(-15);
            if (mType == AdvanceScheme_Two)
            {
                make.right.equalTo(weakSelf).with.offset(-69);
            }
            else
            {
                make.centerX.equalTo(weakSelf.mas_centerX).with.offset(0);
            }
        }];
    }
    return _itemTwo;
}

- (HFSchemeItem *)itemThree
{
    if (!_itemThree)
    {
        _itemThree = [[HFSchemeItem alloc] init];
        _itemThree.delegate = self;
        _itemThree.tag = 1002;
        [self.contentView addSubview:_itemThree];
        WS(weakSelf)
        [_itemThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(83, 113));
            make.bottom.equalTo(weakSelf).with.offset(-15);
            make.right.equalTo(weakSelf).with.offset(-30);
        }];
    }
    return _itemThree;
}

- (UIButton *)detailBtn
{
    if (!_detailBtn)
    {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_detailBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
        [_detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_detailBtn];
        WS(weakSelf)
        [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).with.offset(25);
            make.right.equalTo(weakSelf).with.offset(-13);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
    }
    return _detailBtn;
}

#pragma mark -
#pragma mark HFSchemeItemDelegate

- (void)itemClick:(NSInteger)subSchemeId subSchemeName:(NSString *)schemeName
{
    if (_delegate && [_delegate respondsToSelector:@selector(mainSchemeClick:schemeName:)])
    {
        [_delegate mainSchemeClick:subSchemeId schemeName:schemeName];
    }
}

@end
