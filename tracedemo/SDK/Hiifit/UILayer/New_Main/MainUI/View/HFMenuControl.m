//
//  Menu.m
//  menu
//
//  Created by zhuxiaoxia on 15/8/31.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFMenuControl.h"
#import "HFMenuCell.h"

CGFloat const DefaultMenuWidth = 140;
CGFloat const DefaultMenuHeight = 44;

@interface HFMenuControl ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titlesArray;
    CGRect menuRect;
}

@property (strong, nonatomic) UITableView *mTableView;
@property (assign, nonatomic) CGFloat mMenuHeight;

@end

@implementation HFMenuControl
- (instancetype)initWithTitles:(NSArray *)titles style:(HFMenuType)type
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        titlesArray = [titles copy];
        UIButton *hiddenBtn = [[UIButton alloc]initWithFrame:self.frame];
        [hiddenBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hiddenBtn];
        CGFloat o_x = CGRectGetWidth(self.frame)-DefaultMenuWidth - 6;
        if (type == HFMenuTypeCenter) {
            o_x = (CGRectGetWidth(self.frame)-DefaultMenuWidth)/2;
        }else if (type == HFMenuTypeLeft){
            o_x = 0;
        }
        menuRect = CGRectMake(o_x, 74, DefaultMenuWidth, self.mMenuHeight*titles.count);
    }
    return self;
}

- (void)hiddenAction
{
    [self hiddenMenu:YES];
}

- (void)showMenu
{
    UIViewController *rootVC = [[[UIApplication sharedApplication]keyWindow]rootViewController];
    [rootVC.view addSubview:self];
    [self.mTableView reloadData];
    [UIView animateWithDuration:0.1f animations:^{
        _mTableView.frame = menuRect;
    } completion:^(BOOL finished) {
    }];
}

- (void)hiddenMenu:(BOOL)animated
{
    if (animated) {
        WS(weakSelf)
        [UIView animateWithDuration:0.1f animations:^{
            CGRect r = menuRect;
            r.size.height = 0;
            weakSelf.mTableView.frame = r;
        } completion:^(BOOL finished) {
            if (finished) {
                [weakSelf removeFromSuperview];
            }
        }];
    }else{
        [self removeFromSuperview];
    }
}

- (CGFloat)mMenuHeight
{
    CGFloat height = DefaultMenuHeight;
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForCell)]) {
        height = [self.delegate heightForCell];
    }
    return height;
}

- (UITableView *)mTableView
{
    if (!_mTableView) {
        
        menuRect.origin.y -= 10;
        menuRect.size.height += 10;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:menuRect];
        imageView.image = IMG(@"new_bounced");
        [self addSubview:imageView];
        
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(10, menuRect.size.height / 2 + 5, menuRect.size.width - 20, 1)];
        line.image = IMG(@"pop_Line");
        [imageView addSubview:line];
        
        
        menuRect.origin.y += 10;
        menuRect.size.height -= 10;
        CGRect r = menuRect;
        r.size.height = 0;
        _mTableView = [[UITableView alloc]initWithFrame:r];
        [_mTableView registerClass:[HFMenuCell class] forCellReuseIdentifier:@"HFMenuCell"];
        _mTableView.backgroundColor = [UIColor clearColor];
        _mTableView.bounces = NO;
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self addSubview:_mTableView];
    }
    return _mTableView;
}

#pragma mark table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFMenuCell" forIndexPath:indexPath];
    NSString *text = [titlesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MenuDidSelectIndex:)]) {
        [self.delegate MenuDidSelectIndex:indexPath.row];
    }
    
    [self hiddenMenu:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.mMenuHeight;
}

@end
