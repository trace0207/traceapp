//
//  TKSwitch.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/4/7.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKSwitch.h"

@interface TKSwitch()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *onContentView;
@property (nonatomic, strong) UIView *offContentView;
@property (nonatomic, strong) UIImageView *thumbView;

@property (nonatomic, strong) UILabel *onLabel;
@property (nonatomic, strong) UILabel *offLabel;
@end

@implementation TKSwitch

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self setNeedsLayout];
}

#pragma mark - 初始化

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    _onTintColor= [UIColor colorWithRed:232.0/255.0f green:232.0/255.0f blue:232.0/255.0f alpha:1];
    _offTintColor = [UIColor colorWithRed:232.0/255.0f green:232.0/255.0f blue:232.0/255.0f alpha:1];
    _onTextColor = [UIColor colorWithRed:195.0/255.0f green:195.0/255.0f blue:195.0/255.0f alpha:1];
    _offTextColor = [UIColor colorWithRed:195.0/255.0f green:195.0/255.0f blue:195.0/255.0f alpha:1];
    
    _textFont = [UIFont systemFontOfSize:14];
    _ballSize = CGRectGetHeight(self.bounds);
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
    
    _onContentView = [[UIView alloc] initWithFrame:self.bounds];
    _onContentView.backgroundColor = _onTintColor;
    [_containerView addSubview:_onContentView];
    
    _offContentView = [[UIView alloc] initWithFrame:self.bounds];
    _offContentView.backgroundColor = _offTintColor;
    [_containerView addSubview:_offContentView];
    
    _thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.ballSize, self.ballSize)];
    _thumbView.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_thumbView];
    
    _onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _onLabel.backgroundColor = [UIColor clearColor];
    _onLabel.textAlignment = NSTextAlignmentCenter;
    _onLabel.textColor = _onTextColor;
    _onLabel.font = _textFont;
    [_onContentView addSubview:_onLabel];
    
    _offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _offLabel.backgroundColor = [UIColor clearColor];
    _offLabel.textAlignment = NSTextAlignmentCenter;
    _offLabel.textColor = _offTextColor;
    _offLabel.font = _textFont;
    [_offContentView addSubview:_offLabel];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                 action:@selector(handleTapTapGestureRecognizerEvent:)];
//    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
    
}


-(void)setChildViewsFrame
{
    self.containerView.frame = self.bounds;
    
    CGFloat r = CGRectGetHeight(self.containerView.bounds) / 2.0;
    
    self.containerView.layer.cornerRadius = r;
    self.containerView.layer.masksToBounds = YES;
    
    self.thumbView.layer.cornerRadius = self.ballSize/2.0f;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0;
    
    if (!self.isOn) {
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.thumbView.frame = CGRectMake(margin,
                                          margin,
                                          self.ballSize,
                                          self.ballSize);
    } else {
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - self.ballSize,
                                          margin,
                                          self.ballSize,
                                          self.ballSize);
    }
    
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = r - (sqrtf(powf(r, 2) - powf(lHeight / 2.0, 2))) + margin;
    
    self.onLabel.frame = CGRectMake(lMargin,
                                    r - lHeight / 2.0,
                                    CGRectGetWidth(self.onContentView.bounds) - lMargin - self.ballSize - 2 * margin,
                                    lHeight);
    
    self.offLabel.frame = CGRectMake(self.ballSize + 2 * margin,
                                     r - lHeight / 2.0,
                                     CGRectGetWidth(self.onContentView.bounds) - lMargin - self.ballSize - 2 * margin,
                                     lHeight);

}


- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.onLabel.font = textFont;
    self.offLabel.font = textFont;
}
- (void)setOnText:(NSString *)onText
{
    if (_onText != onText) {
        _onText = onText;
        
        _onLabel.text = onText;
    }
}
- (void)setOffText:(NSString *)offText
{
    if (_offText != offText) {
        _offText = offText;
        
        _offLabel.text = offText;
    }
}

- (void)setOnTintColor:(UIColor *)onTintColor
{
    if (_onTintColor != onTintColor) {
        _onTintColor = onTintColor;
        _onContentView.backgroundColor = onTintColor;
    }
}

