//
//  TKBrandSelectViewController.h
//  tracedemo
//
//  Created by cmcc on 16/3/25.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"
#import "TKTableViewVM.h"
#import "TK_Brand.h"
#import "TK_ShareCategory.h"


@protocol BrandSelectDelegate <NSObject>

-(void)selectCancel;
-(void)onBrandSelect:(TK_Brand *)brand;
-(void)onCategorySelect:(TK_ShareCategory *)category;
@end


@interface SelectVM :TKTableViewVM
@property (weak ,nonatomic)TK_Brand * brand;
@property (weak ,nonatomic)TK_ShareCategory * category;
@property (assign,nonatomic)NSInteger type;

@end


@interface TKBrandSelectViewController : TKIBaseNavWithDefaultBackVC
- (IBAction)cancenSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak ,nonatomic)id<BrandSelectDelegate> selectDelegate;
@property (strong,nonatomic) SelectVM * vm;
@end
