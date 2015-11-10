//
//  HFMixView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMixView.h"


@interface HFMixView()
{
    
    
    CGFloat   imageWidth;
    
    CGFloat   imageHeight;
    
    CGSize   textSize;
}
@property(nonatomic,strong)UILabel * mTextLabel;
@property(nonatomic,strong)UIImageView * mImageView;
@end

@implementation HFMixView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithFrame:(CGRect)frame withType:(mixType)type
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        mType = type;
//        //[self initUI];
//    }
//    return self;
//}

#pragma mark -
#pragma mark public
- (void)setContextText:(NSString *)text withImage:(UIImage *)image
{
    imageWidth = image.size.width;
    imageHeight = image.size.height;
    
    textSize = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
    
    self.mTextLabel.text = text;
    self.mImageView.image = image;
}


#pragma mark -
#pragma mark getter

- (UILabel *)mTextLabel
{
    if (!_mTextLabel)
    {
        _mTextLabel =[[UILabel alloc] init];
        _mTextLabel.numberOfLines = 0;
        _mTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _mTextLabel.textAlignment = NSTextAlignmentCenter;
        _mTextLabel.textColor = [UIColor HFColorStyle_2];
        [self addSubview:_mTextLabel];
        WS(weakSelf)
        if (_mType == horizontalType)
        {
            
            [_mTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {

                make.top.bottom.equalTo(weakSelf).with.offset(0);
                make.centerX.equalTo(weakSelf.mas_centerX).with.offset(imageWidth - 10);
                make.width.mas_equalTo(textSize.width);
            }];
        }
        else
        {
            [_mTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(weakSelf.mImageView.mas_bottom).with.offset(10);
                make.centerX.equalTo(weakSelf.mas_centerX).with.offset(0);
                make.size.mas_equalTo(CGSizeMake(textSize.width, textSize.height));
            }];
            
           // _mTextLabel.frame = CGRectMake(10, 10 + imageHeight + 10, 200, 20);
        }
    }
    
    return _mTextLabel;
}

- (UIImageView *)mImageView
{
    if (!_mImageView)
    {
        _mImageView = [[UIImageView alloc] init];
        [self addSubview:_mImageView];
        WS(weakSelf)
        if (_mType == horizontalType)
        {
            
            [_mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.mTextLabel.mas_left).with.offset(-10);
                make.centerY.equalTo(weakSelf.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
                
            }];
            

        }
        else
        {
            
            [_mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.mas_centerX).with.offset(0);
                make.top.equalTo(weakSelf.mas_top).with.offset(20);
                make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
            }];
        }
        
    }
    return _mImageView;
}

@end
