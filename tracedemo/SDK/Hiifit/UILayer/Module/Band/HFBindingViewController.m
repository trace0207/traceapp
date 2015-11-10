//
//  HFBindingViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/9/7.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "HFBindingViewController.h"
#import "HFDevInfoViewController.h"
#import "BandCenter.h"
#import "MyInfoCell.h"
#import "UIImage+Scale.h"
#import "GlobNotifyDefine.h"

@interface HFBindingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIActivityIndicatorView *indicator;
    
    MBProgressHUD * Hud;
}

@property (nonatomic, strong) NSMutableArray *devices;
//@property (nonatomic, strong) BandCenter *bandCenter;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation HFBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.mTableView.backgroundColor = RGBA(234, 234, 234, 1);
    [self addNavigationTitle:@"绑定手环"];
    _devices = [[NSMutableArray alloc]init];
    [self.searchBtn setBackgroundImage:[UIImage scaleWithImage:@"My_bigButton"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    WS(weakSelf)
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIKitTool getAppdelegate].window animated:YES];
    
    [[BandCenter shareInstance] getBlueTooth:^(BOOL success)
     {
         [hud hide:YES];
         if (success)
         {
             [weakSelf startBandSearch];
         }
         else
         {
             //            HFAlertView * alert = [HFAlertView initWithTitle:nil withMessage:@"请先打开蓝牙，开启蓝牙后，才能正常使用手环计步功能" commpleteBlock:^(NSInteger buttonIndex) {
             //            } cancelTitle:nil determineTitle:@"取消"];
             //            [alert show];
         }
     }];
}



- (void)hideBand
{
    if (Hud)
    {
        [Hud hide:YES];
        Hud = nil;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInfoCell" owner:self options:nil]firstObject];
    }
    if (indexPath.row < [_devices count])
    {
        CBPeripheral * band = [_devices objectAtIndex:indexPath.row];
        [cell.image setImage:IMG(@"band_icon")];
        
        if (band.name == nil || [band.name isEqualToString:@""])
        {
            cell.titleLabel.text = @"未知设备";
        }
        else
        {
            cell.titleLabel.text = band.name;
        }
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral * band = [_devices objectAtIndex:indexPath.row];
    WS(weakSelf)
    
    if (!Hud)
    {
        Hud = [MBProgressHUD showMessag:@"绑定中..." toView:nil];
    }
    
    [self performSelector:@selector(hideBand) withObject:nil afterDelay:30.0];
    
    [[BandCenter shareInstance] bindBand:band finish:^{
        
        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(hideBand) object:nil];
        
        [Hud hide:YES];
        Hud = nil;
        
        for (UIViewController * obj in weakSelf.navigationController.viewControllers)
        {
            if ([obj isKindOfClass:[HFDevInfoViewController class]])
            {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KBindBandNotication object:nil];
                HFDevInfoViewController * devInfo = (HFDevInfoViewController *)obj
                ;
                [weakSelf.navigationController popToViewController:devInfo animated:YES];
                break;
            }
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

#pragma mark -
#pragma mark private
- (void)stopBandSearch
{
    [indicator stopAnimating];
    self.searchBtn.enabled = YES;
}

- (void)startBandSearch
{
    [self.devices removeAllObjects];
    [self.mTableView reloadData];
    
    [indicator startAnimating];
    self.searchBtn.enabled = NO;
    
    WS(weakSelf)
    [[BandCenter shareInstance] searchDevice:^(NSArray *devices) {
        [weakSelf.devices removeAllObjects];
        [weakSelf.devices addObjectsFromArray:devices];
        [weakSelf.mTableView reloadData];
    } andStop:^{
        [weakSelf stopBandSearch];
    }];
}


#pragma mark -
#pragma mark getter

//- (BandCenter *)bandCenter
//{
//    if (!_bandCenter)
//    {
//        _bandCenter = [[BandCenter alloc] init];
//    }
//    return _bandCenter;
//}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = RGBA(234, 234, 234, 1);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 40)];
        label.text = @"附近的手环";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor hexChangeFloat:@"666666" withAlpha:1];
        
        [_headerView addSubview:label];
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(87, 16, 10, 10);
        [_headerView addSubview:indicator];
    }
    return _headerView;
}

- (IBAction)searchAction:(id)sender {
    [self startBandSearch];
}
@end
