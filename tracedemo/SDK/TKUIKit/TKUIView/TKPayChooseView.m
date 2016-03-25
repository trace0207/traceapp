//
//  TKPayChooseView.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/24.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKPayChooseView.h"
#import "UIColor+TK_Color.h"
#import "UIView+Border.h"

#pragma mark - PayCell

@interface PayCell : UITableViewCell
@property (nonatomic, strong) UIImageView *payIcon;
@property (nonatomic, strong) UILabel *payName;
@property (nonatomic, strong) UIImageView *checkedImageView;
@end

@implementation PayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _payIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:_payIcon];
        [_payIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(self.contentView).with.offset(20);
            make.centerY.equalTo(self.contentView);
        }];
        
        _payName = [[UILabel alloc]init];
        _payName.font = [UIFont systemFontOfSize:14];
        _payName.textColor = [UIColor hexChangeFloat:TKColorBlack];
        [self.contentView addSubview:_payName];
        [_payName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.payIcon.mas_right).with.offset(10);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(self.payIcon.mas_centerY);
            make.width.mas_greaterThanOrEqualTo(0);
        }];
        
        _checkedImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_checkedImageView];
        [_checkedImageView setImage:IMG(@"unchecked")];
        [_checkedImageView setHighlightedImage:IMG(@"checked")];
        [_checkedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.equalTo(self.contentView).with.offset(-20);
            make.centerY.equalTo(self.payIcon.mas_centerY);
        }];
    }
    return self;
}

@end

#pragma mark - CellData
@interface CellData : NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) PayType payType;
@end
@implementation CellData
@end

#pragma mark - TKPayChooseView
@interface TKPayChooseView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contantView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *describleLabel;

@property (nonatomic, strong) NSMutableArray<__kindof CellData*> *payDataSource;
@property (nonatomic, assign) NSInteger currentRow;//当前选中的支付方式
@property (nonatomic, assign) PayType currentPayType;//当前选中的支付方式

@end

@implementation TKPayChooseView
- (instancetype)initWithPayType:(PayType)payType
{
    self = [super initWithFrame:kScreenBounds];
    if (self) {
        self.currentRow = 0;
        if ((payType & PayTypeApple)) {
            CellData *cellData = [[CellData alloc]init];
            cellData.imageName = @"icon_apple_pay";
            cellData.title = @"Apple Pay";
            cellData.payType = PayTypeApple;
            [self.payDataSource addObject:cellData];
        }
        if ((payType & PayTypeUnion)) {
            CellData *cellData = [[CellData alloc]init];
            cellData.imageName = @"icon_union_pay";
            cellData.title = @"银联支付";
            cellData.payType = PayTypeUnion;
            [self.payDataSource addObject:cellData];
        }
        if ((payType & PayTypeWeChat)) {
            CellData *cellData = [[CellData alloc]init];
            cellData.imageName = @"icon_weChat_pay";
            cellData.title = @"微信支付";
            cellData.payType = PayTypeWeChat;
            [self.payDataSource addObject:cellData];
        }
        if ((payType & PayTypeAlipay)) {
            CellData *cellData = [[CellData alloc]init];
            cellData.imageName = @"icon_alipay";
            cellData.title = @"支付宝支付";
            cellData.payType = PayTypeAlipay;
            [self.payDataSource addObject:cellData];
        }
        
        [self setViews];
        
        [self.tableView reloadData];
        
        
    }
    return self;
}

- (PayType)currentPayType
{
    CellData *data = [self.payDataSource objectAtIndex:self.currentRow];
    return data.payType;
}

