//
//  ChildSchemeCell.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/15.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "ChildSchemeCell.h"
#import "UIImage+Scale.h"
#import "HFActionView.h"
#import "SchemePunchAck.h"

const CGFloat width = 115.0f;
const CGFloat height = 73.0f;
@implementation ChildSchemeCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.addSchemeBtn setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addSchemeSelector:(SEL)selector withTarget:(id)target andObject:(id)object
{
    [self.addSchemeBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

//点击头像
- (void)userCenterSelector:(SEL)selector withTarget:(id)target
{
    [self.headBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTopData:(SubSchemeHomeData *)data
{
    if (!data) {
        return;
    }
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:data.picAddr] placeholderImage:IMG(@"main_banner")];
    self.diseaseLable.text = data.disease;
    self.organLabel.text = data.parts;
    self.levelView.levelCounts = 3;
    self.levelView.highlightedCounts = data.levels;
    if (data.isSubscribe) {
        self.bgView.hidden = YES;
        if (data.days>999) {
            self.daysLabel.text = @"999⁺";
        }else{
            self.daysLabel.text = [[NSNumber numberWithInteger:data.days]stringValue];
        }
        self.daysLabel.textColor = [UIColor HFColorStyle_1];
    }else {
        self.bgView.hidden = NO;
    }
}

- (void)addActions:(NSArray *)actions withSelector:(SEL)selector andTarget:(id)target
{
    if (actions.count == 0) {
        return;
    }
    self.lineImage.backgroundColor = [UIColor HFColorStyle_5];
    for (NSUInteger i = 0; i < actions.count; i++) {
        HFActionView *actionView = (HFActionView *)[self.contentView viewWithTag:i + BASETAG];
        if (!actionView) {
            actionView = [[HFActionView alloc]initWithFrame:CGRectMake(15 + i*(width+10), 0, width, height)];
            actionView.tag = i+BASETAG;
            [self.scrollView addSubview:actionView];
        }
        [actionView selectedItemSelector:selector withTarget:target];
        SchemeActionsData *data = [actions objectAtIndex:i];
        [actionView setActionData:data];
        actionView.tag = i;
    }
    [self.scrollView setContentSize:CGSizeMake(actions.count*(width+10)+20, CGRectGetHeight(self.scrollView.frame))];
}

- (void)setPunchCards:(NSArray *)men completeCount:(NSInteger)completeCount
{
    if (men.count==0) {
        return;
    }
    NSInteger limitCount = (NSInteger)(kScreenWidth - 81 - 32)/23;
    NSInteger num = MIN(limitCount, men.count);
    self.punchLabel.text = [[NSNumber numberWithInteger:completeCount]stringValue];
    [self.punchLabel setTextColor:[UIColor HFColorStyle_5]];
    for (NSUInteger i = 0; i < num; i++) {
        BasePortraitView *portrait = (BasePortraitView *)[self.contentView viewWithTag:i+BASETAG];
        if (!portrait) {
            portrait = [[BasePortraitView alloc]initWithFrame:CGRectMake(81+23*i, 17, 25, 25)];
            portrait.tag = i+BASETAG;
            [self.contentView addSubview:portrait];
        }
        SchemePunchList *data = [men objectAtIndex:i];
        
        [portrait sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:IMG(@"head_default")];
        
        [portrait sendToBack];
    }
}

- (void)setPunchMen:(SchemePunchList *)data
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:IMG(@"head_default")];
    self.headBtn.tag = data.userId;
    self.nameLabel.text = data.nickName;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@完成训练",[NSDate stringWithTimeUTC:data.createTimeUTC]];
    
}

@end