- (void)setOffTintColor:(UIColor *)offTintColor
{
    if (_offTintColor != offTintColor) {
        _offTintColor = offTintColor;
        _offContentView.backgroundColor = _offTintColor;
    }
}

- (void)setOnTextColor:(UIColor *)onTextColor
{
    _onTextColor = onTextColor;
    self.onLabel.textColor = onTextColor;
}

- (void)setOffTextColor:(UIColor *)offTextColor
{
    _offTextColor = offTextColor;
    self.offLabel.textColor = _offTextColor;
}

- (void)setBallSize:(CGFloat)ballSize
{
    _ballSize = ballSize;
    [self setNeedsLayout];
}

- (void)setThumbImage:(UIImage *)thumbImage
{
    _thumbImage = thumbImage;
    [self.thumbView setImage:thumbImage];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setChildViewsFrame];
}

- (void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    _on = on;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0;
    
    if (!animated) {
        if (!self.isOn) {
            // frame of off status
            self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                  0,
                                                  CGRectGetWidth(self.containerView.bounds),
                                                  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0,
                                                   0,
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetHeight(self.containerView.bounds));
            
            self.thumbView.frame = CGRectMake(margin,
                                              margin,
                                              self.ballSize,
                                              self.ballSize);
        } else {
            // frame of on status
            self.onContentView.frame = CGRectMake(0,
                                                  0,
                                                  CGRectGetWidth(self.containerView.bounds),
                                                  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                   0,
                                                   CGRectGetWidth(self.containerView.bounds),
                                                   CGRectGetHeight(self.containerView.bounds));
            
            self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - self.ballSize,
                                              margin,
                                              self.ballSize,
                                              self.ballSize);
        }
    } else {
        if (self.isOn) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - self.ballSize,
                                                                   margin,
                                                                   self.ballSize,
                                                                   self.ballSize);
                             }
                             completion:^(BOOL finished){
                                 self.onContentView.frame = CGRectMake(0,
                                                                       0,
                                                                       CGRectGetWidth(self.containerView.bounds),
                                                                       CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                                        0,
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetHeight(self.containerView.bounds));
                             }];
        } else {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.thumbView.frame = CGRectMake(margin,
                                                                   margin,
                                                                   self.ballSize,
                                                                   self.ballSize);
                             }
                             completion:^(BOOL finished){
                                 self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                                                       0,
                                                                       CGRectGetWidth(self.containerView.bounds),
                                                                       CGRectGetHeight(self.containerView.bounds));
                                 
                                 self.offContentView.frame = CGRectMake(0,
                                                                        0,
                                                                        CGRectGetWidth(self.containerView.bounds),
                                                                        CGRectGetHeight(self.containerView.bounds));
                             }];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}



- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:NO];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer
{
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            if (!self.isOn) {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.thumbView.frame = CGRectMake(margin,
                                                                       margin,
                                                                       self.ballSize,
                                                                       self.ballSize);
                                 }];
            } else {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.thumbView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - self.ballSize,
                                                                       margin,
                                                                       self.ballSize,
                                                                       self.ballSize);
                                 }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGPoint touchPiont = [recognizer translationInView:self];
            if (self.thumbView.center.x > self.ballSize/2.0f && touchPiont.x<0) {
                self.thumbView.center = CGPointMake(self.thumbView.center.x + touchPiont.x, self.thumbView.center.y);
            }
            if (self.thumbView.center.x < (CGRectGetWidth(self.containerView.bounds)-self.ballSize/2.0f) && touchPiont.x > 0) {
                self.thumbView.center = CGPointMake(self.thumbView.center.x + touchPiont.x, self.thumbView.center.y);
            }
            [recognizer setTranslation:CGPointMake(0, 0) inView:self];
            break;
        }
        case UIGestureRecognizerStateEnded:
            if (self.on) {
                if (self.thumbView.center.x > (CGRectGetWidth(self.containerView.bounds)*2.0f/3.0f)) {
                    [self setOn:YES animated:YES];
                }else{
                    [self setOn:NO animated:YES];
                }
            }else{
                if (self.thumbView.center.x < (CGRectGetWidth(self.containerView.bounds)/3.0f)) {
                    [self setOn:NO animated:YES];
                }else{
                    [self setOn:YES animated:YES];
                }
            }
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}
@end
