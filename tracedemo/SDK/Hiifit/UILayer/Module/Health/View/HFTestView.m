//
//  HFTestView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/27.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFTestView.h"
#import "HFTopImageView.h"

@interface HFTestView()

@property (nonatomic, strong) UIButton * yesButton;
@property (nonatomic, strong) UIButton * noButton;
@property (nonatomic, strong) HFTopImageView * topImageView;
@property (nonatomic, strong) UIButton * backButton;

@end
@implementation HFTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor HFColorStyle_5];
        [self loadUI];
    }
    return self;
}
- (void)loadUI
{
    WS(weakSelf);
    UILabel * navigationLabel = [[UILabel alloc] init];
    navigationLabel.text = @"测试中";
    navigationLabel.font = [UIFont systemFontOfSize:18.0];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.textColor = [UIColor whiteColor];
    [self addSubview:navigationLabel];
    [navigationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(33);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(63, 20));
    }];
    
    UIButton * giveUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    giveUpBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [giveUpBtn setTitle:@"放弃" forState:UIControlStateNormal];
    [giveUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:giveUpBtn];
    [giveUpBtn addTarget:self action:@selector(giveUpTestNow) forControlEvents:UIControlEventTouchUpInside];
    [giveUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(34);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(46, 22));
    }];
    
    self.topImageView = [[HFTopImageView alloc] init];
    self.topImageView.numberOfImages = 5;
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(giveUpBtn.mas_bottom).with.offset(32);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, 30));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageView.mas_bottom).with.offset(54);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(kScreenWidth - 20);
        make.height.mas_greaterThanOrEqualTo(1);
    }];

    self.yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yesButton.exclusiveTouch = YES;
    self.yesButton.userInteractionEnabled = NO;
    [self.yesButton setTitle:@"是" forState:UIControlStateNormal];
    [self.yesButton setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    [self.yesButton setBackgroundImage:IMG(@"answerBtn") forState:UIControlStateNormal];
    [self.yesButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.yesButton];
    [self.yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-135);
        make.right.equalTo(weakSelf.mas_centerX).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(86, 86));
    }];
    
    self.noButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.noButton.exclusiveTouch = YES;
    self.noButton.userInteractionEnabled = NO;
    self.noButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.noButton setBackgroundImage:IMG(@"answerBtn") forState:UIControlStateNormal];
    [self.noButton setTitle:@"否" forState:UIControlStateNormal];
    [self.noButton setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    [self.noButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.noButton];
    [self.noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX).with.offset(20);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-135);
        make.size.mas_equalTo(CGSizeMake(86, 86));
    }];

    
    //262
    UILabel * chooseLabel = [[UILabel alloc] init];
    chooseLabel.textColor = [UIColor whiteColor];
    chooseLabel.font = [UIFont systemFontOfSize:12.0];
    chooseLabel.text = @"请选择你的答案";
    chooseLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:chooseLabel];
    [chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.yesButton.mas_top).with.offset(-18);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(97, 21));
    }];
    
    UIView * leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor whiteColor];
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseLabel.mas_centerY);
        make.right.equalTo(chooseLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(20, 1));
    }];
    
    UIView * rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooseLabel.mas_right);
        make.centerY.equalTo(chooseLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 1));
    }];
    
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.hidden = YES;
    [self.backButton setTitle:@"上一题" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backFormer) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-30);
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
}
#pragma mark - privateFunction
- (void)changeImageNext:(NSInteger)index
{
    self.backButton.hidden = NO;
    [self.topImageView changeFinishImage:index];
}
- (void)changeImageFormer:(NSInteger)index withButtonState:(NSString *)state
{
    if (index == 1) {
        self.backButton.hidden = YES;
    }
    if ([state isEqualToString:@"0"]) {
        [self.noButton setBackgroundImage:IMG(@"questionSelected") forState:UIControlStateNormal];
        [self.yesButton setBackgroundImage:IMG(@"answerBtn") forState:UIControlStateNormal];
    }
    if ([state isEqualToString:@"1"]) {
        [self.yesButton setBackgroundImage:IMG(@"questionSelected") forState:UIControlStateNormal];
        [self.noButton setBackgroundImage:IMG(@"answerBtn") forState:UIControlStateNormal];
    }
    
    [self.topImageView changeFormerImage:index];
}
- (void)changeButtonState
{
    self.noButton.userInteractionEnabled = YES;
    self.yesButton.userInteractionEnabled = YES;
}
#pragma mark - setterFunction
- (void)setAgainData:(GetQuizSubjectAgainAck *)againData
{
    self.titleLabel.text = againData.data.content;
    CGFloat height = [UIKitTool caculateHeight:againData.data.content sizeOfWidth:kScreenWidth - 30 withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0]}];
    //CGFloat height = [UIKitTool heightForCell:againData.data.content withFont:18.0 withWidth:kScreenWidth - 30];
    WS(weakSelf);
    [weakSelf.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, height));
    }];
}
#pragma mark - privateFunction
- (void)choose:(UIButton *)button
{
    self.noButton.userInteractionEnabled = NO;
    self.yesButton.userInteractionEnabled = NO;
    [self.noButton setBackgroundImage:IMG(@"answerBtn") forState:UIControlStateNormal];
    [self.yesButton setBackgroundImage:IMG(@"answerBtn") forState:UIControlStateNormal];
    if ([button isEqual:self.noButton]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(chooseAnswer:)]) {
            [self.delegate chooseAnswer:NO];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(chooseAnswer:)]) {
            [self.delegate chooseAnswer:YES];
        }
    }
}
- (void)backFormer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backToLastTest)]) {
        [self.delegate backToLastTest];
    }
}
- (void)giveUpTestNow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(giveUpTest)]) {
        [self.delegate giveUpTest];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
