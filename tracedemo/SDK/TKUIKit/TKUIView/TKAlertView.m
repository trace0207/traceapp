//
//  TKAltertView.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/21.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKAlertView.h"
#import <objc/runtime.h>
#import "GlobConfig.h"
#import "UIKitTool.h"
#import "Masonry.h"
#import "UIColor+TK_Color.h"
#import "UIView+Border.h"
#import "UIButton+TitleImage.h"
#import "DeliveryTimeView.h"

@interface HUD : UIView
@property (nonatomic, strong) UILabel *textLabel;
@end


@implementation HUD

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultBackgroundView];
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:activityView];
        [activityView startAnimating];
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = [UIColor hexChangeFloat:TKColorBlack];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.text = @"正在发布，请稍后...";
        [_textLabel sizeToFit];
        [self addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(0);
            make.width.mas_greaterThanOrEqualTo(0);
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX).with.offset(activityView.frame.size.width/2.0f+4);
        }];
        [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(activityView.frame.size);
            make.centerY.equalTo(_textLabel.mas_centerY);
            make.right.equalTo(_textLabel.mas_left).with.offset(-4);
        }];
    }
    return self;
}

@end


@interface KAlertView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *describleLabel;
@property (nonatomic, strong) UIButton *determinBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIImageView *tipImageView;

@end
@implementation KAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDefaultBackgroundView];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).with.offset(20);
            make.height.mas_equalTo(20);
            make.width.mas_greaterThanOrEqualTo(10);
            make.centerX.equalTo(self.mas_centerX);
//            make.left.equalTo(self).with.offset(20);
//            make.right.equalTo(self).with.offset(-20);
//            make.top.equalTo(self).with.offset(20);
//            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)tipImageView
{
    if (_tipImageView == nil) {
        _tipImageView = [[UIImageView alloc]init];
        [self addSubview:_tipImageView];
    }
    return _tipImageView;
}

- (UILabel *)describleLabel
{
    if (_describleLabel == nil) {
        _describleLabel = [[UILabel alloc]init];
        _describleLabel.font = [UIFont systemFontOfSize:14];
        _describleLabel.textAlignment = NSTextAlignmentCenter;
        _describleLabel.textColor = [UIColor darkGrayColor];
        _describleLabel.numberOfLines = 0;
        [self addSubview:_describleLabel];
        
        [_describleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.right.equalTo(self).with.offset(-20);
            if (_titleLabel) {
                make.top.equalTo(self.titleLabel.mas_bottom).with.offset(20);
            }else {
                make.top.equalTo(self).with.offset(20);
            }
            make.bottom.equalTo(self).with.offset(-80);
        }];
    }
    return _describleLabel;
}

- (UIButton *)determinBtn
{
    if (_determinBtn == nil) {
        _determinBtn = [[UIButton alloc]init];
        _determinBtn.tag = 1;
        [_determinBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [_determinBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_determinBtn setDefaultBorder];
        [self addSubview:_determinBtn];
    }
    return _determinBtn;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_cancelBtn setDefaultBorder];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}
@end


@interface TKAlertView ()
@property (nonatomic, strong) KAlertView *subAltert;
@end

@implementation TKAlertView

