//
//  TKUserPageViewController.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/9.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKUserPageViewController.h"
#import "HFPostDetailView.h"
#import "TKHomePageViewController.h"
#import "TKIShowGoodsVM.h"


@interface TKUserPageViewController ()
{

    CGFloat headViewHeight;
    TKIShowGoodsVM * vm;

   
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HFPostDetailView * mPostView;
@end

@implementation TKUserPageViewController


-(void)setDefaultValue
{

    headViewHeight = 236;// head 高度 TKScreenScale *
}

-(void)loadRefreshTableView
{
    self.tableHeadView.frame = CGRectMake(0, 0, kScreenWidth, headViewHeight);
    [self.mPostView.mTableView setTableHeaderView:self.tableHeadView];
    [self.view addSubview:self.mPostView];
    [self.mPostView reloadData:self.dataSource];
//    self.mPostView.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultValue];
    vm = [[TKIShowGoodsVM alloc] initWithFreshAbleTable];
    
    [self.view addSubview:vm.pullRefreshView];
    
    [vm.mTableView setTableHeaderView:self.tableHeadView];
    
    [vm tkUpdateViewConstraint];
    
    [vm startPullDownRefreshing];
    
    
    
    
    
//    [self loadRefreshTableView];
//    [self refreshHeadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)refreshHeadData
{
    TKUser * user = nil;
    if([self.userId isEqual:TKUserId])
    {
        user = [[TKUserCenter instance] getUser];
    }
    else
    {
        user = [[TKUser alloc] init];
    }
    
    self.signatureView.text = user.signature;
    self.nickNameView.text = user.nickName;
    
//    [imageView  sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:user.headPortraitUrl]]
//                  placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    TKSetHeadImageView(self.headImageView, user.headPortraitUrl);
    
}


//- (HFPostDetailView *)mPostView
//{
//    if (!_mPostView) {
//        
//        CGFloat height = TKScreenHeight - 64; //CGRectGetHeight(self.view.frame);
//        _mPostView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,height) withTableViewStyle:UITableViewStylePlain];
//        _mPostView.bSupportPullUpLoad = YES;
//        _mPostView.pageSize = kPageSize;
////        _mPostView.bNeedPushUserCenter = NO;
//        _mPostView.delegate = self;
//        _mPostView.mTableView.backgroundColor = [UIColor clearColor];
//        _mPostView.backgroundColor = [UIColor clearColor];
//
////        if ([_userId isEqualToString:TKUserId]) {
////                [self.editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
////                self.mPostView.showDeleteBtn = YES;
////            }else{
////                [self.editBtn setTitle:@"＋关注" forState:UIControlStateNormal];
////                [self.editBtn setTitle:@"取消关注" forState:UIControlStateSelected];
////            }
////        }
////        [self.headImage.layer setBorderWidth:1];
////        [self.headImage.layer setBorderColor:[UIColor whiteColor].CGColor];
////        [_mPostView.mTableView setTableHeaderView:self.tableHeadView];
//        
////        [_mPostView.mTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//        
////        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headViewHeight)];
////        view.backgroundColor = [UIColor HFColorStyle_5];
////        [self.view addSubview:view];
////        [view sendToBack];
//    }
//    return _mPostView;
//}

-(UIView *)tableHeadView
{

    return _tableHeadView;
}
//
//- (NSMutableArray *)dataSource
//{
//    if (!_dataSource) {
//        _dataSource = [[NSMutableArray alloc]init];
//        [_dataSource addObjectsFromArray:[TKHomePageViewController imaginaryShowOrdersData]];
//    }
//    return _dataSource;
//}

//#pragma mark PostDetailViewDelegate
//- (void)loadPullDownRefreashData
//{
//    [self performSelector:@selector(loadPageData) withObject:nil afterDelay:1.0f];
//}
//
//
//-(void)loadPageData
//{
//
//    [self.mPostView endRefreash];
//}
//
//
//- (void)loadPullUpMoreData
//{
//    [self.mPostView endRefreash];
//}


@end
