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

@implementation HFAlertView



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
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
        }];
        
    }
    return self;
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
