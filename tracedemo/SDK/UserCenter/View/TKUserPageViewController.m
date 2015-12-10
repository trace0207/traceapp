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

@interface TKUserPageViewController ()<PostCellDelegate,BasePostDetailViewDelegate>
{

    CGFloat headViewHeight;
   
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setDefaultValue];
    [self loadRefreshTableView];
    
   
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



- (HFPostDetailView *)mPostView
{
    if (!_mPostView) {
        
        _mPostView = [[HFPostDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withTableViewStyle:UITableViewStylePlain];
        _mPostView.bSupportPullUpLoad = YES;
        _mPostView.pageSize = kPageSize;
        _mPostView.bNeedPushUserCenter = NO;
        _mPostView.delegate = self;
        _mPostView.mTableView.backgroundColor = [UIColor clearColor];
        _mPostView.backgroundColor = [UIColor clearColor];

//        if ([_userId isEqualToString:TKUserId]) {
//                [self.editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
//                self.mPostView.showDeleteBtn = YES;
//            }else{
//                [self.editBtn setTitle:@"＋关注" forState:UIControlStateNormal];
//                [self.editBtn setTitle:@"取消关注" forState:UIControlStateSelected];
//            }
//        }
//        [self.headImage.layer setBorderWidth:1];
//        [self.headImage.layer setBorderColor:[UIColor whiteColor].CGColor];
//        [_mPostView.mTableView setTableHeaderView:self.tableHeadView];
        
//        [_mPostView.mTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headViewHeight)];
//        view.backgroundColor = [UIColor HFColorStyle_5];
//        [self.view addSubview:view];
//        [view sendToBack];
    }
    return _mPostView;
}

-(UIView *)tableHeadView
{

    return _tableHeadView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        [_dataSource addObjectsFromArray:[TKHomePageViewController imaginaryShowOrdersData]];
    }
    return _dataSource;
}

#pragma mark PostDetailViewDelegate
- (void)loadPullDownRefreashData
{
    [self performSelector:@selector(loadPageData) withObject:nil afterDelay:1.0f];
}


-(void)loadPageData
{

    [self.mPostView endRefreash];
}


- (void)loadPullUpMoreData
{
    [self.mPostView endRefreash];
}


@end
