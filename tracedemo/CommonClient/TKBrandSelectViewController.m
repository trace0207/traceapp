//
//  TKBrandSelectViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/25.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKBrandSelectViewController.h"
#import "TKTableViewVM.h"
#import "TKUserCenter.h"
#import "TK_SettingCell.h"

@interface TKBrandSelectViewController ()<TKTableViewVMDelegate>
{
    
}

@end


@implementation SelectVM


-(void)tkLoadDefaultData
{
//    NSMutableArray<__kindof TK_Brand*> * brands =  [TKUserCenter instance].userNormalVM.brandList;
    if(self.type == 1)
    {
        [self.defaultSection initDefaultRowData:[TKUserCenter instance].userNormalVM.brandList.count];
    }else if(self.type == 2)
    {
        [self.defaultSection initDefaultRowData:[TKUserCenter instance].userNormalVM.shareCategorys.count];
    }
    [self.mTableView reloadData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_SettingCell * selectCell = [tableView dequeueReusableCellWithIdentifier:@"TK_SettingCell"];
    if(!selectCell)
    {
        selectCell = [TK_SettingCell loadSelectType:self];
    }
    
    if(self.type == 1)
    {
        TK_Brand * rowBand =  [[TKUserCenter instance].userNormalVM.brandList objectAtIndex:indexPath.row];
        selectCell.label1.text = rowBand.brandName;
        
        if(self.brand.brandId == rowBand.brandId)
        {
            selectCell.icon1.hidden = NO;
        }else
        {
            selectCell.icon1.hidden = YES;
        }
    }
    else if(self.type == 2)
    {
        TK_ShareCategory * rowData =  [[TKUserCenter instance].userNormalVM.shareCategorys objectAtIndex:indexPath.row];
        selectCell.label1.text = rowData.title;
        
        if(self.category.categoryId == rowData.categoryId)
        {
            selectCell.icon1.hidden = NO;
        }else
        {
            selectCell.icon1.hidden = YES;
        }

    }
 
    return selectCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if(self.type == 1)
    {
        self.brand = [[TKUserCenter instance].userNormalVM.brandList objectAtIndex:indexPath.row];
        
        [tableView reloadData];
        
        if(self.tkDelegate && [self.tkDelegate respondsToSelector:@selector(onTableItemSelect:withItemData:)])
        {
            [self.tkDelegate onTableItemSelect:indexPath withItemData:self.brand];
        }

    }else if(self.type == 2)
    {
        self.category = [[TKUserCenter instance].userNormalVM.shareCategorys objectAtIndex:indexPath.row];
        
        [tableView reloadData];
        
        if(self.tkDelegate && [self.tkDelegate respondsToSelector:@selector(onTableItemSelect:withItemData:)])
        {
            [self.tkDelegate onTableItemSelect:indexPath withItemData:self.category];
        }
    }
    
}

@end

@implementation TKBrandSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(0, 0, TKScreenWidth, TKScreenHeight);
   
    [self.contentView addSubview:self.vm.mTableView];
    [self.vm tkUpdateViewConstraint];
    [self.vm tkLoadDefaultData];
    self.vm.tkDelegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(SelectVM *)vm
{
    if(_vm == nil)
    {
         _vm = [[SelectVM alloc] initWithDefaultTable];
    }
    return _vm;
}

- (IBAction)cancenSelect:(id)sender {
    if(self.selectDelegate)
    {
        [self.selectDelegate selectCancel];
    }
}

-(void)onTableItemSelect:(NSIndexPath *)indexPath withItemData:(id)data
{
    if([data isKindOfClass:[TK_Brand class]])
    {
        if(self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(onBrandSelect:)])
        {
            [self.selectDelegate onBrandSelect:data];
            [self.selectDelegate selectCancel];
        }
        
    }
    if([data isKindOfClass:[TK_ShareCategory class]])
    {
        if(self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(onCategorySelect:)])
        {
            [self.selectDelegate onCategorySelect:data];
            [self.selectDelegate selectCancel];
        }
    }
}
@end
