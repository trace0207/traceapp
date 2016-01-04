//
//  TKLeftMenuController.m
//  tracedemo
//
//  Created by cmcc on 15/9/20.
//  Copyright (c) 2015年 trace. All rights reserved.
//

#import "TKLeftMenuController.h"
#import "UIColor+TK_Color.h"
#import "TKColorDefine.h"
#import "Masonry.h"

@interface TKLeftMenuController ()<UITableViewDataSource,UITableViewDelegate>
{

    NSInteger _maxWidth;// 定义 滑动菜单最大的滑动距离
    UIView * _bottomLeftBtn;
    UIView * _bottomRightBtn;
    NSMutableArray * data;
    UIView * menuHeadView;
    
}

@end

@implementation TKLeftMenuController


-(void)loadView{

    [super loadView];
    [self initView];
    
//       [_bottomRightBtn updateConstraints];
    
    
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)initData{

//    NSArray * datas = [[NSArray alloc] init]
    
    data = [[NSMutableArray alloc]initWithObjects:@"首页", @"服装服饰",@"箱包手袋",@"时尚鞋类",@"母婴家居",@"首饰手表",@"美妆护肤",@"数码家电",@"精选品牌", nil];
    
}


-(void)initView{

    UIView * menuView = [[[NSBundle mainBundle]loadNibNamed:@"TKLeftMenu" owner:self options:nil] objectAtIndex:0];
    
//    menuView.frame = CGRectMake(0, 0, 375, TKScreenHeight);
    
    
    menuHeadView = [menuView viewWithTag:10];
    
    
    [self initMenuHeadView:menuHeadView];
    [self initBottomView:menuView];
    
    
    self.tableView = (UITableView *)[menuView viewWithTag:1];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.borderWidth = 0.0;
    self.tableView.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_black_main];
    
    _bottomLeftBtn = [menuView viewWithTag:2];
    _bottomRightBtn = [menuView viewWithTag:3];
    [self.view addSubview:menuView];
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.frame = CGRectMake(0, 0, _maxWidth, self.view.frame.size.height);
    
//    [self initView];
    
//    self.tableView.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_Black];
    
    self.tableView.bounces = NO;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)init{

    self = [super init];
    _maxWidth = 320 * TKScreenScale;
    [self initData];
    return self;
}


-(id)initWithMaxWidth:(NSInteger) maxWidth
{

    self = [self init];
    _maxWidth = maxWidth;
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return data.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  45.0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"LeftMenuCell"];
    
    if(cell == nil){
    
        cell = [self fillMenuItemCellView:cell];
    }
    
   
    UILabel * textLebel = (UILabel * )[cell viewWithTag:1];
    textLebel.text =  (NSString * )[data objectAtIndex:indexPath.row];
    if(indexPath.row == (data.count-1)){
    
        [[cell viewWithTag:3] setHidden:YES];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




#pragma mark -------initViewDetail----------

/**
 *初始化菜单头部
 **/

-(void)initMenuHeadView:(UIView *)menuHead{
    
    
    menuHeadView.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_black_main];
    
    
    UIImageView * headImage =  (UIImageView * )[menuHead viewWithTag:3];
    UILabel * label1 = (UILabel *)[menuHead viewWithTag:4];
    UIImageView * userStarImageIcon = (UIImageView * )[menuHead viewWithTag:5];
    UILabel * label2 = (UILabel * )[menuHead viewWithTag:6];
    
    headImage.image = [UIImage imageNamed:@"tk_image_head"];
    label1.text = @"trace(18867101952)";
    userStarImageIcon.image = [UIImage imageNamed:@"tk_icon_vip"];
    label2.text = @"99+";
    
    headImage.layer.cornerRadius = headImage.frame.size.height/2;
    headImage.clipsToBounds = YES;
    
    headImage.layer.borderWidth = 1.5f;
    headImage.layer.borderColor = [UIColor TKcolorWithHexString:TK_Color_white_main].CGColor;
    
}
 

/**
 初始化 bottomView
 **/

-(void)initBottomView:(UIView *)menuView{
    
    
    UIView * bottomView = [menuView viewWithTag:200];
    
    
    

    UIView * bottomLeft = [bottomView viewWithTag:201];
    UIView * bottomRight = [bottomView viewWithTag:202];
    UIView * bottomTopLine = [bottomView viewWithTag:203];
    UIView * bottomSepartorLine  = [bottomView viewWithTag:204];
    
    
    UIColor * blackBackground = [UIColor TKcolorWithHexString:TK_Color_black_main];
    UIColor * lineWite = [UIColor TKcolorWithHexString:TK_Color_separator_white];
    
    bottomLeft.backgroundColor = blackBackground;
    bottomRight.backgroundColor = blackBackground;
    bottomSepartorLine.backgroundColor = lineWite;
    bottomTopLine.backgroundColor = lineWite;
    
    
//    bottomLeft.layer.borderWidth = 1;
//    bottomLeft.layer.borderColor = [UIColor TKcolorWithHexString:TK_Color_separator_white].CGColor;
//    bottomRight.layer.borderWidth = 1;
//    bottomRight.layer.borderColor = [UIColor TKcolorWithHexString:TK_Color_separator_white].CGColor;
}



/**
 
 填充 LeftMenuIte
 
 **/
-(UITableViewCell *)fillMenuItemCellView:(UITableViewCell *)cell{

    cell = [[UITableViewCell alloc]init];
    UILabel  * text = [[UILabel alloc]init];
    text.textAlignment  = NSTextAlignmentLeft;
    text.textColor = [UIColor TKcolorWithHexString:TK_Color_Wite];
    text.tag = 1;
    
    UIView * line = [[UIView alloc]init];
    [cell addSubview:line];
    [cell addSubview:text];
    line.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_Wite alpha:0.3];

    UIView * sv2 = text;
    UIView * sv3 = line;
    UIView * sv = cell;
    
    UIImageView * icon = [[UIImageView alloc] init];
//  icon.backgroundColor = [UIColor redColor];
    icon.image = [UIImage imageNamed:@"tk_icon_star"];
    [cell addSubview:icon];
    
    
    
    icon.tag = 2;
    line.tag = 3;

    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sv.mas_left).with.offset(30 * TKScreenScale);
//        make.right.equalTo(sv.mas_right).with.offset(-10);
        make.height.mas_equalTo(sv.mas_height).with.offset(-10);
        make.top.equalTo(sv.mas_top).with.offset(5);
        make.width.mas_equalTo(sv.mas_height).with.offset(-10);
    }];
    
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).with.offset(10 * TKScreenScale);
        make.right.equalTo(sv.mas_right).with.offset(-10);
        make.height.mas_equalTo(sv.mas_height);
        make.top.equalTo(sv.mas_top);
    }];
    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sv2.mas_bottom);
        make.left.equalTo(sv.mas_left).with.offset(50);
        make.right.equalTo(sv.mas_right).with.offset(-10);
        make.height.mas_equalTo(0.5);
    }];
    
    
    sv3.backgroundColor = [UIColor TKcolorWithHexString:TK_Color_separator_white];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
