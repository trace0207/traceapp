//
//  HFAdvanceSchemeTableViewCell.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFAdvanceSchemeTableViewCell.h"
#import "HFActionSheet.h"
#import "UIImage+Scale.h"

@interface HFAdvanceSchemeTableViewCell()<HFActionSheetDelegate>
{
    
}
@end

@implementation HFAdvanceSchemeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.startTestBtn setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.lineView) {
        self.lineView.backgroundColor = [UIColor HFColorStyle_5];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentData:(GetAdvanceSchemeMainPageSubData *)data
{
    self.mTitleLable.text = data.subSchemeName;
    if (data.isSubscribe)
    {
        self.mAddView.hidden = NO;
    }
    else
    {
        self.mAddView.hidden = YES;
    }
    self.mLevelView.levelCounts = 3;
    self.mLevelView.highlightedCounts = data.level;
    
    
    if (data.isSubscribe)
    {
        NSString * dayInfo;
        if (data.days > 999)
        {
            dayInfo = [NSString stringWithFormat:@"连续坚持999⁺天"];
        }
        else
        {
            dayInfo = [NSString stringWithFormat:@"连续坚持%ld天",data.days];
        }
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:dayInfo];
        [attributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:20.0]
                              range:NSMakeRange(4, [dayInfo length] - 5)];
        self.mDayInfoLabel.attributedText = attributedStr;
    }
    else
    {
        self.mDayInfoLabel.text = @"未添加";
    }
}


- (IBAction)moreAction:(UIButton *)sender
{
    HFActionSheet * action =  [[HFActionSheet alloc] init];
    action.delegate = self;
    [action showInSuperView:[UIKitTool getAppdelegate].window cancelButton:@"取消" otherButton:@"重新测试",@"放弃调理", nil];
}

- (IBAction)beginTestAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(jumpToTest)])
    {
        [_delegate jumpToTest];
    }
}

#pragma mark -
#pragma mark HFActionSheetDelegate
- (void)didSelectItemAtIndex:(NSInteger)index
{
    
    if (index == 0)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(restartTest)])
        {
            [_delegate restartTest];
        }
    }
    else if (index == 1)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(giveupAdvanceScheme)])
        {
            [_delegate giveupAdvanceScheme];
        }
    }
    else
    {
        
    }
    
}

@end
