//
//  HFRemindView.m
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/29.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFRemindView.h"
#import "HFRemindCell.h"
#import "HFBindDeviceListController.h"
#import "BandCenter.h"
@interface HFRemindView()<UITableViewDelegate, UITableViewDataSource,HFRemindCellDelegate>

@property (nonatomic, strong) UIView * tableBackView;
@property (nonatomic, strong) UIView * blackView;
@property (nonatomic, strong) UITableView * mTableView;

@end
@implementation HFRemindView

- (id)init
{
    if (self = [super init]) {
        [self resetFrame];
        [self addGesture];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetFrame];
        [self addGesture];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self resetFrame];
        [self addGesture];
    }
    return self;
}
- (void)addGesture
{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgrounde)];
    [self.blackView addGestureRecognizer:tapGesture];
}
- (void)tapBackgrounde{
    [UIView animateWithDuration:0.2 animations:^{
        self.tableBackView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 270);
        self.blackView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)resetFrame
{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0.4;
    [self addSubview:self.blackView];
    
    self.tableBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 270)];
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 270)];
    self.mTableView.bounces = NO;
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.tableBackView addSubview:self.mTableView];
    [self addSubview:self.tableBackView];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.bHasSetting)
    {
        return 3;
    }
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString * cellIdentifier = @"remindIndentify";
        HFRemindCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[HFRemindCell alloc] initWithIndex:0];
        }
        return cell;
    }else{
        static NSString * identifier = @"remindIndentify";
        HFRemindCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[HFRemindCell alloc] initWithIndex:1];
            cell.delegate = self;
            cell.remindNameLabel.text = indexPath.row == 1 ? @"短信提醒" : @"来电提醒";
            
            if (indexPath.row == 1)
            {
                cell.switchView.on = [GlobInfo shareInstance].usr.isSmsRemind;
            }
            else
            {
                cell.switchView.on = [GlobInfo shareInstance].usr.isMobileRemind;
            }
            
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    return 105;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(myDeviceClicked)]) {
            [self.delegate myDeviceClicked];
        }
        [self removeFromSuperview];
    }
}
- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
        
        CGFloat height = 0.0;
        if (self.bHasSetting)
        {
            height = 270.0;
        }
        else
        {
            height = 60.0;
        }
        self.tableBackView.frame = CGRectMake(0, kScreenHeight - height, kScreenWidth, height);
        self.blackView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.tableBackView.frame.size.height);
    }];
}
- (void)dismiss
{
    [self tapBackgrounde];
}

#pragma mark -
#pragma mark HFRemindCellDelegate
- (void)switchState:(BOOL)state AtCell:(HFRemindCell *)cell
{
    NSInteger index = [self.mTableView  indexPathForCell:cell].row;
    
    if (index == 1)
    {
       [[[HIIProxy shareProxy] bandProxy] uploadMsgPush:state withPhonePush:[GlobInfo shareInstance].usr.isMobileRemind withBlock:^(HF_BaseAck *ack) {
           if ([ack sucess])
           {
               [[[HIIProxy shareProxy] userProxy] getUserInfo:^(BOOL finished) {
               }];
           }
           else
           {
               cell.switchView.on = !state;
           }
       }];
        
    }
    else
    {
       [[[HIIProxy shareProxy] bandProxy] uploadMsgPush:[GlobInfo shareInstance].usr.isSmsRemind withPhonePush:state withBlock:^(HF_BaseAck *ack) {
           if ([ack sucess])
           {
               [[[HIIProxy shareProxy] userProxy] getUserInfo:^(BOOL finished) {
               }];
           }
           else
           {
               cell.switchView.on = !state;
           }
       }];
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
