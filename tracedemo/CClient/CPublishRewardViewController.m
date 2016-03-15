//
//  CPublishRewardViewController.m
//  tracedemo
//
//  Created by cmcc on 16/3/9.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "CPublishRewardViewController.h"
#import "UIColor+TK_Color.h"
#import "TKNotifycationViewController.h"
#import "Masonry.h"
//#import "TK_PicAddView.h"
#import "ZHPickView.h"
#import "TKClearView.h"
#import "CycleScrollView.h"
#import "HFKeyBoard.h"
#import "TKPicSelectTool.h"
#import "TKUITools.h"
#import "TK_PublishMakeSureView.h"


#define PICONE 101
#define PICSecond 102

@interface CPublishRewardViewController ()<TKPicSelectDelegate,CycleScrollViewDelegate,ZHPickViewDelegate,
UITextFieldDelegate,UITextViewDelegate,TKClearViewDelegate,HFKeyBoardDelegate>
{
    CGFloat picWidth;
    NSInteger picCountInLine;
    CGFloat picWiteSpaceWidth;
    CGFloat picTopAndBtomPadding;
    TKPicSelectTool * picTool;
    NSInteger selectPic ;
    NSMutableArray *  otherPics;//其它图片
    UIImage *image1;
    UIImage *image2;
}

@end

@implementation CPublishRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view from its nib.
}


-(void)initView
{
    picCountInLine = 4;
    picWiteSpaceWidth = 10;
    picTopAndBtomPadding = 12;
    selectPic = 0;
    otherPics = [[NSMutableArray alloc] init];
    
    
    picWidth = (TKScreenWidth -  (picCountInLine+1)* picWiteSpaceWidth )/ picCountInLine;
    self.hidDefaultBackBtn = YES;
    self.navTitle = @"发布悬赏";
    [self.mainScrollView setContentSize:CGSizeMake(TKScreenWidth, TKScreenHeight)];
    [self.mainScrollView addSubview:self.mainView];
    
    
    self.firstPic.frame = CGRectMake(picWiteSpaceWidth, picTopAndBtomPadding, picWidth, picWidth);
    self.secondPic.frame = CGRectMake(picWidth + picWiteSpaceWidth*2 , picTopAndBtomPadding, picWidth, picWidth);
    [self.firstPic setStatus:NormalAddBtn];
    [self.secondPic setStatus:NormalAddBtn];
    
    
    UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPicTap:)];
    self.firstPic.tag = PICONE;
    [self.firstPic addGestureRecognizer:tap];
    UIGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPicTap:)];
    self.secondPic.tag = PICSecond;
    [self.secondPic addGestureRecognizer:tap2];
    [self resetPicField];
    
    
}


/**
 刷新 图片区域
 **/
-(void)resetPicField
{
    
    [TKUITools removeAllChildViews:self.imageContaner];
    [self.imageContaner addSubview:self.firstPic];
    [self.imageContaner addSubview:self.secondPic];
    
    if(!image1)
    {
        [self.firstPic setStatus:DescAddBtn];
        self.firstPic.centerDescText.text = @"添加商品主图";
        
    }else
    {
        [self.firstPic setStatus:ImageStatus];
        self.firstPic.bottomDescText.text = @"主图";
    }
    
    if(!image2)
    {
        [self.secondPic setStatus:DescAddBtn];
        self.secondPic.centerDescText.text = @"添加吊牌图";
        
    }else
    {
        [self.secondPic setStatus:ImageStatus];
        self.secondPic.bottomDescText.text = @"吊牌";
    }
    
    
    for(int i =0;i<otherPics.count;i++)
    {
        TK_ImageSelectBoxView * box = [[TK_ImageSelectBoxView alloc] init];
        
        int x = (i+2)%4;
        int y = (i+2)/4;
        
        CGRect frame = CGRectMake(picWiteSpaceWidth + x*(picWiteSpaceWidth + picWidth), picTopAndBtomPadding + y*(picWiteSpaceWidth + picWidth), picWidth, picWidth);
        
        box.frame = frame;
        [self.imageContaner addSubview:box];
    }
    
    if(otherPics.count < 6)
    {
        TK_ImageSelectBoxView * box = [[TK_ImageSelectBoxView alloc] init];
        NSInteger count = otherPics.count;
        NSInteger x = (count+2)%4;
        NSInteger y = (count+2)/4;
        
        CGRect frame = CGRectMake(picWiteSpaceWidth + x*(picWiteSpaceWidth + picWidth), picTopAndBtomPadding + y*(picWiteSpaceWidth + picWidth), picWidth, picWidth);
        
        [box setStatus:NormalAddBtn];
        
        box.frame = frame;
        [self.imageContaner addSubview:box];
    }

}


-(void)onPicTap:(UIGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    selectPic = index;
    if(!picTool)
    {
        picTool = [[TKPicSelectTool alloc]init];
        picTool.selectDelegate = self;
        picTool.viewController = self;
    }
    [picTool doSelectPic:@"添加图片" clipping:NO maxSelect:1];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self TKsetLeftBarItemText:@"取消" withTextColor:[UIColor tkThemeColor1] addTarget:self action:@selector(TKI_leftBarAction) forControlEvents:UIControlEventTouchUpInside];
    [self TKsetRightBarItemText:@"发布" withTextColor:[UIColor tkThemeColor1] addTarget:self action:@selector(TKI_rightBarAction) forControlEvents:UIControlEventTouchUpInside];
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


-(void)TKI_leftBarAction
{
//    [TKNotifycationViewController showNotifyCation:@"测试通知"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    [self TKI_leftBarAction];
    
}

-(void)TKI_rightBarAction
{
    
    // 发布请求
    
    
    TK_PublishMakeSureView * popView = [[TK_PublishMakeSureView alloc]init];
//    [self onClearViewEvent];
    
    NSArray * pics = @[image1,image2]; //[[NSArray alloc] initWithArray:self.picturesArr];
    popView.images = pics;
    popView.content = @"测试悬赏";
    popView.showPrice = 10;  //[self.willByPrice.text integerValue] * 100;
    
    [[AppDelegate getAppDelegate].window addSubview:popView];
    
    
    [popView beginSend];
    
}

-(TK_ImageSelectBoxView *)firstPic
{
    if(!_firstPic)
    {
        _firstPic =  [[TK_ImageSelectBoxView alloc] init];
    }
    return _firstPic;
}

-(TK_ImageSelectBoxView *)secondPic
{
    if(!_secondPic)
    {
        _secondPic =  [[TK_ImageSelectBoxView alloc] init];
    }
    return _secondPic;
}


#pragma mark 

-(void)onImageSelect:(UIImage *)image
{
    if(PICONE == selectPic)
    {
        image1 = image;
        self.firstPic.mainImage.image = image1;
        [self.firstPic setStatus:ImageStatus];
        self.firstPic.bottomDescText.text = @"主图";
    }
    else if(PICSecond == selectPic)
    {
        image2 = image;
        self.secondPic.mainImage.image = image2;
        [self.secondPic setStatus:ImageStatus];
        self.secondPic.bottomDescText.text = @"吊牌";
    }
}
-(void)onImagesSelect:(NSArray *)images
{
    if(images.count == 1)
    {
        [self onImageSelect:images[0]];
    }else
    {
    }
}
-(void)onLoadingImage
{
}

@end
