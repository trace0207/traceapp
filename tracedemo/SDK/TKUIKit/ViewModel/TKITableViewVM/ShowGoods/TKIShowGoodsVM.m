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
#import "TKICommentViewController.h"
#import <objc/runtime.h>
#import "UIColor+TK_Color.h"

@interface TKIShowGoodsVM()<TKShowGoodsCellDelegate>

@end

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
            NSString *iamgeURL;
            if(k%4 ==0)
            {
                iamgeURL = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124331_438_X.jpg";
            }else if(k%4==1)
            {
                iamgeURL = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_084_X.jpg";
            }else if(k%4 == 2)
            {
                iamgeURL = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_950_X.jpg";
            }else
            {
                iamgeURL = @"http://183.131.13.104:80/share/data/spider/pic/user/11186/weibo/weibo_20151109124332_498_X.jpg";
            }
            [row.showGoodsData.pics addObject:iamgeURL];
        }
        
        [section.rowsData addObject:row];
    }
    [self setDefaultSection:section];
    self.hasInitData = YES;
}



-(void)defaultViewSetting
{
    [self.mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    if(!cell)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TKShowGoodsCell" owner:self options:nil].firstObject;
        cell.backgroundColor = [UIColor clearColor];
    }
    [self fillCellImages:cell indexPath:indexPath];
    return cell;
}


-(void)fillCellImages:(TKShowGoodsCell *)cell  indexPath:(NSIndexPath *)indexPath
{
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];

    // 加载图片
    NSMutableArray * pics = rowD.showGoodsData.pics;
//    int type = (pics.count == 2?2:3);
    for(UIView *view in [cell.imageContentView subviews])
    {
        [view removeFromSuperview];
    }
    NSInteger count = pics.count;
    
    BOOL addMore = false;
    
    if(count >4)
    {
        count = 4;
        addMore = YES;
    }
    for(int i = 0;i< count;i++)
    {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(showBigImage:)];
        
        
//        objc_setAssociatedObject(tap, "pics", pics, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(tap, "pics", pics, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
        
        UIImageView * img = [[UIImageView alloc] init];
        img.clipsToBounds = YES;
        TKSetLoadingImageView(img, [pics objectAtIndex:i]);
        [cell.imageContentView addSubview:img];
        [img mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([rowD getPicWidth]);
            make.height.mas_equalTo([rowD getPicHeight]);
            CGFloat px = [rowD getFrameX:i]; //i%type * ([rowD getPicWidth] +[rowD getPicSeparation]) + [rowD getPicPaddingLeft];
            CGFloat py = [rowD getFrameY:i];//i/type * ([rowD getPicHeight] + [rowD getPicSeparation]);
            
//            if(self.logTrace)
//            {
//                DDLogInfo(@"image fill  height = %f, widht = %f, x = %f, y = %f",[rowD getPicWidth],[rowD getPicHeight],px,py);
//            }
            
            make.top.mas_equalTo(py );
            make.left.mas_equalTo(px );
        }];
        [img setUserInteractionEnabled:YES];
        [img addGestureRecognizer:tap];
        img.tag = indexPath.row * 1000 + i;
        
        
        // 添加 更多图标
        if(addMore && i == 3)
        {
            
            UIView * view = [[UIView alloc] init];
            [cell.imageContentView addSubview:view];
            view.backgroundColor = [UIColor TKcolorWithHexString:@"86000000"];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(img);
                make.center.equalTo(img);
                
            }];
            
            UIImageView * addMoreImage = [[UIImageView alloc] init];
            addMoreImage.image = IMG(@"icon_big_right_arrow");
            [cell.imageContentView addSubview:addMoreImage];
            [addMoreImage mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.center.equalTo(img);
                make.width.mas_equalTo(20);
                make.height.mas_equalTo(30);
                
            }];
            addMoreImage.tag = 999;
        }
        
        
        // 添加商品悬赏价// 和标签
        if(i == 0 || i == 1)
        {
            UIView * view = [[UIView alloc] init];
            [cell.imageContentView addSubview:view];
            view.backgroundColor = [UIColor TKcolorWithHexString:@"86000000"];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.equalTo(img);
                make.bottom.equalTo(img);
                make.left.equalTo(img);
                make.height.mas_equalTo(25);
                
            }];
            
            UILabel * label = [[UILabel alloc] init];
            [view addSubview:label];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"悬赏价:￥3800";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            [label setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.edges.equalTo(view);
            }];
        }
    }
    cell.imageFiledHeight.constant = [rowD getImageFiledHeight];
    cell.textHeight.constant = [rowD getContentTextHeight];
    // －－－－－加载图片结束
    
    // 设置其他信息
    cell.userHeadImage.userId = @"";
    cell.headFirstLabel.text =  @"这里显示昵称";
    cell.headSecondLabel.text = @"这里显示其他信息";
    cell.contentText.text = @"到了，速度真快。 谁买谁知道。海外代购航空直邮，一周内到货，你值得信赖  bala bala ～～  bala bala ～ ";
    cell.tkShowGoodscellDelegate = self;
    cell.indexPath = indexPath;
}

/**
  显示大图
 **/
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    
//    NSArray * pics = objc_getAssociatedObject(tap, "imags"); // tkRuntime
    
   // NSArray * pics = (NSArray *)[tap valueForKey:@"tkImages"];
    
    int index = tap.view.tag%1000;
    NSInteger rowIndex = tap.view.tag/1000;
    
    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];

   NSArray * imageVIews =  [tap.view.superview subviews];
    
    NSMutableArray * pics = [[NSMutableArray alloc] init];
    for (UIView *view in imageVIews) {
        if([view isKindOfClass:[UIImageView class] ]&& view.tag != 999)
        {
            [pics addObject:view];
        }
    }
    
    
    
    [TKUITools showImagesInBigScreen:rowD.showGoodsData.pics
                       withImageViews:pics
                        currentIndex:index];
}


/**
 cell 协议方法，供给 cell 回调回去数据
 **/
-(TKShowGoodsRowData *)getRowDataByIndex:(NSIndexPath *) indexPath
{
    TKIShowGoodsRowM *  rowM = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    return rowM.showGoodsData;
}

///**
//  点赞
// **/
//-(void)likeClick:(id)sender
//{
//    UIButton * btn = (UIButton *)sender;
//    NSInteger rowIndex = (btn.tag - 1)/1000;
//    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
//    DDLogInfo(@"I Like it %@",rowD.showGoodsData);
//}
//
//
///**
// 评论
// **/
//-(void)commentClick:(id)sender
//{
//    UIButton * btn = (UIButton *)sender;
//    NSInteger rowIndex = (btn.tag - 2)/1000;
//    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
//    DDLogInfo(@"commentClick %@",rowD.showGoodsData);
//    TKICommentViewController *vc = [[TKICommentViewController alloc] init];
//    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
//}
//
//
///**
// 悬赏
// **/
//-(void)rewardClick:(id)sender
//{
//    UIButton * btn = (UIButton *)sender;
//    NSInteger rowIndex = (btn.tag - 3)/1000;
//    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:rowIndex];
//    DDLogInfo(@"rewardClick %@",rowD.showGoodsData);
//}


-(void)toShowGoodsDetailPage:(TKShowGoodsRowData *)data
{
    TKSHowGoodsDetailPageVC * vc = [[TKSHowGoodsDetailPageVC alloc] init];
    
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
}



@end
