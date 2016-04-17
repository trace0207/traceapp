//
//  TKShowGoodsCell.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKShowGoodsCell.h"
#import "TKPublishRewardVC.h"
#import "TKICommentViewController.h"
#import "TKUserDetailInfoViewController.h"
#import "UIColor+TK_Color.h"

@implementation TKShowGoodsCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.followSwitch.onText = @"";
    self.followSwitch.onTextColor = [UIColor blackColor];
    self.followSwitch.offText = @"右滑跟单";
    self.followSwitch.offTintColor = [UIColor TKcolorWithHexString:@"E8E8E8"];
    self.followSwitch.onTintColor = [UIColor tkThemeColor2];
    self.followSwitch.thumbImage = IMG(@"icon_buy");
    self.followSwitch.ballSize = 28;
    [self.followSwitch addTarget:self action:@selector(followAction:) forControlEvents:(UIControlEventValueChanged)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)imageFieldBtn:(id)sender {
    TKUserDetailInfoViewController * vc = [[TKUserDetailInfoViewController alloc] init];
    vc.userId = self.userHeadImage.userId;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];}

- (IBAction)attentionAction:(id)sender {
}

- (IBAction)commentAction:(id)sender {
    if(_tkShowGoodscellDelegate && [_tkShowGoodscellDelegate respondsToSelector:@selector(onCommentBtnClick:)])
    {
        [_tkShowGoodscellDelegate onCommentBtnClick:self.indexPath];
    }
    else
    {
        TKICommentViewController *vc = [[TKICommentViewController alloc] init];
        [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    }
}

- (IBAction)likeAction:(id)sender {
    
    [[HFHUDView shareInstance] ShowTips:@"    点赞 +1    " delayTime:1.5f atView:nil];
    
}

- (IBAction)rewardAction:(id)sender {
    TKShowGoodsRowData *data = [self.tkShowGoodscellDelegate getRowDataByIndex:self.indexPath];
    TKPublishRewardVC * vc = [[TKPublishRewardVC alloc] initWithNibName:@"TKPublishShowGoodsVC" bundle:nil];
    vc.data = data;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
    
}




- (void)setHeadViewModel:(id)model
{
}

-(void)followAction:(TKSwitch *)sender
{
    if(sender.on)
    {
        [self performSelector:@selector(doFollowEvent) withObject:self afterDelay:0.5];
    }
}

-(void)doFollowEvent
{
    if(self.tkShowGoodscellDelegate)
    {
        [self.tkShowGoodscellDelegate onFollowBtnClick:self.indexPath];
    }
    [self.followSwitch setOn:NO animated:YES];
}

- (IBAction)buyerFieldAction:(id)sender {
    if(self.tkShowGoodscellDelegate)
    {
        [self.tkShowGoodscellDelegate onBuyerHeadFiedClick:self.indexPath];
    }
}
- (IBAction)pariseAction:(id)sender {
    if(self.tkShowGoodscellDelegate)
    {
        [self.tkShowGoodscellDelegate onPariseBtnClick:self.indexPath];
    }
}


- (IBAction)userHeadClick:(id)sender {
    if(self.tkShowGoodscellDelegate)
    {
        [self.tkShowGoodscellDelegate onUserHeadFieldClick:self.indexPath];
    }
}
@end
