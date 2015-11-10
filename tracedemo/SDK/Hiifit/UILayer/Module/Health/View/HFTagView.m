//
//  HFTagView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/6.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFTagView.h"

@interface HFTagView()
{
    
}
@property(nonatomic,strong)UILabel * mLabel;
@end

@implementation HFTagView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.layer.cornerRadius = 2;
        
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setTagText:(NSString *)text
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(size.width, size.height));
    }];
    self.mLabel.text = text;
}


- (UILabel *)mLabel
{
    if (!_mLabel)
    {
        _mLabel = [[UILabel alloc] init];
        _mLabel.font = [UIFont systemFontOfSize:10.0];
        _mLabel.textColor = [UIColor whiteColor];
        _mLabel.textAlignment = NSTextAlignmentCenter;
        _mLabel.layer.cornerRadius = 3.0;
        [self addSubview:_mLabel];
        WS(weakSelf)
        [_mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _mLabel;
}

@end
