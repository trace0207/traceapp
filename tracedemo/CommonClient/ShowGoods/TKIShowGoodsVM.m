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
#import "TK_GetOrdersAck.h"
#import "NSString+HFStrUtil.h"

@interface TKIShowGoodsVM()<TKShowGoodsCellDelegate>

@end

@implementation TKIShowGoodsVM


-(void)tkLoadDefaultData
{
    
    WS(weakSelf)
    [[TKProxy proxy].mainProxy getShowOrders:self.category.categoryId page:0 withBlock:^(HF_BaseAck *ack) {
       
//        DDLogInfo(@"orders list %@",ack);
        
        if([ack isKindOfClass:[TK_GetOrdersAck class]])
        {
            [weakSelf resetData:(TK_GetOrdersAck *)ack];
        }
        
        [weakSelf stopRefresh];
        
    }];
}


-(void)resetData:(TK_GetOrdersAck *)ack
{
    DDLogInfo(@"loadDefaultData  enter   go  go go ");
    
    TKTableSectionM * section = [[TKTableSectionM alloc] init];
    [section.rowsData removeAllObjects];
    section.sectionHeadHeight = 0.1;
    section.sectionFootHeight = 0.1;
    
    for (GetOrderData * data in ack.data) {
        
        TKIShowGoodsRowM * row = [[TKIShowGoodsRowM alloc] init];
        row.showGoodsData = [[TKShowGoodsRowData alloc] init];
        row.ackData = data;
        
        if(![NSString isStrEmpty:data.picAddr1])
        {
            [row.showGoodsData.pics addObject:data.picAddr1];
        }
        
        if(![NSString isStrEmpty:data.picAddr2])
        {
            [row.showGoodsData.pics addObject:data.picAddr2];
        }
        if(![NSString isStrEmpty:data.picAddr3])
        {
            [row.showGoodsData.pics addObject:data.picAddr3];
        }
        if(![NSString isStrEmpty:data.picAddr4])
        {
            [row.showGoodsData.pics addObject:data.picAddr4];
        }
        if(![NSString isStrEmpty:data.picAddr5])
        {
            [row.showGoodsData.pics addObject:data.picAddr5];
        }
        if(![NSString isStrEmpty:data.picAddr6])
        {
            [row.showGoodsData.pics addObject:data.picAddr6];
        }
        if(![NSString isStrEmpty:data.picAddr7])
        {
            [row.showGoodsData.pics addObject:data.picAddr7];
        }
        if(![NSString isStrEmpty:data.picAddr8])
        {
            [row.showGoodsData.pics addObject:data.picAddr8];
        }
        if(![NSString isStrEmpty:data.picAddr9])
        {
            [row.showGoodsData.pics addObject:data.picAddr9];
        }

        [section.rowsData addObject:row];
        
    }
    [self setDefaultSection:section];
    [self.mTableView reloadData];
}



-(void)defaultViewSetting
{
    [self.mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)beginPullDownRefreshing
{
    [self tkLoadDefaultData];
//    [self.mTableView reloadData];
//    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone
//    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    
//    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

- (void)beginPullUpLoading
{
    [self tkLoadDefaultData];
//    [self.mTableView reloadData];
//    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.3];
}

-(BOOL)hasRefreshFooterView
{
    return YES;
}


#pragma  mark  UITableViewDelegate && UITableViewDataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TKIShowGoodsRowM * rowD = (TKIShowGoodsRowM *)[self.defaultSection.rowsData objectAtIndex:indexPath.row];
//    [self toShowGoodsDetailPage:rowD.showGoodsData];
    
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
            if(i == 0)
            {
                NSInteger price =  rowD.ackData.showPrice.integerValue;
                label.text = [NSString stringWithFormat:@"悬赏价:￥%0.2f",price/100.0f];//3800";

            }else
            {
                label.text  = @"吊牌图";
            }
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
    
    GetOrderData * ackData = rowD.ackData;
    // 设置其他信息
    cell.userHeadImage.userId = ackData.id;
    TKSetHeadImageView(cell.userHeadImage,ackData.userHeaderUrl)
    cell.headFirstLabel.text =  ackData.userNickName;
    cell.headSecondLabel.text = ackData.userSignature;
    cell.contentText.text = ackData.content;
    
    TKSetHeadImageView(cell.buyerHeadImage, ackData.purchaserHeaderUrl)
    cell.buyerNameText.text = ackData.purchaserNickName;
    cell.zanCount.text =  ackData.praiseCount;
    if(ackData.praiseCount.integerValue <99)
    {
        cell.zanMore.hidden = YES;
    }
    else{
       cell.zanMore.hidden = NO;
    }
    cell.followCount.text = ackData.followCount;
    
    if(ackData.followCount.integerValue < 99)
    {
        cell.followMore.hidden = YES;
    }
    else{
       cell.followMore.hidden = NO;
    }
    
    [cell.brandBtn setTitle:ackData.brandName forState:UIControlStateNormal];
    [cell.categoryBtn setTitle:ackData.categoryName forState:UIControlStateNormal];
    
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
