//
//  AltertView.m
//  GuanHealth
//
//  Created by hermit on 15/3/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFAlertView.h"
#import <objc/runtime.h>
#import "GlobConfig.h"
#import "UIKitTool.h"
#import "Masonry.h"
#import "UIColor+TK_Color.h"
@interface AlertView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *describleLabel;
@property (nonatomic, strong) UIButton *determinBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation AlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor whiteColor];
        [[self layer] setCornerRadius:5];
        [[self layer] setShadowOffset:CGSizeMake(3, 3)];
        [[self layer] setShadowRadius:5];
        [[self layer] setShadowOpacity:0.8];
        [[self layer] setShadowColor:[UIColor blackColor].CGColor];
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
            make.left.equalTo(self).with.offset(20);
            make.right.equalTo(self).with.offset(-20);
            make.top.equalTo(self).with.offset(20);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    return _titleLabel;
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
        [_determinBtn setTitleColor:[UIColor tkThemeColor1] forState:UIControlStateNormal];
        [_determinBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _determinBtn.clipsToBounds = YES;
        [_determinBtn.layer setBorderWidth:1];
        [_determinBtn.layer setBorderColor:[UIColor tkThemeColor1].CGColor];
        [_determinBtn.layer setCornerRadius:2];
        [self addSubview:_determinBtn];
    }
    return _determinBtn;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _cancelBtn.clipsToBounds = YES;
        [_cancelBtn.layer setBorderWidth:1];
        [_cancelBtn.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [_cancelBtn.layer setCornerRadius:2];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}
@end


@implementation HFAlertView

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
    HFAlertView *altertView = [[self alloc]initWithFrame:kScreenBounds];
    objc_setAssociatedObject(altertView, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [altertView show];
    AlertView *subAltert = [[AlertView alloc]init];
    [altertView addSubview:subAltert];
    
    [subAltert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(altertView.mas_left).with.offset(20);
        make.right.equalTo(altertView.mas_right).with.offset(-20);
        make.centerY.equalTo(altertView.mas_centerY);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    if (title.length>0) {
        subAltert.titleLabel.text = title;
    }
    if (message == nil) {
        subAltert.describleLabel.text = @"";
    }else if ([message isKindOfClass:[NSString class]]) {
        subAltert.describleLabel.text = message;
    }else if ([message isKindOfClass:[NSAttributedString class]]) {
        subAltert.describleLabel.attributedText = message;
    }else {
        subAltert.describleLabel.text = @"";
    }
    NSAssert(determineTitle != nil || cancelTitle != nil, @"至少要一个按钮");
    
    if (cancelTitle == nil || determineTitle == nil) {
        [subAltert.cancelBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *text = cancelTitle ? cancelTitle:determineTitle;
        [subAltert.cancelBtn setTitle:text forState:UIControlStateNormal];
        [subAltert.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.equalTo(subAltert).with.offset(-20);
            make.left.equalTo(subAltert).with.offset(90);
            make.right.equalTo(subAltert).with.offset(-90);
        }];
    }else {
        [subAltert.cancelBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        [subAltert.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [subAltert.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.equalTo(subAltert).with.offset(-20);
            make.right.equalTo(subAltert).with.offset(-20);
            make.width.equalTo(subAltert.determinBtn);
        }];
        
        [subAltert.determinBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        [subAltert.determinBtn setTitle:determineTitle forState:UIControlStateNormal];
        [subAltert.determinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.bottom.equalTo(subAltert).with.offset(-20);
            make.left.equalTo(subAltert).with.offset(20);
            make.right.equalTo(subAltert.cancelBtn.mas_left).with.offset(-20);
        }];
    }
    [subAltert setNeedsUpdateConstraints];
    return altertView;
}






#pragma mark - 嗨健康项目使用，已废弃
+ (instancetype)initWithTitle:(NSString *)title withMessage:(NSString *)message commpleteBlock:(void(^)(NSInteger buttonIndex))block cancelTitle:(NSString *)cancelTitle determineTitle:(NSString *)determineTitle
{
    HFAlertView *altertView = [[self alloc]initWithFrame:kScreenBounds];
    objc_setAssociatedObject(altertView, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    CGFloat height = [UIKitTool caculateHeight:message sizeOfWidth:280*kScreenScale-24.0f withAttributes:attributes];
    
    UIView *subAltert = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280*kScreenScale, 110+height)];
    subAltert.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    subAltert.clipsToBounds = YES;
    subAltert.backgroundColor = [UIColor whiteColor];
    [[subAltert layer] setCornerRadius:2];
    [[subAltert layer] setShadowOffset:CGSizeMake(2, 2)];
    [[subAltert layer] setShadowRadius:5];
    [[subAltert layer] setShadowOpacity:1];
    [[subAltert layer] setShadowColor:[UIColor blackColor].CGColor];
    [altertView addSubview:subAltert];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 250, 21)];
    titleLabel.font = [UIFont systemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor HFColorStyle_1];
    titleLabel.text = title;
    [subAltert addSubview:titleLabel];
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 35, subAltert.frame.size.width-24, height+5)];
    messageLabel.text = message;
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = [UIColor HFColorStyle_7];
    messageLabel.font = [UIFont systemFontOfSize:16.0f];
    [subAltert addSubview:messageLabel];
    
    UIButton *determineBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    if (determineTitle) {
        determineBtn.backgroundColor = [UIColor clearColor];
        determineBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [determineBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
        [determineBtn setTitle:determineTitle forState:UIControlStateNormal];
        // determineBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 10, -5, -10);
        determineBtn.tag = 1;
        [determineBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        [determineBtn sizeToFit];
        determineBtn.frame = CGRectMake(subAltert.frame.size.width-determineBtn.frame.size.width-30, subAltert.frame.size.height - 5 - determineBtn.frame.size.height - 10, determineBtn.frame.size.width+30, determineBtn.frame.size.height+10);
        [subAltert addSubview:determineBtn];
    }
    
    if (cancelTitle) {
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [cancelBtn setTitleColor:[UIColor HFColorStyle_1] forState:UIControlStateNormal];
        [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        //cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 10, -5, -10);
        cancelBtn.tag = 0;
        [cancelBtn addTarget:altertView action:@selector(alertAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn sizeToFit];
        cancelBtn.frame = CGRectMake(determineBtn.frame.origin.x-cancelBtn.frame.size.width-30, determineBtn.frame.origin.y, cancelBtn.frame.size.width+30, cancelBtn.frame.size.height+10);
        [subAltert addSubview:cancelBtn];
    }
    
    return altertView;
}

- (void)alertAction:(UIButton*)bt
{
    void (^block)(NSInteger buttonIndex) = objc_getAssociatedObject(self, "blockCallback");
    if (block) {
        block(bt.tag);
    }
    [self removeFromSuperview];
}

- (void)show
{
    [[UIKitTool getAppdelegate].window addSubview:self];
}

@end
