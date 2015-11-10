//
//  HFMessageDetailView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/23.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMessageDetailView.h"
#import "CLLRefreshHeadController.h"
@interface HFMessageDetailView()<UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate,HFMessageCellDelegate>
{
    CLLRefreshHeadController * refreshController;
    
    MessageType mType;
    
    NSArray * mSourceArray;
    
    UIView * noMessageView;
}
@property(nonatomic,strong)NSArray * mSourceArray;
@end

@implementation HFMessageDetailView
@synthesize mTableView,delegate;
@synthesize mSourceArray;
- (instancetype)initWithFrame:(CGRect)frame withTableViewStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadUI:style];
    }
    return self;
}

- (void)loadUI:(UITableViewStyle)style
{
    mTableView = [[UITableView alloc]initWithFrame:self.bounds style:style];
    mTableView.backgroundColor = [UIColor HFColorStyle_6];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:mTableView];
    refreshController = [[CLLRefreshHeadController alloc]initWithScrollView:mTableView viewDelegate:self];
    if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    //创建没有信息的view
    noMessageView = [[UIView alloc] initWithFrame:self.bounds];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 55)/2, 194, 55, 59)];
    imageView.image = IMG(@"noMessage");
    [noMessageView addSubview:imageView];
    noMessageView.backgroundColor = [UIColor HFColorStyle_6];
    noMessageView.hidden = YES;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.frame.origin.y + imageView.frame.size.height + 18, self.frame.size.width - 20 * 2, 30)];
    label.text = _T(@"HF_Common_No_Messages");
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor HFColorStyle_7];
    label.font = [UIFont systemFontOfSize:16.0f];
    [noMessageView addSubview:label];
    [self addSubview:noMessageView];
}

- (void)startRequest
{
    [refreshController startPullDownRefreshing];
}

- (void)endRefreash
{
    [refreshController endPullDownRefreshing];
    [refreshController endPullUpLoading];
}

- (void)reloadData:(NSArray *)datas withType:(MessageType)type
{
    if ([datas count] == 0)
    {
        noMessageView.hidden = NO;
        mTableView.hidden = YES;
    }
    else
    {
        noMessageView.hidden = YES;
        mTableView.hidden = NO;
    }
    
    mType = type;
    
    self.mSourceArray = datas;
    [mTableView reloadData];
}

#pragma mark -
#pragma mark TableViewDelegate  && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFMessageTypeInfoData * data = [mSourceArray objectAtIndex:indexPath.row];
    return [UIKitTool caculateHeightForMessage:data withMessageType:mType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFMessageCell"];
    if (cell == nil) {
        cell = [[HFMessageCell alloc] initWithXibName:@"HFMessageCell"];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HFMessageTypeInfoData *data = [mSourceArray objectAtIndex:indexPath.row];
    [cell setContentToCell:data withType:mType];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate && [delegate respondsToSelector:@selector(detailMessageActionAtIndex:withType:)]) {
        [delegate detailMessageActionAtIndex:indexPath.row withType:mType];
    }
}

#pragma mark -
#pragma mark HFMessageCellDelegate
- (void)headImageAction:(HFMessageCell *)cell
{
    if (mType == MSGBOX_SYSTEM_TYPE)
    {
        return;
    }
    
    NSInteger index = [mTableView indexPathForCell:cell].row;
    HFMessageTypeInfoData *data = [mSourceArray objectAtIndex:index];
    
    if (delegate && [delegate respondsToSelector:@selector(headPageJump:)])
    {
        [delegate headPageJump:data.operatorId];
    }
}

#pragma mark -
#pragma mark CLL
- (BOOL)hasRefreshFooterView
{
    if ([mSourceArray count] == 0 || mSourceArray.count % kPageSize != 0) {
        return NO;
    }
    return YES;
}

- (void)beginPullDownRefreshing
{
    if (delegate && [delegate respondsToSelector:@selector(loadPullDownRefreashData)]) {
        [delegate loadPullDownRefreashData];
    }
}

- (void)beginPullUpLoading
{
    if (delegate && [delegate respondsToSelector:@selector(loadPullUpRefreshData)]) {
        [delegate loadPullUpRefreshData];
    }
}

- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}

@end