- (KAlertView *)subAltert
{
    if (_subAltert == nil) {
        _subAltert = [[KAlertView alloc]init];
        [self addSubview: _subAltert];
        [_subAltert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(17.5*kWidthScale);
            make.right.equalTo(self.mas_right).with.offset(-17.5*kWidthScale);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
    }
    return _subAltert;
}

#pragma mark - 初始化，给一个透明的背景
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.4f;
        [self addSubview:backgroundView];
        
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return self;
}
#pragma mark - 本项目使用弹出框
+ (instancetype)showAltertWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle
{
    TKAlertView *altertView = [[self alloc]initWithFrame:kScreenBounds];
    objc_setAssociatedObject(altertView, "callBack", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[[UIApplication sharedApplication]keyWindow]addSubview:altertView];
    
    
    
    if (title.length>0) {
        altertView.subAltert.titleLabel.text = title;
    }
    if (message == nil) {
        altertView.subAltert.describleLabel.text = @"";
    }else if ([message isKindOfClass:[NSString class]]) {
        altertView.subAltert.describleLabel.text = message;
    }else if ([message isKindOfClass:[NSAttributedString class]]) {
        altertView.subAltert.describleLabel.attributedText = message;
    }else {
        altertView.subAltert.describleLabel.text = @"";
    }
    NSAssert(determineTitle != nil || cancelTitle != nil, @"至少要一个按钮");
    
    if (cancelTitle == nil || determineTitle == nil) {
        [altertView.subAltert.cancelBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *text = cancelTitle ? cancelTitle:determineTitle;
        [altertView.subAltert.cancelBtn setTitle:text forState:UIControlStateNormal];
        [altertView.subAltert.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.equalTo(altertView.subAltert).with.offset(-20);
            make.left.equalTo(altertView.subAltert).with.offset(90);
            make.right.equalTo(altertView.subAltert).with.offset(-90);
        }];
    }else {
        [altertView.subAltert.cancelBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        [altertView.subAltert.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [altertView.subAltert.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.equalTo(altertView.subAltert).with.offset(-20);
            make.right.equalTo(altertView.subAltert).with.offset(-20);
            make.width.equalTo(altertView.subAltert.determinBtn);
        }];
        
        [altertView.subAltert.determinBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        [altertView.subAltert.determinBtn setTitle:determineTitle forState:UIControlStateNormal];
        [altertView.subAltert.determinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.equalTo(altertView.subAltert).with.offset(-20);
            make.left.equalTo(altertView.subAltert).with.offset(20);
            make.right.equalTo(altertView.subAltert.cancelBtn.mas_left).with.offset(-20);
        }];
    }
    [altertView.subAltert setNeedsUpdateConstraints];
    return altertView;
}

+ (void)showSuccessWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle
{
    TKAlertView *alertView = [self showAltertWithTitle:title withMessage:message commpleteBlock:block cancelTitle:cancelTitle determineTitle:determineTitle];
    [alertView.subAltert.tipImageView setImage:IMG(@"success")];
    [alertView.subAltert.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertView.subAltert.mas_centerX).with.offset(10+3);
    }];
    [alertView.subAltert.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(alertView.subAltert.titleLabel.mas_left).with.offset(-3);
        make.centerY.equalTo(alertView.subAltert.titleLabel.mas_centerY);
    }];
}


+ (void)showFailedWithTitle:(NSString *)title withMessage:(id)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle
{
    TKAlertView *alertView = [self showAltertWithTitle:title withMessage:message commpleteBlock:block cancelTitle:cancelTitle determineTitle:determineTitle];
    [alertView.subAltert.tipImageView setImage:IMG(@"failed")];
    [alertView.subAltert.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertView.subAltert.mas_centerX).with.offset(10+3);
    }];
    [alertView.subAltert.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(alertView.subAltert.titleLabel.mas_left).with.offset(-3);
        make.centerY.equalTo(alertView.subAltert.titleLabel.mas_centerY);
    }];
}

+ (void)showDeliveryTimeWithBlock:(void(^)(NSInteger buttonIndex))block
{
    TKAlertView *alertView = [[self alloc]initWithFrame:kScreenBounds];
    objc_setAssociatedObject(alertView, "callBack", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[[UIApplication sharedApplication]keyWindow] addSubview:alertView];
    DeliveryTimeView *subView = [[DeliveryTimeView alloc]init];
    [alertView addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertView.mas_left).with.offset(17.5*kWidthScale);
        make.right.equalTo(alertView.mas_right).with.offset(-17.5*kWidthScale);
        make.center.equalTo(alertView);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [subView layoutIfNeeded];
    [subView.leftBtn addTarget:alertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
    [subView.rightBtn addTarget:alertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)showHUDWithText:(NSString *)text
{
    TKAlertView *alertView = [[self alloc]initWithFrame:kScreenBounds];
    [[[UIApplication sharedApplication]keyWindow] addSubview:alertView];
    if (alertView) {
        HUD *hud = [[HUD alloc]init];
        hud.textLabel.text = text;
        [alertView addSubview:hud];
        [hud mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(alertView.mas_left).with.offset(17.5*kWidthScale);
            make.right.equalTo(alertView.mas_right).with.offset(-17.5*kWidthScale);
            make.centerY.equalTo(alertView.mas_centerY);
            make.height.mas_equalTo(140*kWidthScale);
        }];
    }
    return alertView;
}

- (void)alertAction:(UIButton*)bt
{
    void (^block)(NSInteger buttonIndex) = objc_getAssociatedObject(self, "callBack");
    if (block) {
        block(bt.tag);
    }
    [self removeFromSuperview];
}

@end
