//
//  HFGoodIdeaCell.m
//  SDCycleScrollView
//
//  Created by 朱伟特 on 15/8/3.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HFGoodIdeaCell.h"
#import "NSString+HFStrUtil.h"
@interface HFGoodIdeaCell()

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * title;

@end

@implementation HFGoodIdeaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    return self;
}

#pragma mark -
#pragma mark SetterFunction
- (void)setSuggestData:(GetSuggestData *)suggestData
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getRawImage:suggestData.icon]] placeholderImage:IMG(@"default_habit")];
    self.title.text = [suggestData.name URLDecodedForString];
}

#pragma mark -
#pragma mark LazyLoading
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        WS(weakSelf)
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(26, 26));
            make.left.equalTo(@15);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
    }
    return _iconImageView;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [UILabel new];
        [self.contentView addSubview:_title];
        WS(weakSelf)
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.iconImageView.mas_right).with.offset(10);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
        }];
    }
    return _title;
}
@end
