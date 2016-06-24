//
//  TKCountrySelectVC.m
//  tracedemo
//
//  Created by 罗田佳 on 16/6/13.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKCountrySelectVC.h"
#import "TKTableViewVM.h"




@interface CountryRowData:TKTableViewRowM
@property (nonatomic,strong) NSString * countryLabel;
@property (nonatomic,strong) NSString * countryCode;
@end

@implementation CountryRowData

@end



@interface CountrySelectVM : TKTableViewVM
@property (nonatomic,weak) TKCountrySelectVC * vc;
@end

@implementation CountrySelectVM



-(void)tkLoadDefaultData
{
    [self.defaultSection.rowsData removeAllObjects];
    CountryRowData * row0 = [[CountryRowData alloc] init];
    row0.countryLabel = @"中国";
    row0.countryCode = @"86";
    CountryRowData * row1 = [[CountryRowData alloc] init];
    row1.countryLabel = @"中国香港";
    row1.countryCode = @"852";
    CountryRowData * row2 = [[CountryRowData alloc] init];
    row2.countryLabel = @"意大利";
    row2.countryCode = @"39";
    CountryRowData * row3 = [[CountryRowData alloc] init];
    row3.countryLabel = @"英国";
    row3.countryCode = @"44";
    CountryRowData * row4 = [[CountryRowData alloc] init];
    row4.countryLabel = @"西班牙";
    row4.countryCode = @"34";
    CountryRowData * row5 = [[CountryRowData alloc] init];
    row5.countryLabel = @"法国";
    row5.countryCode = @"33";
    CountryRowData * row6 = [[CountryRowData alloc] init];
    row6.countryLabel = @"德国";
    row6.countryCode = @"49";
 
   
    [self.defaultSection.rowsData addObject:row0];
    [self.defaultSection.rowsData addObject:row1];
    [self.defaultSection.rowsData addObject:row2];
    [self.defaultSection.rowsData addObject:row3];
    [self.defaultSection.rowsData addObject:row4];
    [self.defaultSection.rowsData addObject:row5];
    [self.defaultSection.rowsData addObject:row6];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    CountryRowData * data = [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    
    [self.vc onCountrySelect:data.countryLabel countryCode:data.countryCode];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_SettingCell * cell = [TK_SettingCell loadLeftAndRightLabelType:self];
    CountryRowData * data =  [self.defaultSection.rowsData objectAtIndex:indexPath.row];
    cell.label1.text = data.countryLabel;
    cell.label2.text = data.countryCode;
    return cell;
}





@end


@interface TKCountrySelectVC ()
{
    CountrySelectVM * vm;
}

@end

@implementation TKCountrySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"请选择国家";
    
    vm = [[CountrySelectVM alloc] initWithDefaultTable];
    vm.vc = self;
    [self.view addSubview:vm.mTableView];
    [vm tkUpdateViewConstraint];
    
    [vm tkLoadDefaultData];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)onCountrySelect:(NSString *)country countryCode:(NSString *)code
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate onCountrySelect:country countryCode:code];
}

@end



