//
//  TKAboutUsViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/11.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKAboutUsViewController.h"

#define WEBURL @"webUrl"
#import "TK_SettingCell.h"
#import "WebViewController.h"
#import "UIColor+TK_Color.h"




@interface TKAboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray * dataSource;
    UITableView * mTableView;
    
}


@end

@implementation TKAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"关于我们";
    
    [self initData];
    mTableView = [[UITableView alloc] initWithFrame:TKMainViewFream style:UITableViewStyleGrouped];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
    
}




-(void)initData
{
    NSMutableDictionary *dic00 = [NSMutableDictionary dictionary];
    NSMutableDictionary * dic01 = [NSMutableDictionary dictionary];
    [dic01 setObject:@"功能介绍" forKey:KEY_TXT];
    [dic01 setObject:@"http://www.baidu.com" forKey:WEBURL];
    
    
    NSMutableDictionary * dic02 = [NSMutableDictionary dictionary];
    [dic02 setObject:@"官方网站" forKey:KEY_TXT];
    [dic02 setObject:@"http://www.baidu.com" forKey:WEBURL];
    
    NSMutableDictionary * dic03 = [NSMutableDictionary dictionary];
    [dic03 setObject:@"软件许可协议" forKey:KEY_TXT];
    [dic03 setObject:@"http://www.baidu.com" forKey:WEBURL];
    dataSource = [[NSMutableArray alloc] initWithObjects:dic00,dic01,dic02,dic03 ,nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        UITableViewCell * tvCell = [self getAppInfoCell];
        tvCell.selectionStyle = NO;
        return tvCell;
        
    }else
    {
        TK_SettingCell * cell = [TK_SettingCell loadDefaultTextType:self];
        NSMutableDictionary * dic = [dataSource objectAtIndex:indexPath.row];
        cell.leftLabel.text = [dic objectForKey:KEY_TXT];
        cell.rightLabel.hidden = YES;
        return cell;
    }
}


-(UITableViewCell *)getAppInfoCell
{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [cell addSubview:imageView];
    
    imageView.backgroundColor = [UIColor redColor];
    
    imageView.image = IMG(@"tk_image_appicon");
    
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.center.equalTo(cell);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        [imageView.layer setCornerRadius:10.0f];
        [imageView.layer setMasksToBounds:YES];
        
    }];
    
    UILabel * versionText = [[UILabel alloc] init];
    
    versionText.textAlignment =  NSTextAlignmentCenter;
    
    versionText.text = [@"神器 V_"  stringByAppendingString:[[HFDeviceInfo shareInstance] getAppVersion]];
    
    versionText.textColor = [UIColor tkMainTextColorForDefaultBg];
    
    [cell addSubview:versionText];
    
    [versionText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(cell);
        make.centerY.equalTo(cell).with.offset(50 + 25);
        make.width.equalTo(cell);
        make.height.mas_equalTo(25);
        
    }];
    
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row !=0)
    {
        WebViewController * webVC = [[WebViewController alloc] init];
        NSString * url = [[dataSource objectAtIndex:indexPath.row] objectForKey:WEBURL];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:url, kParamURL, nil];
        webVC.param = dic;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return  250;
    
    }else
    {
        return 40;
    }
}

@end
