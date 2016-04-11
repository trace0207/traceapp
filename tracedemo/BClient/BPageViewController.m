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
#import "TKUserCenter.h"
#import "TKLoginViewController.h"
#import "CPublishRewardViewController.h"
@interface BPageViewController ()<ViewPagerDataSource,ViewPagerDelegate,TKShowGoodsVMDelegate,LoginDelegate>
{

    TK_Brand *currentBrand; // 当前选中的品牌
    TKIShowGoodsRowM *rowData; // 缓存的 item 数据，用户登录回来之后跳转

}
@property (nonatomic, strong) NSMutableArray<__kindof TK_Brand*> *brandsArray;
@property (nonatomic, strong) NSMutableArray<__kindof TK_ShareCategory*> * shareCategorys;
@property (nonatomic,strong)KTDropdownMenuView *menuView;
@end

@implementation BPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentBrand = [TKUserCenter instance].userNormalVM.defaultBrand;
//    currentCategory = [TKUserCenter instance].userNormalVM.defaultCategory;
    
    self.dataSource = self;
    self.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabViewRightSpace = 95;
    [self.view addSubview:self.menuView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DDLogInfo(@"Warning !!!!!!");
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
     
}


-(void)reloadTitleViewAndData
{
    DDLogInfo(@"BPageViewController loadData enter ");
    NSMutableArray<__kindof TK_ShareCategory*> * shareCategorys = nil;
    
#if B_Client == 1
     shareCategorys = [TKUserCenter instance].userNormalVM.buyerCateList;
#else
     shareCategorys = [TKUserCenter instance].userNormalVM.shareCategorys;
#endif
//    NSMutableArray * titles = [[NSMutableArray alloc] init];
//    for (TK_ShareCategory *s in shareCategorys) {
//        [titles addObject:s.title];
//    }
    
    
//    [shareCategorys insertObject:[TKUserCenter instance].userNormalVM.defaultCategory atIndex:0];
    
    NSArray * brandList = [TKUserCenter instance].userNormalVM.brandList;
    NSMutableArray * brands = [[NSMutableArray alloc] init];
    
    [brands addObject:[TKUserCenter instance].userNormalVM.defaultBrand.brandName];
    
    for (TK_Brand  * b in brandList ) {
    
        [brands addObject:b.brandName];
    }
    [self.menuView setTitles:brands];
    
//    [brands insertObject:[TKUserCenter instance].userNormalVM.defaultBrand atIndex:0];
    
    self.brandsArray = [brandList mutableCopy];
    self.shareCategorys = [shareCategorys mutableCopy];
    [self.brandsArray insertObject:[TKUserCenter instance].userNormalVM.defaultBrand atIndex:0];
    [self.shareCategorys insertObject:[TKUserCenter instance].userNormalVM.defaultCategory atIndex:0];
    [self reloadData];
    if(shareCategorys.count != 0 && brandList.count != 0)
    {
        self.titleReady = YES;
    }
}

- (KTDropdownMenuView *)menuView
{
    if (_menuView == nil) {
        NSArray *titles = @[];
        _menuView = [[KTDropdownMenuView alloc] initWithFrame:CGRectMake(kScreenWidth-90, 0,90, 44) titles:titles];
        _menuView.clipsToBounds = YES;
        _menuView.showLine = YES;
        _menuView.backgroundColor = [UIColor tkThemeColor2];
        _menuView.cellColor = [UIColor clearColor];
        _menuView.cellSeparatorColor = [UIColor lightGrayColor];
        _menuView.width = 200;
        _menuView.maxHeight = TKScreenHeight - 64 - 44 - 49 -10;
        WS(weakSelf)
        _menuView.selectedAtIndex = ^(int index)
        {
            [weakSelf onMenuSelect:index];
//            NSLog(@"selected title:%@", shareCategorys[index]);
        };
        _menuView.textFont = [UIFont systemFontOfSize:15];
        _menuView.backgroundAlpha = 0.0f;
        _menuView.edgesRight = -20;
        _menuView.textColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellAccessoryCheckmarkColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
        _menuView.cellSeparatorColor = [UIColor TKcolorWithHexString:TK_Color_nav_textDefault];
    }
    return _menuView;
}


