//
//  Menu.m
//  menu
//
//  Created by zhuxiaoxia on 15/8/31.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFMenuControl.h"
#import "HFMenuCell.h"
#import "UIImage+Scale.h"
#import "Masonry.h"
#import "UIColor+TK_Color.h"

CGFloat const DefaultMenuWidth = 140;
CGFloat const DefaultMenuHeight = 44;

@interface HFMenuControl ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *titlesArray;
    CGRect menuRect;
    NSInteger currentSelect; // 当前选中的类目
}

@property (strong, nonatomic) UITableView *mTableView;
@property (assign, nonatomic) CGFloat mMenuHeight;

@end

@implementation HFMenuControl
- (instancetype)initWithCategorys:(NSMutableArray *)categorys
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    currentSelect = 0;
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        titlesArray = [categorys copy];
        UIButton *hiddenBtn = [[UIButton alloc]initWithFrame:self.frame];
        [hiddenBtn addTarget:self action:@selector(hiddenAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hiddenBtn];
        CGFloat o_x = CGRectGetWidth(self.frame)-DefaultMenuWidth - 6;
        menuRect = CGRectMake(o_x, 74, DefaultMenuWidth, self.mMenuHeight*categorys.count);
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
        imageView.image = [UIImage scaleWithImage:@"new_bounced"];
        [self addSubview:imageView];
        
//        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(10, menuRect.size.height / 2 + 5, menuRect.size.width - 20, 1)];
//        line.image = IMG(@"pop_Line");
//        [imageView addSubview:line];
        
        
        menuRect.origin.y += 10;
        menuRect.size.height -= 10;
        CGRect r = menuRect;
        r.size.height = 0;

        _mTableView = [[UITableView alloc]initWithFrame:r];
//        [_mTableView registerClass:[HFMenuCell class] forCellReuseIdentifier:@"HFMenuCell"];
        _mTableView.backgroundColor = [UIColor clearColor];
        _mTableView.bounces = NO;
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
//        _mTableView.alpha = 1.0;
//        [_mTableView setSeparatorColor:[UIColor whiteColor]];
//        [_mTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        _mTableView.separatorStyle =  UITableViewCellSelectionStyleNone;
//        self.alpha = 1.0;
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
//    HFMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFMenuCell" forIndexPath:indexPath];
    HFMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HFMenuCell"];
    UILabel * lable;
    if(cell){
    
        lable = [cell viewWithTag:200];
        
    }else{
    
        cell = [[HFMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HFMenuCell"];
        lable = [[UILabel alloc] init];
        [cell addSubview:lable];
        [lable setTag:200];
        lable.textAlignment = NSTextAlignmentCenter;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo (cell);
            make.size.equalTo(cell);
            
        }];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if(currentSelect == indexPath.row){
    
        lable.textColor = [UIColor TKcolorWithHexString:TK_Color_nav_textActive];
    }else{
    
//        lable.textColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        lable.textColor = [UIColor whiteColor];
    }
    
    TK_ShareCategory * category = [titlesArray objectAtIndex:indexPath.row];
    NSString *text = category.title;
    lable.text = text;
            //    cell.sbu electionStyle = UITableViewCellSelectionStyleNone;
    cell.alpha = 1.0;
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MenuDidSelectIndex:)]) {
        [self.delegate MenuDidSelectIndex:indexPath.row];
        currentSelect = indexPath.row;
    }
    
    [self hiddenMenu:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.mMenuHeight;
}

@end
