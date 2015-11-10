//
//  HFActionSheet.m
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/16.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import "HFActionSheet.h"

#define kCellHeight 49
@interface HFActionSheet()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * superView1;
@property (nonatomic, strong) NSMutableArray * titleArray;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIButton * cancleButton;
@end
@implementation HFActionSheet

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UIView * bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.5;
        [self addSubview:bgView];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroud)];
        [bgView addGestureRecognizer:tapGesture];
        
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        self.hidden = YES;
    }
    return self;
}

- (void)showInSuperView:(UIView *)superView cancelButton:(NSString *)cancel otherButton:(NSString *)title,... NS_REQUIRES_NIL_TERMINATION;
{
    va_list args;
    va_start(args, title);
    
    [self.titleArray addObject:title];
    
    if (title)
    {
        NSString *otherTitle;
        while ((otherTitle = va_arg(args, NSString *)))
        {
            //依次取得所有参数
            [self.titleArray addObject:otherTitle];
        }
    }
    va_end(args);
    
    [self showInSuperView:superView];
}

- (void)showInSuperView:(UIView *)superView
{
    
    self.hidden = NO;
    self.superView1 = superView;

    self.bgView.frame = CGRectMake(0, self.frame.size.height, kScreenWidth, kCellHeight * (self.titleArray.count + 1) + 5);
    [self addSubview:self.bgView];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.titleArray.count * kCellHeight);
    [self.bgView addSubview:self.tableView];
    
    self.cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame) + 5, kScreenWidth, kCellHeight);
    [self.bgView addSubview:self.cancleButton];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.superView1.frame.size.height - self.bgView.frame.size.height, kScreenWidth, self.bgView.frame.size.height);
    }];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, kScreenWidth, 1)];
        lineView.backgroundColor = [UIColor HFColorStyle_6];
        [cell.contentView addSubview:lineView];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
        titleLabel.center = CGPointMake(kScreenWidth / 2, 25);
        titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.superView1.frame.size.height, kScreenWidth, self.bgView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
            self.bgView = nil;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
                [self.delegate didSelectItemAtIndex:indexPath.row];
            }
        }
    }];
}
- (void)cancleBgView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0, self.superView1.frame.size.height, kScreenWidth, self.bgView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
            self.bgView = nil;
        }
    }];
}
- (void)tapBackgroud
{
    [self cancleBgView];
}
#pragma mark - LazyLoading
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _tableView;
}
- (UIButton *)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleBgView) forControlEvents:UIControlEventTouchUpInside];
        _cancleButton.backgroundColor = [UIColor whiteColor];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_cancleButton];
    }
    return _cancleButton;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1];
     
    }
    return _bgView;
}

#pragma mark -
#pragma makr Getter
- (NSMutableArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
