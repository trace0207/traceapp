//
//  DemoVC11.m
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/2/17.
//  Copyright © 2016年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 *                                                                                *
 * 在您使用此自动布局库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并  *
 * 帮您解决问题。                                                                    *
 * 持续更新地址: https://github.com/gsdios/SDAutoLayout                              *
 * Email : gsdios@126.com                                                          *
 * GitHub: https://github.com/gsdios                                               *
 * 新浪微博:GSD_iOS                                                                 *
 * QQ交流群：519489682（已满）497140713                                              *
 *********************************************************************************
 
 */




#import "TKChatViewController.h"

//#import "GlobalDefines.h"
#import "UIView+Border.h"
#import "UIColor+TK_Color.h"
#import "SDChatTableViewCell.h"
#import "SDAnalogDataGenerator.h"
//#import "SDWebViewController.h"

#import "UITableView+SDAutoTableViewCellHeight.h"

#import "UIView+SDAutoLayout.h"

#define kChatTableViewControllerCellId @"ChatTableViewController"

@interface TKChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *keyboardView;
@property (nonatomic, strong) UITextField *textFeild;
@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation TKChatViewController

- (UIView *)keyboardView
{
    if (nil == _keyboardView) {
        _keyboardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:IMG(@"input-bar-flat")];
        [_keyboardView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _keyboardView;
}

- (UITextField *)textFeild
{
    if (nil == _textFeild) {
        _textFeild = [[UITextField alloc]init];
        _textFeild.placeholder = @"输入信息...";
        _textFeild.borderStyle = UITextBorderStyleRoundedRect;
        _textFeild.returnKeyType = UIReturnKeyDone;
        _textFeild.delegate = self;
    }
    return _textFeild;
}

- (UIButton *)sendButton
{
    if (nil == _sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton addTarget:self action:@selector(sendMessageAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
        [_sendButton setDefaultBorder];
    }
    return _sendButton;
}

- (void)sendMessageAction:(UIButton *)button
{
    [self.textFeild resignFirstResponder];
    if (self.textFeild.text.length == 0) {
        return;
    }
    NSString *message = self.textFeild.text;
    self.textFeild.text = nil;
    //todo 发送message
    SDChatModel *model = [[SDChatModel alloc]init];
    model.messageType = SDMessageTypeSendToOthers;
    model.text = message;
    model.iconName = @"2.jpg";
    [self.dataArray addObject:model];
    [self.tableView reloadData];
//    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height) animated:YES];
}

/**
 显示聊天窗口
 **/
+(void)showChatView:(NSString *)toId toUserRole:(NSInteger)toUserRole
{
    TKChatViewController * vc = [[TKChatViewController alloc] init];
    vc.toId = toId;
    vc.toUserRole = toUserRole;
    [[AppDelegate getMainNavigation] pushViewController:vc animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"会话";
    [self setupDataWithCount:30];
    
    CGFloat rgb = 240;
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    self.tableView.backgroundColor = RGBA(rgb, rgb, rgb, 1);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SDChatTableViewCell class] forCellReuseIdentifier:kChatTableViewControllerCellId];
    [self.view addSubview:self.keyboardView];
    [self.keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    [self.keyboardView addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.keyboardView);
        make.right.equalTo(self.keyboardView).with.offset(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [self.keyboardView addSubview:self.textFeild];
    [self.textFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.keyboardView).with.offset(8);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.keyboardView);
        make.right.equalTo(self.sendButton.mas_left).with.offset(-8);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyBoardRect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)setupDataWithCount:(NSInteger)count
{
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray new];
    }
    for (int i = 0; i < count; i++) {
        SDChatModel *model = [[SDChatModel alloc]init];
        model.messageType = arc4random_uniform(2);
        if (model.messageType) {
            model.iconName = @"1.jpg";
        } else {
            model.iconName = @"2.jpg";
        }
        model.text = [SDAnalogDataGenerator randomMessage];
        [self.dataArray addObject:model];
    }
}

#pragma mark - tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChatTableViewControllerCellId];
    cell.model = self.dataArray[indexPath.row];
    
    //__weak typeof(self) weakSelf = self;
    [cell setDidSelectLinkTextOperationBlock:^(NSString *link, MLEmojiLabelLinkType type) {
        if (type == MLEmojiLabelLinkTypeURL) {
//            [weakSelf.navigationController pushViewController:[SDWebViewController webViewControllerWithUrlString:link] animated:YES];
        }
    }];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model" cellClass:[SDChatTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>>>>  %@", [self.dataArray[indexPath.row] text]);
}

#pragma mark - text feild delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
