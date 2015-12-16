//
//  TKIShowGoodsVM.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/14.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKIShowGoodsVM.h"
#import "TKShowGoodsCell.h"
#import "TKIShowGoodsRowM.h"
#import "TKUITools.h"
#import "TKHeadImageView.h"
#import "TKUserDetailInfoViewController.h"
#import "TKSHowGoodsDetailPageVC.h"

@implementation TKIShowGoodsVM


-(void)tkLoadDefaultData
{
    
    /**
     
     data4.picAddr1 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
     data4.picAddr2 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
     data4.picAddr3 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
     data4.picAddr4 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_950_X.jpg";
     data4.picAddr5 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
     data4.picAddr6 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
     data4.picAddr7 = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
     **/
    
    DDLogInfo(@"loadDefaultData  enter   go  go go ");
    
    TKTableSectionM * section = [[TKTableSectionM alloc] init];
    [section.rowsData removeAllObjects];
    section.sectionHeadHeight = 1;
    section.sectionFootHeight = 1;
    
    for(int i=0;i<20;i++)
    {
        TKIShowGoodsRowM * row = [[TKIShowGoodsRowM alloc] init];
        
        row.showGoodsData = [[TKShowGoodsRowData alloc] init];
        
        for(int k = 0;k<=i; k++)
        {
            [row.showGoodsData.pics addObject:@"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg"];
        }
        
        [section.rowsData addObject:row];
    }
    [self setDefaultSection:section];
    self.hasInitData = YES;
}



- (void)beginPullDownRefreshing
{
    [self tkLoadDefaultData];
    [self.mTableView reloadData];
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

- (void)beginPullUpLoading
{
    [self tkLoadDefaultData];
    [self.mTableView reloadData];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

-(BOOL)hasRefreshFooterView
{
    return YES;
}


#pragma  mark  UITableViewDelegate && UITableViewDataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
    [self toShowGoodsDetailPage:rowD.showGoodsData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKShowGoodsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"showGoodsCell"];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TKShowGoodsCell" owner:self options:nil].firstObject;
        cell.backgroundColor = [UIColor clearColor];
        [cell.layer setCornerRadius:5];
        [cell setClipsToBounds:YES];
    }
    [self fillCellImages:cell indexPath:indexPath];
    return cell;
}


-(void)fillCellImages:(TKShowGoodsCell *)cell  indexPath:(NSIndexPath *)indexPath
{
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];

    // 加载图片
    NSMutableArray * pics = rowD.showGoodsData.pics;
    int type = (pics.count == 4?2:3);
    for(UIView *view in [cell.imageContentView subviews])
    {
        [view removeFromSuperview];
    }
    for(int i = 0;i< pics.count;i++)
    {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(showBigImage:)];
        UIImageView * img = [[UIImageView alloc] init];
        TKSetLoadingImageView(img, [pics objectAtIndex:i]);
        [cell.imageContentView addSubview:img];
        [img mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([rowD getPicWidth]);
            make.height.mas_equalTo([rowD getPicHeight]);
            CGFloat px = i%type * ([rowD getPicWidth] +[rowD getPicSeparation]) + [rowD getPicPaddingLeft];
            CGFloat py = i/type * ([rowD getPicHeight] + [rowD getPicSeparation]);
            
            if(self.logTrace)
            {
                DDLogInfo(@"image fill  height = %f, widht = %f, x = %f, y = %f",[rowD getPicWidth],[rowD getPicHeight],px,py);
            }
            
            make.top.mas_equalTo(py );
            make.left.mas_equalTo(px );
        
        }];
        
        [img setUserInteractionEnabled:YES];
        [img addGestureRecognizer:tap];
        img.tag = indexPath.row * 1000 + i;
    }
    cell.imageFiledHeight.constant = [rowD getImageFiledHeight];
    // －－－－－加载图片结束
    
    // 设置其他信息
    cell.userHeadImage.userId = @"";
    [cell.userHeadImage addTapAction:@selector(goToUserPage:) forTarget:self];
    cell.headFirstLabel.text =  @"这里显示昵称";
    cell.headSecondLabel.text = @"这里显示其他信息";
    cell.contentText.text = @"到了，速度真快。 谁买谁知道。海外代购航空直邮，一周内到货，你值得信赖  bala bala ～～  bala bala ～ ";
    cell.likeBtn.tag = indexPath.row * 1000 + 1;
    cell.commentBtn.tag  = indexPath.row * 1000 + 2;
    cell.rewardBtn.tag = indexPath.row * 1000 + 3;
    [cell.likeBtn addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rewardBtn addTarget:self action:@selector(rewardClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
  显示大图
 **/
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    int index = tap.view.tag%1000;
    NSInteger rowIndex = tap.view.tag/1000;
    
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
    [TKUITools showImagesInBigScreen:rowD.showGoodsData.pics
                       withImageView: (UIImageView *)tap.view
                        currentIndex:index];
}


/**
 头像去用户中心
 **/
-(void)goToUserPage:(UIGestureRecognizer * )tap
{
    TKHeadImageView * head =  (TKHeadImageView *)tap.view;
    TKUserDetailInfoViewController * vc = [[TKUserDetailInfoViewController alloc] init];
    vc.userId = head.userId;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
}

/**
  点赞
 **/
-(void)likeClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    NSInteger rowIndex = (btn.tag - 1)/1000;
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
    DDLogInfo(@"I Like it %@",rowD.showGoodsData);
}


/**
 评论
 **/
-(void)commentClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    NSInteger rowIndex = (btn.tag - 2)/1000;
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
    DDLogInfo(@"commentClick %@",rowD.showGoodsData);
}


/**
 悬赏
 **/
-(void)rewardClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    NSInteger rowIndex = (btn.tag - 3)/1000;
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
    DDLogInfo(@"rewardClick %@",rowD.showGoodsData);
}


-(void)toShowGoodsDetailPage:(TKShowGoodsRowData *)data
{
    TKSHowGoodsDetailPageVC * vc = [[TKSHowGoodsDetailPageVC alloc] init];
    
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
}



@end
