//
//  TKEditUserInfoVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/10.
//  Copyright © 2015年 trace. All rights reserved.
//
#import "HFEditInfoCell.h"
#import "ZHPickView.h"
#import "HFEditHeaderView.h"
#import "ModifySignatureController.h"
#import "HFBindPhoneNumViewController.h"
#import "HFModifyInfoReq.h"
#import "NSString+Message.h"
#import "TKUserCenter.h"

#define KEY_DES     @"description"
#define KEY_TYPE    @"type"
#import "TKEditUserInfoVC.h"
#import "TK_SettingCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "TKPicSelectTool.h"

@interface TKEditUserInfoVC ()<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate, UITextFieldDelegate, ModifySignatureControllerDelegate,TKPicSelectDelegate>
{

    TKUser * user;
    TK_SettingCell * headView;
    UIImageView * headImageView;
    TKPicSelectTool * tool;
}

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) HFEditHeaderView * headerView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) HFModifyInfoReq * req;
@property (nonatomic, strong) UITextField * textField;//定义一个全局变量。方便控制键盘收缩

@end


@implementation TKEditUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"个人资料";
    [self initDefaultUIData];
    [self.view addSubview:self.tableView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self TKI_setBarRightDefaultText:@"保存"];
}



#pragma mark -- tk_new_begin


-(TK_SettingCell *)getHeadView
{
    if(!headView)
    {
        headView = [TK_SettingCell loadRightImageViewType:self];
    }
    UILabel * text =  [headView viewWithTag:kLeftLabelTag];
    text.text = @"头像";
    UIImageView * imageView = [headView viewWithTag:kRightImageViewTag];
    imageView.backgroundColor = [UIColor whiteColor];
    headImageView = imageView;
    [imageView  sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]]
                  placeholderImage:[UIImage imageNamed:@"head_default"]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    return  headView;
}

/**
 查看大图
 **/
-(void)showBigImage:(UITapGestureRecognizer *)tap{

    // 大图 的 url 需要转换一下
    NSString * rawPicUrl = [UIKitTool getRawImage:user.headPortraitUrl];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.srcImageView = (UIImageView *)tap.view;
    photo.url = [NSURL URLWithString:rawPicUrl];
    browser.photos = [NSArray arrayWithObjects:photo,nil];
    [browser show];
}


- (void)initDefaultUIData
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"昵称" forKey:KEY_TXT];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"神器账号" forKey:KEY_TXT];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"手机号码" forKey:KEY_TXT];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"通讯地址" forKey:KEY_TXT];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"性别" forKey:KEY_TXT];
    
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setObject:@"个性签名" forKey:KEY_TXT];
    
    
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary]; // 头像
    
    _dataSource = [[NSMutableArray alloc] initWithObjects:dic7,dic1,dic2,dic3,dic4,dic5,dic6, nil];
    user  = [[TKUserCenter instance]getUser];
}


-(NSString *)getLebelTextFromUser:(NSInteger)row
{
    
    NSString * str = @"";
    switch (row) {
        case 1:
            str = user.nickName;
            break;
        case 2:
            str = user.mobile;
            break;
        case 3:
            str = user.mobile;
            break;
        case 4:
            str = user.address;
            break;
        case 5:
            str = user.sex == 0?@"男":@"女";
            break;
        case 6:
            str = user.signature;
            break;
        default:
            break;
    }
    return str;
}


#pragma mark  cellEvent 


-(void)onImageSelect:(UIImage *)image
{

    [headImageView setImage:image];
}

-(void)doSelectImage
{
    if(!tool)
    {
        tool = [[TKPicSelectTool alloc] init];
    }
    tool.viewController = self;
    tool.selectDelegate = self;
    [tool doSelectPic:@"选择头像" clipping:YES maxSelect:1];
}



-(void)dealloc
{
    tool = nil;
}

#pragma mark --- tk_new_end





#pragma mark - privateFunction



- (BOOL)checkText:(UITextField *)textField
{
    NSString *str = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length == 0) {
        HFAlertView *atler = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"昵称不能为空！" commpleteBlock:^(NSInteger buttonIndex) {
            [textField becomeFirstResponder];
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [atler show];
        return NO;
    }
    return YES;
}
#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return [self getHeadView];
    }
    static NSString *identifier = @"TKSettingTableCell";
    TK_SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [TK_SettingCell loadDefaultTextType:self];
    }
    NSMutableDictionary * dic =  [self.dataSource objectAtIndex:indexPath.row];
    UILabel * label =  [cell viewWithTag:kLeftLabelTag];
    label.text = [dic objectForKey:KEY_TXT];
    
    UILabel * label1 = [cell viewWithTag:kRightLabelTag];
    label1.text = [self getLebelTextFromUser:indexPath.row];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if(indexPath.row == 0)
    {
    
        [self doSelectImage];
        return;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - HFEditInfoCellDelegate
#pragma mark - ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString cell:(HFEditInfoCell *)cell
{
    cell.descriptionLabel.text = resultString;
    if (pickView.pickerStyle == HF_Weight) {
        self.req.weight = [[resultString stringByReplacingOccurrencesOfString:@"kg" withString:@""] floatValue];
    }
    if (pickView.pickerStyle == HF_Height) {
        self.req.height = [[resultString stringByReplacingOccurrencesOfString:@"cm" withString:@""] floatValue];
    }
    if (pickView.pickerStyle == HF_BirthDay) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年M月d日";
        NSDate *date = [formatter dateFromString:resultString];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth;
        NSDateComponents *dateComponent = [gregorian components:unitFlags fromDate:date];
        
        self.req.year = [NSString stringWithFormat:@"%@",@([dateComponent year])];
        self.req.month = [NSString stringWithFormat:@"%@",@([dateComponent month])];
        self.req.day = [NSString stringWithFormat:@"%@",@([dateComponent day])];
        
    }
}
#pragma mark - HFEditHeaderDelegate

- (void)chooseGirl
{
    self.req.sex = 1;
    [self.headerView changeUserSex:NO];
}
- (void)chooseBoy
{
    self.req.sex = 0;
    [self.headerView changeUserSex:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 8) {
        textField.text = [textField.text substringToIndex:8];
        self.req.nickName = textField.text;
    }else{
        self.req.nickName = textField.text;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![[textField textInputMode] primaryLanguage]) {
        return NO;
    }
    return YES;
}
#pragma mark - Notification
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField.text.length > 1) {
//        NSString * lastStr = [textField.text substringFromIndex:textField.text.length - 1];
//        if ([NSString isContainsEmoji:lastStr]) {
//            NSLog(@"1");
//        }
//    }
//    if (textField.text.length > 8) {
//        textField.text = [textField.text substringToIndex:8];
//        [textField resignFirstResponder];
//    }
//    self.req.nickName = textField.text;
//}

#pragma mark - ModifySignatureControllerDelegate
- (void)finishModify
{
//    [self initData];
}
#pragma mark - lazyLoading
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (HFModifyInfoReq *)req
{
    if (!_req) {
        _req = [[HFModifyInfoReq alloc] init];
    }
    return _req;
}

@end