-(void)onMenuSelect:(NSInteger)index
{
    if(self.brandsArray.count > index)
    {
        DDLogInfo(@"select title %@",self.brandsArray[index].brandName);
        currentBrand = self.brandsArray[index];
        [self reloadData];
    }
}


- (NSMutableArray *)brandsArray
{
    if (_brandsArray == nil) {
        _brandsArray = [[NSMutableArray alloc]init];
    }
    return _brandsArray;
}

//- (NSMutableArray *)numberArray
//{
//    if (_numberArray == nil) {
//        _numberArray = [[NSMutableArray alloc]init];
//    }
//    return _numberArray;
//}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.shareCategorys.count;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    
    HFTitleLabel *label = [[HFTitleLabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    NSString *title = [self.shareCategorys objectAtIndex:index].title;
    CGSize size = CGSizeMake(320,2000); //设置一个行高上限
    NSDictionary *attributes = @{NSFontAttributeName:label.textFont};
    size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSInteger num = 0;
    if (index < self.shareCategorys.count) {
        NSString *number = [self.shareCategorys objectAtIndex:index].sum;
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
        vc.vm1.category = [self.shareCategorys objectAtIndex:index];
        vc.vm1.brand = currentBrand;
        
        [self performSelector:@selector(pullRefreshB:) withObject:vc afterDelay:0.4];
        
        
        return vc;
    }else
    {
        TKShowGoodsListVC *vc = [[TKShowGoodsListVC alloc]init];
//        TK_ShareCategory * category = [[TK_ShareCategory alloc] init];
//        category.categoryId = @"";
//        category.title = @"内衣";
        vc.vm.category = [self.shareCategorys objectAtIndex:index];;
        vc.vm.brand = currentBrand;
        vc.vm.showGoodsDelegate = self;
        [self performSelector:@selector(pullRefreshA:) withObject:vc afterDelay:0.4];
        return vc;
    }
}

-(void)pullRefreshB:(TKShowGoodsListVC *)vc
{
    [vc loadData];
}

-(void)pullRefreshA:(BHomeChildAVC *)vc
{
    [vc loadData];
}


-(NSArray<__kindof TK_ShareCategory*> *)shareCategorys
{
    if(_shareCategorys == nil)
    {
        _shareCategorys = [[NSMutableArray alloc] init];
        
       TK_ShareCategory * s =  [[TK_ShareCategory alloc] init];
     
        s.sum = @"0";
        s.title = @"全部类目";
        s.categoryId = @"";
        [_shareCategorys addObject:s];
    }
    return _shareCategorys;
}


-(void)onPageSelect:(NSInteger)index
{
    
}



#pragma mark - ViewPagerDelegate


- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
//    currentCategory = [self.shareCategorys objectAtIndex:index];
    self.startPageIndex = index;
    DDLogInfo(@"page change %ld",index);
}


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


#pragma  mark  TKShowGoodsVMDelegate


-(void)onFollowAction:(TKIShowGoodsRowM *)row
{
    if(![TKUserCenter instance].isLogin)
    {
        rowData = row;
        [TKLoginViewController showLoginViewPage:self];
    }
    else
    {
        CPublishRewardViewController * vc = [[CPublishRewardViewController alloc] init];
        vc.showGoodsrowData = rowData;
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [[AppDelegate getMainNavigation] presentViewController:nvc animated:YES completion:nil];
    }
}

#pragma  mark LoginDelegate

-(void)onLoginSuccess
{
    CPublishRewardViewController * vc = [[CPublishRewardViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.showGoodsrowData = rowData;
    [[AppDelegate getMainNavigation] presentViewController:nvc animated:YES completion:nil];
}

@end
