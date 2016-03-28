//
//  BPageViewController.m
//  tracedemo
//
//  Created by zhuxiaoxia on 16/3/12.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "BPageViewController.h"
#import "BHomeChildAVC.h"
#import "UIColor+TK_Color.h"
#import "KTDropdownMenuView.h"
#import "HFTitleLabel.h"
#import "TK_ShareCategory.h"
#import "TK_Brand.h"
#import "TKShowGoodsListVC.h"
@interface BPageViewController ()<ViewPagerDataSource,ViewPagerDelegate>
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic,strong)KTDropdownMenuView *menuView;
@end

@implementation BPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self reloadData];
    [self.view addSubview:self.menuView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (KTDropdownMenuView *)menuView
{
    if (_menuView == nil) {
        NSArray *titles = @[@"耐克", @"阿迪达斯", @"杰克琼斯", @"安踏", @"七匹狼", @"李宁", @"乔丹"];
        _menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(kScreenWidth-90, 0,90, 44) titles:titles];
        _menuView.showLine = YES;
        _menuView.backgroundColor = [UIColor hexChangeFloat:TK_Color_nav_background];
        _menuView.cellColor = [UIColor clearColor];
        _menuView.cellSeparatorColor = [UIColor lightGrayColor];
        _menuView.selectedAtIndex = ^(int index)
        {
            NSLog(@"selected title:%@", titles[index]);
        };
        _menuView.textFont = [UIFont systemFontOfSize:15];
        _menuView.backgroundAlpha = 0.0f;
        _menuView.width = 115;
        _menuView.edgesRight = -20;
        _menuView.textColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellAccessoryCheckmarkColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellSeparatorColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
    }
    return _menuView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [[NSMutableArray alloc]initWithObjects:@"全部",@"包包",@"鞋子",@"裤子",@"上衣",@"毛衣",@"外套", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)numberArray
{
    if (_numberArray == nil) {
        _numberArray = [[NSMutableArray alloc]initWithObjects:@(0),@(3),@(0),@(6),@(53),@(100),@(76), nil];
    }
    return _numberArray;
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.titleArray.count;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    
    HFTitleLabel *label = [[HFTitleLabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    NSString *title = [self.titleArray objectAtIndex:index];
    CGSize size = CGSizeMake(320,2000); //设置一个行高上限
    NSDictionary *attributes = @{NSFontAttributeName:label.textFont};
    size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSInteger num = 0;
    if (index < self.numberArray.count) {
        NSNumber *number = [self.numberArray objectAtIndex:index];
        NSInteger num1 = [number integerValue];
        num = num1;
    }
    CGFloat width = size.width + 20;
    if (num > 0) {
        width += 17;
    }
    label.frame = CGRectMake(0, 0, width, 44);
    
    [label setTitle:title number:num]; 
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
   
    if(self.dataType == B_AllReward || self.dataType == B_MyUserReward || self.dataType == C_AllReward)
    {
        BHomeChildAVC *vc = [[BHomeChildAVC alloc]init];
        vc.vm1.rewardPageType = self.dataType;
        TK_ShareCategory * category = [[TK_ShareCategory alloc] init];
        category.categoryId = @"1";
        category.title = @"内衣";
        vc.vm1.category =category;
        return vc;
    }else
    {
        TKShowGoodsListVC *vc = [[TKShowGoodsListVC alloc]init];
        TK_ShareCategory * category = [[TK_ShareCategory alloc] init];
        category.categoryId = @"1";
        category.title = @"内衣";
        vc.vm.category =category;
        return vc;
    }
}

#pragma mark - ViewPagerDelegate
//- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
//    
//    switch (option) {
//        case ViewPagerOptionStartFromSecondTab:
//            return 0;
//            break;
//        case ViewPagerOptionCenterCurrentTab:
//            return 1.0;
//            break;
//        case ViewPagerOptionTabLocation:
//            return 1.0;
//            break;
//        default:
//            break;
//    }
//    
//    return value;
//}
//- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
//    
//    switch (component) {
//        case ViewPagerIndicator:
//            return [[UIColor redColor] colorWithAlphaComponent:0.64];
//            break;
//        default:
//            return [[UIColor grayColor] colorWithAlphaComponent:0.64];
//            break;
//    }
//    
//    return color;
//}

@end
