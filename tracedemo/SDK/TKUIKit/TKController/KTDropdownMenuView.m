//
//  KTDropdownMenuView.m
//  KTDropdownMenuViewDemo
//
//  Created by tujinqiu on 15/10/12.
//  Copyright © 2015年 tujinqiu. All rights reserved.
//

#import "KTDropdownMenuView.h"
#import <Masonry.h>
#import "UIImage+Scale.h"
#import "UIColor+TK_Color.h"

@interface KTDropdownMenuView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, assign) BOOL isMenuShow;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *hiddenBtn;
@property (nonatomic, strong) UIView *wrapperView;
@property (nonatomic, strong) UIView *line;

@end

@implementation KTDropdownMenuView

#pragma mark -- life cycle --

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame])
    {
        _width = 0.0;
        _animationDuration = 0.4;
        _backgroundAlpha = 0.3;
        _edgesTop = 10;
        _cellHeight = 44;
        _isMenuShow = NO;
        _selectedIndex = 0;
        _titles = titles;
        
        [self addSubview:self.titleButton];
        [self addSubview:self.arrowImageView];
        [self.wrapperView addSubview:self.backgroundView];
        [self.wrapperView addSubview:self.hiddenBtn];
        [self.wrapperView addSubview:self.tableViewBackgroundImageView];
        [self.wrapperView addSubview:self.tableView];
        
        // 添加KVO监听tableView的contenOffset属性，添加上滑返回功能
//        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
    
    return self;
}

- (void)setShowLine:(BOOL)showLine
{
    if (showLine) {
        [self addSubview:self.line];
    }else
    {
        if (_line) {
            [_line removeFromSuperview];
        }
    }
    _showLine = showLine;
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (self.window)
    {
        [self.window addSubview:self.wrapperView];
        
        [self.titleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        if (self.showLine) {
            [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(1, 15));
                make.centerY.equalTo(self.titleButton);
                make.right.equalTo(self.titleButton.mas_left).with.offset(-5);
            }];
        }
        [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleButton.mas_right).offset(0);
            make.centerY.equalTo(self.titleButton.mas_centerY);
        }];
        // 依附于导航栏下面
        [self.wrapperView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.window);
            //make.top.equalTo(self.superview.mas_bottom);
        }];
        [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.wrapperView);
        }];
        [self.hiddenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.wrapperView);
        }];
        CGFloat tableCellsHeight = _cellHeight * _titles.count;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.titleButton.mas_centerX).with.offset(self.edgesRight);
            if (self.width > 79.99999)
            {
                make.width.mas_equalTo(self.width);
            }
            else
            {
                make.width.equalTo(self.wrapperView.mas_width);
            }
            make.top.equalTo(self.titleButton.mas_bottom).with.offset(self.edgesTop);
            make.height.mas_equalTo(tableCellsHeight);
//            make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + kKTDropdownMenuViewHeaderHeight);
        }];
        [self.tableViewBackgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.tableView);
            make.top.equalTo(self.titleButton.mas_bottom);
        }];
        self.wrapperView.hidden = YES;
    }
    else
    {
        // 避免不能销毁的问题
        [self.wrapperView removeFromSuperview];
    }
}

//- (void)dealloc
//{
//    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
//}

#pragma mark -- KVO --

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    // 遇到这些情况就直接返回
//    if (!self.userInteractionEnabled || !self.isMenuShow)
//        return;
//    
//    // 这个就算看不见也需要处理
//    if ([keyPath isEqualToString:@"contentOffset"])
//    {
//        CGPoint newOffset = [[change valueForKey:@"new"] CGPointValue];
//        if (newOffset.y > kKTDropdownMenuViewAutoHideHeight)
//        {
//            self.isMenuShow = !self.isMenuShow;
//        }
//    }
//}

#pragma mark -- UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    if (self.selectedIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.tintColor = self.cellAccessoryCheckmarkColor;
    cell.backgroundColor = self.cellColor;
    cell.textLabel.font = self.textFont;
    cell.textLabel.textColor = self.textColor;
    
    return cell;
}

#pragma mark -- UITableViewDelegate --

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedAtIndex)
    {
        self.selectedAtIndex((int)indexPath.row);
    }
}

#pragma mark -- handle actions --

- (void)handleTapOnTitleButton:(UIButton *)button
{
    self.isMenuShow = !self.isMenuShow;
}

- (void)orientChange:(NSNotification *)notif
{
    NSLog(@"change orientation");
}

#pragma mark -- helper methods --

- (void)showMenu
{
    self.titleButton.enabled = NO;
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kKTDropdownMenuViewHeaderHeight)];
    //headerView.backgroundColor = self.cellColor;
    //self.tableView.tableHeaderView = headerView;
    [self.tableView layoutIfNeeded];
    
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.wrapperView.mas_top).offset(-kKTDropdownMenuViewHeaderHeight);
//        //make.bottom.equalTo(self.wrapperView.mas_bottom).offset(kKTDropdownMenuViewHeaderHeight);
//    }];
    self.wrapperView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    
    
    self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
    self.backgroundView.alpha = self.backgroundAlpha;
    self.titleButton.enabled = YES;
    
