//
//  SAMenuTable.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SIMenuTable.h"
#import "SIMenuConfiguration.h"
#import <QuartzCore/QuartzCore.h>

@interface SIMenuTable () {
    CGRect endFrame;
    CGRect startFrame;
    NSIndexPath *currentIndexPath;
    NSInteger index;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *items;
@end

@implementation SIMenuTable

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSArray arrayWithArray:items];
        
        UIButton *bgBtn = [[UIButton alloc]init];
        bgBtn.backgroundColor = [UIColor clearColor];
        [bgBtn addTarget:self action:@selector(onBackgroundTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgBtn];
        [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        self.clipsToBounds = YES;
        
        //endFrame = self.bounds;
        
        endFrame = CGRectMake((self.bounds.size.width - 150)/2.0, 0, 150, self.items.count*[SIMenuConfiguration itemCellHeight]);
        startFrame = endFrame;
        startFrame.origin.y -= self.items.count*[SIMenuConfiguration itemCellHeight];
        
        self.table = [[UITableView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table.bounces = NO;
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.table.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, [SIMenuConfiguration menuWidth], self.table.bounds.size.height)];
//        header.backgroundColor = [UIColor color:[SIMenuConfiguration itemsColor] withAlpha:[SIMenuConfiguration menuAlpha]];
//        header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [self.table addSubview:header];
        
        index = 0;
        
        
    }
    return self;
}

- (void)show
{
    [self addSubview:self.table];
    WS(weakSelf)
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] animations:^{
        weakSelf.table.frame = endFrame;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide
{
    WS(weakSelf)
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] animations:^{
        weakSelf.table.frame = startFrame;
    } completion:^(BOOL finished) {
        currentIndexPath = nil;
        [weakSelf removeFooter];
        [weakSelf.table removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}

- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    return [SIMenuConfiguration animationDuration]*percentage/100.0;
}

//- (void)addFooter
//{
//    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [SIMenuConfiguration menuWidth], self.table.bounds.size.height - (self.items.count * [SIMenuConfiguration itemCellHeight]))];
//    self.table.tableFooterView = footer;
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
//    [footer addGestureRecognizer:tap];
//}

- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SIMenuConfiguration itemCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row == index) {
        cell.textLabel.textColor = [UIColor HFColorStyle_5];
    }else{
        cell.textLabel.textColor = [UIColor HFColorStyle_2];
    }
    //titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    cell.textLabel.font = [UIFont fontWithName:@"00d2df" size:17];
    cell.backgroundColor = [UIColor HFColorStyle_6];
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor colorWithRed:77 green:184 blue:194 alpha:1];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.menuDelegate didSelectItemAtIndex:indexPath.row];
//    currentIndexPath = indexPath;
//    
//    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.textColor = [UIColor hexChangeFloat:@"00d2df" withAlpha:1.0];
    index = indexPath.row;
    [self.table reloadData];
//    [cell setSelected:YES withCompletionBlock:^{
//        [self.menuDelegate didSelectItemAtIndex:indexPath.row];
//    }];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SIMenuCell *cell = (SIMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelected:NO withCompletionBlock:^{
//
//    }];
}

@end
