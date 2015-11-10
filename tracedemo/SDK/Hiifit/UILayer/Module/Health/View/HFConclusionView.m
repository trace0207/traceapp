//
//  HFConclusionView.m
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/15.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import "HFConclusionView.h"
#import "NSString+HFStrUtil.h"

@implementation HFConclusionView

- (void)awakeFromNib {
    self.getSchemeButton.layer.cornerRadius = 20;
    self.getSchemeButton.layer.masksToBounds = YES;
    [self.getSchemeButton setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    self.restartButton.layer.cornerRadius = 20;
    self.restartButton.layer.masksToBounds = YES;
}

- (void)setData:(GetQuizConclusionAck *)data
{
    self.titleLabel.text = data.data.title;
    self.contentLabel.text = data.data.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)changeState
{
    self.restartButton.hidden = YES;
    self.getSchemeButton.hidden = YES;
    self.testResultLabel.hidden = YES;
    
    UILabel * resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 34, 80, 22)];
    resultLabel.text = @"测试结果";
    resultLabel.font = [UIFont systemFontOfSize:16.0];
    resultLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:resultLabel];
    
    UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = self.giveButton.frame;
    [closeButton addTarget:self action:@selector(closeConclusionView) forControlEvents:UIControlEventTouchUpInside];
    self.giveButton.hidden = YES;
    closeButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:closeButton];
}
- (void)closeConclusionView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeConclusion)]) {
        [self.delegate closeConclusion];
    }
}
- (IBAction)restart:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(restartTest)]) {
        [self.delegate restartTest];
    }
}

- (IBAction)getScheme:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getScheme)]) {
        [self.delegate getScheme];
    }
}

- (IBAction)giveUpTest:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(giveUp)]) {
        [self.delegate giveUp];
    }
}
@end
