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
#import "TKUserCenter.h"
#import "NSString+HFStrUtil.h"
#import "TKLoginViewController.h"

@interface TKIShowGoodsVM()<TKShowGoodsCellDelegate>
{
    NSInteger nowPage;
}

@end

@implementation TKIShowGoodsVM


-(instancetype)init
{
    self = [super init];
    nowPage = 0;
    return self;
}

-(void)tkLoadDefaultData
{
    [self hidTips];
    WS(weakSelf)
    [[TKProxy proxy].mainProxy getShowOrders:self.category.categoryId
                                     brandId:self.brand.brandId
                                        page:nowPage withBlock:^(HF_BaseAck *ack) {
       
//        DDLogInfo(@"orders list %@",ack);
        
        if([ack isKindOfClass:[TK_GetOrdersAck class]])
        {
            [weakSelf resetData:(TK_GetOrdersAck *)ack];
        }
        
        [weakSelf stopRefresh];
        
        if(nowPage == 0 && weakSelf.defaultSection.rowsData.count == 0)
        {
            [weakSelf showTipsView:[TKUITools getListViewEmptyTip]];
        }
        
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
}

- (void)beginPullUpLoading
{
    [self tkLoadDefaultData];
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
    cell.indexPath = indexPath;
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
            
            view.userInteractionEnabled = NO;
            
            UIImageView * addMoreImage = [[UIImageView alloc] init];
            addMoreImage.image = IMG(@"icon_big_right_arrow");
            [cell.imageContentView addSubview:addMoreImage];
            [addMoreImage mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.center.equalTo(img);
                make.width.mas_equalTo(20);
                make.height.mas_equalTo(30);
                
            }];
            addMoreImage.tag = 999;
            addMoreImage.userInteractionEnabled = NO;
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
    cell.userHeadImage.roundValue = 2.0;
    
    
    if([ackData.userId isEqualToString:@"0"])//匿名晒单
    {
        cell.userHeadImage.image = IMG(@"tk_image_head_default");
        cell.headFirstLabel.text =  @"匿名消费者";
        cell.headSecondLabel.text = @"我是一个土豪，不解释";
        cell.contentText.text = ackData.content;
    }
    else // 正常显示
    {
        TKSetHeadImageView(cell.userHeadImage,  ackData.userHeaderUrl)
        cell.headFirstLabel.text =  ackData.userNickName;
        cell.headSecondLabel.text = ackData.userSignature;
        cell.contentText.text = ackData.content;

    }
    TKSetHeadImageView(cell.buyerHeadImage, [TKUITools getRawImage:ackData.purchaserHeaderUrl])
    cell.buyerNameText.text = ackData.purchaserNickName;
    cell.zanCount.text =  ackData.praiseCount;
    cell.buyerVipLevelText.text = @"签约买手";
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
    
#if B_Client == 1
    cell.followBtn.hidden = YES;
#endif
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


#pragma  mark  TKShowGoodsCellDelegate

/**
 cell 协议方法，供给 cell 回调回去数据
 **/
-(TKShowGoodsRowData *)getRowDataByIndex:(NSIndexPath *) indexPath
{
    TKIShowGoodsRowM *  rowM = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    return rowM.showGoodsData;
}


-(void)onPariseBtnClick:(NSIndexPath *)indexPath
{
    TKIShowGoodsRowM *  rowM = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    [[TKProxy proxy].mainProxy  praiseShowOrders:rowM.ackData.id withUserId:[[TKUserCenter instance] getUser].userId withBlock:^(HF_BaseAck *ack) {
       
        DDLogInfo(@"parise %@",ack);
        
        TKIShowGoodsRowM *  rowM = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
        rowM.ackData.praiseCount  =   [NSString tkStringFromNumber:rowM.ackData.praiseCount.integerValue + 1];
        
        [self.mTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    
    DDLogInfo(@"action from indexRow = %ld",indexPath.row);
}

-(void)onUserHeadFieldClick:(NSIndexPath *)indexPath
{
    DDLogInfo(@"action from indexRow = %ld",indexPath.row);

}

-(void)onBuyerHeadFiedClick:(NSIndexPath *)indexPath
{
    DDLogInfo(@"action from indexRow = %ld",indexPath.row);

}
-(void)onFollowBtnClick:(NSIndexPath *)indexPath
{
    DDLogInfo(@"action from indexRow = %ld",indexPath.row);
    
    if(self.showGoodsDelegate)
    {
        [self.showGoodsDelegate onFollowAction:[self.defaultSection.rowsData objectAtIndex:indexPath.row]];
    }
}


#pragma mark  event

-(void)toShowGoodsDetailPage:(TKShowGoodsRowData *)data
{
    TKSHowGoodsDetailPageVC * vc = [[TKSHowGoodsDetailPageVC alloc] init];
    
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
}

@end