//    [UIView animateWithDuration:self.animationDuration
//                     animations:^{
//                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
//                     }];
//    
//    [UIView animateWithDuration:self.animationDuration * 1.5
//                          delay:0
//         usingSpringWithDamping:0.7
//          initialSpringVelocity:0.5
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         [self.tableView layoutIfNeeded];
//                         self.backgroundView.alpha = self.backgroundAlpha;
//                         self.titleButton.enabled = YES;
//                     } completion:nil];
}

- (void)hideMenu
{
    self.titleButton.enabled = NO;
   // CGFloat tableCellsHeight = _cellHeight * _titles.count;
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - kKTDropdownMenuViewHeaderHeight);
////        make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + kKTDropdownMenuViewHeaderHeight);
//    }];
    self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
    self.backgroundView.alpha = 0.0;
    self.wrapperView.hidden = YES;
    [self.tableView reloadData];
    self.titleButton.enabled = YES;
    
//    
//    [UIView animateWithDuration:self.animationDuration
//                     animations:^{
//                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
//                     }];
//    
//    [UIView animateWithDuration:self.animationDuration * 1.5
//                          delay:0
//         usingSpringWithDamping:0.7
//          initialSpringVelocity:0.5
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         [self.tableView layoutIfNeeded];
//                         self.backgroundView.alpha = 0.0;
//                     } completion:^(BOOL finished) {
//                         self.wrapperView.hidden = YES;
//                         [self.tableView reloadData];
//                         self.titleButton.enabled = YES;
//                     }];
}

#pragma mark -- getter and setter --

- (UIColor *)cellColor
{
    if (!_cellColor)
    {
        _cellColor = [UIColor colorWithRed:0.296 green:0.613 blue:1.000 alpha:1.000];
    }
    
    return _cellColor;
}

@synthesize cellSeparatorColor = _cellSeparatorColor;
- (UIColor *)cellSeparatorColor
{
    if (!_cellSeparatorColor)
    {
        _cellSeparatorColor = [UIColor lightGrayColor];
    }
    
    return _cellSeparatorColor;
}

- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor
{
    if (_tableView)
    {
        _tableView.separatorColor = cellSeparatorColor;
    }
    _cellSeparatorColor = cellSeparatorColor;
}

- (UIColor *)cellAccessoryCheckmarkColor
{
    if (!_cellAccessoryCheckmarkColor)
    {
        _cellAccessoryCheckmarkColor = [UIColor whiteColor];
    }
    
    return _cellAccessoryCheckmarkColor;
}


@synthesize textColor = _textColor;
- (UIColor *)textColor
{
    if (!_textColor)
    {
        _textColor = [UIColor whiteColor];
    }
    
    return _textColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    if (_titleButton)
    {
        [_titleButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    _textColor = textColor;
}

@synthesize textFont = _textFont;
- (UIFont *)textFont
{
    if(!_textFont)
    {
        _textFont = [UIFont systemFontOfSize:17];
    }
    
    return _textFont;
}

- (void)setTextFont:(UIFont *)textFont
{
    if (_titleButton)
    {
        [_titleButton.titleLabel setFont:textFont];;
    }
    _textFont = textFont;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor tkThemeColor1];
    }
    return _line;
}

- (UIButton *)titleButton
{
    if (!_titleButton)
    {
        _titleButton = [[UIButton alloc] init];
        _titleButton.backgroundColor = [UIColor clearColor];
        [_titleButton setTitle:[self.titles objectAtIndex:0] forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(handleTapOnTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton.titleLabel setFont:self.textFont];
        [_titleButton setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    
    return _titleButton;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView)
    {
        UIImage *image = [UIImage imageNamed:@"arrow_down_icon"];
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
    }
    
    return _arrowImageView;
}

- (UIImageView *)tableViewBackgroundImageView
{
    if (!_tableViewBackgroundImageView)
    {
        UIImage *image = [UIImage scaleWithImage:@"menu_bg"];
        
        _tableViewBackgroundImageView = [[UIImageView alloc] initWithImage:image];
    }
    
    return _tableViewBackgroundImageView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = self.cellSeparatorColor;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    }
    
    return _tableView;
}

- (UIView *)wrapperView
{
    if (!_wrapperView)
    {
        _wrapperView = [[UIView alloc] init];
        _wrapperView.clipsToBounds = YES;
    }
    
    return _wrapperView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = self.backgroundAlpha;
    }
    
    return _backgroundView;
}

- (UIButton *)hiddenBtn
{
    if (!_hiddenBtn)
    {
        _hiddenBtn = [[UIButton alloc] init];
        _hiddenBtn.backgroundColor = [UIColor clearColor];
        [_hiddenBtn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _hiddenBtn;
}

- (void)setIsMenuShow:(BOOL)isMenuShow
{
    if (_isMenuShow != isMenuShow)
    {
        _isMenuShow = isMenuShow;
        
        if (isMenuShow)
        {
            [self showMenu];
        }
        else
        {
            [self hideMenu];
        }
    }
}

- (void)hiddenView
{
    self.isMenuShow = NO;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        [_titleButton setTitle:[_titles objectAtIndex:selectedIndex] forState:UIControlStateNormal];
    }
    
    self.isMenuShow = NO;
}

- (void)setWidth:(CGFloat)width
{
    if (width < 80.0)
    {
        NSLog(@"width should be set larger than 80, otherwise it will be set to be equal to window width");
        
        return;
    }
    
    _width = width;
}

@end
