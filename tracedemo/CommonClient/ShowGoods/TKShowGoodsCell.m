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

@implementation TKShowGoodsCell

- (void)awakeFromNib {
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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

-(IBAction)followAction:(id)sender
{
    if(self.tkShowGoodscellDelegate)
    {
        [self.tkShowGoodscellDelegate onFollowBtnClick:self.indexPath];
    }
    
//    [self.tkShowGoodscellDelegate getRowDataByIndex:self.indexPath];
    
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