- (void)setViews
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundView];
    [self addSubview:self.contantView];
    
    [self.contantView addSubview:self.titleLabel];
    [self.contantView addSubview:self.amountLabel];
    [self.contantView addSubview:self.describleLabel];
    [self.contantView addSubview:self.cancelButton];
    [self.contantView addSubview:self.payButton];
    [self.contantView addSubview:self.tableView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    CGFloat tableViewHeight = self.payDataSource.count * 44.0f;
    [self.contantView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(tableViewHeight+175);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.centerX.equalTo(self.contantView);
        make.top.equalTo(self.contantView).with.offset(20);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 20));
        make.centerX.equalTo(self.contantView);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
    }];
    
    [self.describleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contantView);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.amountLabel.mas_bottom).with.offset(10);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.equalTo(self.contantView).with.offset(20);
        make.right.equalTo(self.contantView).with.offset(-20);
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(self.contantView).with.offset(20);
        make.right.equalTo(self.contantView).with.offset(-20);
        make.bottom.equalTo(self.contantView).with.offset(-10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.describleLabel.mas_bottom).with.offset(20);
        make.left.equalTo(self.contantView.mas_left).with.offset(20);
        make.bottom.equalTo(self.payButton.mas_top).with.offset(-20);
        make.right.equalTo(self.contantView.mas_right).with.offset(-20);
    }];
}

- (NSMutableArray *)payDataSource
{
    if (_payDataSource == nil) {
        _payDataSource = [[NSMutableArray alloc]init];
    }
    return _payDataSource;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor hexChangeFloat:TKColorBlack];
        _titleLabel.text = @"付款信息";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _amountLabel;
}

-(UILabel *)describleLabel
{
    if (_describleLabel == nil) {
        _describleLabel = [[UILabel alloc]init];
        _describleLabel.font = [UIFont systemFontOfSize:12];
        _describleLabel.textAlignment = NSTextAlignmentCenter;
        _describleLabel.textColor = [UIColor lightGrayColor];
        _describleLabel.text = @"（预付款将打入平台帐户，不会直接打给买手）";
    }
    return _describleLabel;
}

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setBackgroundImage:IMG(@"pay_close") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)payButton
{
    if (_payButton == nil) {
        _payButton = [[UIButton alloc]init];
        [_payButton setBorderColor:[UIColor tkThemeColor1] borderWidth:1];
        [_payButton setTitle:@"确定并支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor hexChangeFloat:TKColorRed] forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.4f;
    }
    return _backgroundView;
}

- (UIView *)contantView
{
    if (_contantView == nil) {
        _contantView = [[UIView alloc]init];
        _contantView.backgroundColor = [UIColor whiteColor];
    }
    return _contantView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[PayCell class] forCellReuseIdentifier:@"PayCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [_tableView setTableFooterView:[UIView new]];
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
    return _tableView;
}

- (void)setMoney:(CGFloat)money
{
    _money = money;
    NSString *moneyString = [NSString stringWithFormat:@"金额：%0.2f元",money];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:moneyString];
    NSDictionary *attri1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor hexChangeFloat:TKColorBlack]};
    NSDictionary *attri2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor hexChangeFloat:TKColorRed]};
    [attributedStr addAttributes:attri1 range:NSMakeRange(0, 3)];
    [attributedStr addAttributes:attri2 range:NSMakeRange(3, moneyString.length - 3)];
    self.amountLabel.attributedText = attributedStr;
}

- (void)show
{
    self.backgroundView.hidden = YES;
    CGRect rect = self.frame;
    rect.origin.y = rect.size.height;
    self.frame = rect;
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = kScreenBounds;
    } completion:^(BOOL finished) {
        self.backgroundView.hidden = NO;
    }];
}

- (void)hidden
{
    self.backgroundView.hidden = YES;
    CGRect rect = self.frame;
    rect.origin.y = rect.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 去支付动作执行
//支付按钮
- (void)payAction:(UIButton *)btn
{
    [self hidden];
    //self.currentPayType
    //self.money
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.payDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell" forIndexPath:indexPath];
    CellData *cellData = [self.payDataSource objectAtIndex:indexPath.row];
    [cell.payIcon setImage:IMG(cellData.imageName)];
    cell.payName.text = cellData.title;
    if (self.currentRow == indexPath.row) {
        cell.checkedImageView.highlighted = YES;
    }else {
        cell.checkedImageView.highlighted = NO;
    }
    return cell;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentRow = indexPath.row;
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
