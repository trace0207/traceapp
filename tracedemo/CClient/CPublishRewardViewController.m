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
#import "TKUITools.h"
#import "UIColor+TK_Color.h"
#import "TKWebViewController.h"
#import "TKBrandSelectViewController.h"
#import "TK_UploadImageAck.h"
#import "TK_PublishRewardArg.h"
#import "TK_PublishRewardAck.h"
#import "TK_PayArg.h"
#import "TKPayProxy.h"
#import "TKAlertView.h"
#import "TKUserCenter.h"
#import "TKProxy.h"
#import "GlobNotifyDefine.h"
#import "UIView+Border.h"
#import "UIButton+TitleImage.h"
#import "TKPublishShowGoodsArg.h"
#import "NSString+HFStrUtil.h"

#define PICONE 101
#define PICSecond 102
#define PIC_ADD 103

@interface CPublishRewardViewController ()<TKPicSelectDelegate,CycleScrollViewDelegate,ZHPickViewDelegate,
UITextFieldDelegate,UITextViewDelegate,TKClearViewDelegate,HFKeyBoardDelegate,BrandSelectDelegate,TKWebViewDelegate>
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
    CGFloat defaultHeight;
    NSString *requireDay;
    TKBrandSelectViewController * vc;
    TK_Brand * selectBrand;
    TK_ShareCategory * selectCategory;
    TKAlertView * alertView;
    Address * ackAddress;
    
}

@end

@implementation CPublishRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.publishType != 1)
    {
        defaultHeight = TKScreenHeight - 64;
        //    [self dayBtn2:self.dayBtn2];
        requireDay = @"3";
    }else
    {
        defaultHeight = TKScreenHeight - 64;
    }

    [self initView];
    
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPayNotify:) name:TKPayNotify object:nil];
}


-(void)onPayNotify:(NSNotification *)notify
{
    NSString * result = [notify object];
    DDLogInfo(@"payBack result %@",result);
    if([result isEqualToString:@"success"])
    {
        [self onPublishSuccess];
    }
    else
    {
        [self payFailed];
    }
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:TKPayNotify object:nil];
}

-(void)initView
{
    picCountInLine = 4;
    picWiteSpaceWidth = 10;
    picTopAndBtomPadding = 12;
    selectPic = 0;
    otherPics = [[NSMutableArray alloc] init];
    self.clearView.clearDelegate = self;
    self.inputText.placehorderText = @"请输入颜色、尺码、尺寸等相关信息";
    picWidth = (TKScreenWidth -  (picCountInLine+1)* picWiteSpaceWidth )/ picCountInLine;
    self.hidDefaultBackBtn = YES;
    
    if(self.publishType == 1)
    {
        self.navTitle = @"晒单";
    }else
    {
        self.navTitle = @"发布悬赏";
    }
    
    [self.mainScrollView setContentSize:CGSizeMake(TKScreenWidth, defaultHeight)];
    self.mainView.clipsToBounds = YES;
//    self.mainView.frame = CGRectMake(0, 0, TKScreenWidth, defaultHeight);
    [self.mainScrollView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(TKScreenWidth);
        make.height.mas_equalTo(defaultHeight);
        
    }];
    
    
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
    [self resetFollowView];
    [self resetPicField];
    
    if(self.publishType == 1)
    {
        self.dayBtnField.hidden = YES;
        self.addressField.hidden = YES;
    }else
    {
        self.infoFieldMarginTop.constant = 65;
    }
    [self defaultViewSetting];
}



#pragma  mark  viewEvent

-(void)defaultViewSetting
{
    [TKUITools setRoudBorderForView:self.dayBtn1 borderColor:[UIColor tkBorderColor] radius:2 borderWidth:1];
    [TKUITools setRoudBorderForView:self.dayBtn2 borderColor:[UIColor tkBorderColor] radius:2 borderWidth:1];
    [TKUITools setRoudBorderForView:self.dayBtn3 borderColor:[UIColor tkBorderColor] radius:2 borderWidth:1];
    [TKUITools setRoudBorderForView:self.inputText borderColor:[UIColor tkBorderColor] radius:2 borderWidth:1];
    self.brandText.userInteractionEnabled = NO;
    self.categoryText.userInteractionEnabled = NO;
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAddress)];
    //    [self.addressView addGestureRecognizer:tap];
    //    self.addressText.userInteractionEnabled = NO;
    
    ackAddress =  [TKUserCenter instance].getUser.ackData.defaultReceiver;
    
    NSString * address =  [NSString stringWithFormat:@"%@  %@  %@",ackAddress.province,ackAddress.city,ackAddress.address];
    self.addressText.text = address;
}


-(void)showAddress
{
    TKWebViewController *web = [[TKWebViewController alloc] init];
    web.hidDefaultBackBtn = NO;
    web.delegate = self;
    web.defaultURL = [[TKProxy proxy].tkBaseUrl stringByAppendingString:AddressURL];
    [self.navigationController pushViewController:web animated:YES];
//    [TKWebViewController showWebView:@"选择地址" url:AddressURL];
    
}


-(UIView *)onClearViewEvent:(CGPoint)point withEvent:(UIEvent *)event
{
 
    
    CGPoint tapPoint = [self.priceInputText convertPoint:point fromView:self.clearView];
    if([self.priceInputText pointInside:tapPoint withEvent:event])
    {
        return self.priceInputText;
    }
    
    tapPoint = [self.inputText convertPoint:point fromView:self.clearView];
    
    if([self.inputText pointInside:tapPoint withEvent:event])
    {
        return self.inputText.textView;
    }
    [self hidKeyBord];
    return nil;
}


-(void)hidKeyBord
{
    [self.inputText resignFirstResponder];
    [self.priceInputText resignFirstResponder];

}




#pragma mark  pic event

/**
 刷新 图片区域
 **/
-(void)resetPicField
{
    
    [TKUITools removeAllChildViews:self.imageContaner];
    [self.imageContaner addSubview:self.firstPic];
    [self.imageContaner addSubview:self.secondPic];
    
   
    if(![NSString isStrEmpty:self.firstPic.remoutURL])
    {
        self.firstPic.bottomDescText.text = @"主图";

    }
    else if(!image1)
    {
        [self.firstPic setStatus:DescAddBtn];
        self.firstPic.centerDescText.text = @"添加商品主图";
        
    }else
    {
        [self.firstPic setStatus:ImageStatus];
        self.firstPic.bottomDescText.text = @"主图";
    }
    
    if(![NSString isStrEmpty:self.secondPic.remoutURL])
    {
        self.firstPic.bottomDescText.text = @"吊牌";

    }
    else if(!image2)
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
        
        int x = (i+2)%3;
        int y = (i+2)/3;
        
        CGRect frame = CGRectMake(picWiteSpaceWidth + x*(picWiteSpaceWidth + picWidth), picTopAndBtomPadding + y*(picWiteSpaceWidth + picWidth), picWidth, picWidth);
        [box setStatus:NormalImage];
        box.mainImage.image = [otherPics objectAtIndex:i];
        box.frame = frame;
        [self.imageContaner addSubview:box];
    }
    
    if(otherPics.count < 7 && self.showGoodsrowData == nil && self.rewardData == nil)
    {
        TK_ImageSelectBoxView * box = [[TK_ImageSelectBoxView alloc] init];
        NSInteger count = otherPics.count;
        NSInteger x = (count+2)%3;
        NSInteger y = (count+2)/3;
        
        CGRect frame = CGRectMake(picWiteSpaceWidth + x*(picWiteSpaceWidth + picWidth), picTopAndBtomPadding + y*(picWiteSpaceWidth + picWidth), picWidth, picWidth);
        
        [box setStatus:NormalAddBtn];
        
        box.frame = frame;
        [self.imageContaner addSubview:box];
        UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPicTap:)];
        box.tag = PIC_ADD;
        [box addGestureRecognizer:tap];
    }
    
    NSInteger boxCount = otherPics.count < 7?otherPics.count+3:otherPics.count+2 ;//  一共不足 7张时， 多一个 add box
    
    NSInteger row = boxCount/3;
    int morRow = boxCount%3 == 0?0:1;
    row = row + morRow;
    
    CGFloat addHeight = (picWidth + picTopAndBtomPadding)* (row - 1);
    
    self.imageFieldHeight.constant = addHeight + picWidth + picTopAndBtomPadding*2;
    
    [self.mainScrollView setContentSize:CGSizeMake(TKScreenWidth, defaultHeight + addHeight)];
//    self.mainView.frame = CGRectMake(0, 0, TKScreenWidth, defaultHeight+ addHeight);
    
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(defaultHeight + addHeight);
        
    }];

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
    
    if(index == PIC_ADD)
    {
        [picTool doSelectPic:@"添加图片" clipping:NO maxSelect:7 - otherPics.count];
    }else
    {
        [picTool doSelectPic:@"添加图片" clipping:NO maxSelect:1];
    }
    
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
    else if(PIC_ADD == selectPic)
    {
        [otherPics addObject:image];
        [self resetPicField];
    }
}
-(void)onImagesSelect:(NSArray *)images
{
    if(images.count == 1)
    {
        [self onImageSelect:images[0]];
    }else
    {
        [otherPics addObjectsFromArray:images];
        [self resetPicField];
    }
}
-(void)onLoadingImage
{
}



#pragma  mark  privete Method
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
    if(self.publishType == 1)
    {
        [[AppDelegate getMainNavigation] popViewControllerAnimated:YES];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

- (IBAction)addressFieldTouch:(id)sender {
    
    [self showAddress];
}




- (IBAction)dayBtn1:(id)sender {
//    self.dayBtn1.backgroundColor = [UIColor btnSelectBackgroundColor];
//    self.dayBtn2.backgroundColor = [UIColor clearColor];
//    self.dayBtn3.backgroundColor = [UIColor clearColor];
    requireDay = @"1";
    
    [self.dayBtn1 setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
    [self.dayBtn1 setTitleColor:[UIColor hexChangeFloat:TKColorGreen] forState:UIControlStateNormal];
    [self.dayBtn1 setLeftTitle:@"1天内发货" rightImage:IMG(@"selected")];
    
    [self.dayBtn2 setDefaultBorder];
    [self.dayBtn2 setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
    [self.dayBtn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn2 setTitle:@"3天内发货" forState:UIControlStateNormal];
    [self.dayBtn2 setImage:nil forState:UIControlStateNormal];
    
    [self.dayBtn3 setDefaultBorder];
    [self.dayBtn3 setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
    [self.dayBtn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn3 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn3 setTitle:@"7天内发货" forState:UIControlStateNormal];
    [self.dayBtn3 setImage:nil forState:UIControlStateNormal];
    
}
- (IBAction)dayBtn2:(id)sender {
    
//    self.dayBtn2.backgroundColor = [UIColor btnSelectBackgroundColor];
//    self.dayBtn1.backgroundColor = [UIColor clearColor];
//    self.dayBtn3.backgroundColor = [UIColor clearColor];
    requireDay = @"3";
    
    [self.dayBtn2 setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
    [self.dayBtn2 setTitleColor:[UIColor hexChangeFloat:TKColorGreen] forState:UIControlStateNormal];
    [self.dayBtn2 setLeftTitle:@"3天内发货" rightImage:IMG(@"selected")];
    
    [self.dayBtn1 setDefaultBorder];
    [self.dayBtn1 setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
    [self.dayBtn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn1 setTitle:@"1天内发货" forState:UIControlStateNormal];
    [self.dayBtn1 setImage:nil forState:UIControlStateNormal];
    
    [self.dayBtn3 setDefaultBorder];
    [self.dayBtn3 setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
    [self.dayBtn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn3 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn3 setTitle:@"7天内发货" forState:UIControlStateNormal];
    [self.dayBtn3 setImage:nil forState:UIControlStateNormal];
    
}
- (IBAction)dayBtn3:(id)sender {
//    self.dayBtn3.backgroundColor = [UIColor btnSelectBackgroundColor];
//    self.dayBtn1.backgroundColor = [UIColor clearColor];
//    self.dayBtn2.backgroundColor = [UIColor clearColor];
    requireDay = @"7";
    [self.dayBtn3 setBorderColor:[UIColor hexChangeFloat:TKColorGreen] borderWidth:2];
    [self.dayBtn3 setTitleColor:[UIColor hexChangeFloat:TKColorGreen] forState:UIControlStateNormal];
    [self.dayBtn3 setLeftTitle:@"7天内发货" rightImage:IMG(@"selected")];
    
    [self.dayBtn2 setDefaultBorder];
    [self.dayBtn2 setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
    [self.dayBtn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn2 setTitle:@"3天内发货" forState:UIControlStateNormal];
    [self.dayBtn2 setImage:nil forState:UIControlStateNormal];
    
    [self.dayBtn1 setDefaultBorder];
    [self.dayBtn1 setTitleColor:[UIColor hexChangeFloat:TKColorBlack] forState:UIControlStateNormal];
    [self.dayBtn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.dayBtn1 setTitle:@"1天内发货" forState:UIControlStateNormal];
    [self.dayBtn1 setImage:nil forState:UIControlStateNormal];
}
- (IBAction)brandSelectClick:(id)sender {
    
    if(!vc)
    {
        vc = [[TKBrandSelectViewController alloc] init];
        vc.selectDelegate = self;
        
    }
    vc.vm.type = 1;
    [vc.vm tkLoadDefaultData];
    
    [[AppDelegate appRootViewController].view addSubview:vc.view];
    //    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)selectCancel
{
    [vc.view removeFromSuperview];
}

-(void)onBrandSelect:(TK_Brand *)brand
{
    selectBrand = brand;
    self.brandText.text = selectBrand.brandName;
    
}

-(void)onCategorySelect:(TK_ShareCategory *)category
{
    selectCategory = category;
    self.categoryText.text = selectCategory.title;
}

- (IBAction)categorySelectAction:(id)sender {
    
    if(!vc)
    {
        vc = [[TKBrandSelectViewController alloc] init];
        vc.selectDelegate = self;
        
    }
    vc.vm.type = 2;
    [vc.vm tkLoadDefaultData];
    
    [[AppDelegate appRootViewController].view addSubview:vc.view];
}

/**
 跟单 悬赏
 **/
-(void)resetFollowView
{
    if(self.showGoodsrowData != nil)
    {
        GetOrderData * row =   self.showGoodsrowData.ackData;
        self.inputText.text = row.content;
        self.priceInputText.text = row.showPrice;
        self.inputText.placehorder.hidden = YES;
        self.brandText.text = row.brandName;
        selectBrand = [[TK_Brand alloc] init];
        selectBrand.brandName = row.brandName;
        selectBrand.brandId = row.brandId;
        selectCategory = [[TK_ShareCategory alloc] init];
        selectCategory.title = row.categoryName;
        selectCategory.categoryId = row.categoryId;
        self.categoryText.text = row.categoryName;
        
        [self.firstPic setURL:row.picAddr1 withStatus:ImageStatus];
        [self.secondPic setURL:row.picAddr1 withStatus:ImageStatus];
        [self.firstPic setUserInteractionEnabled:NO];
        [self.secondPic setUserInteractionEnabled:NO];
    }
    else if(self.rewardData != nil)
    {
        RewardData * row = self.rewardData;
        self.inputText.text = row.content;
        self.priceInputText.text = row.rewardPrice;
        self.inputText.placehorder.hidden = YES;
        self.brandText.text = row.brandName;
        selectBrand = [[TK_Brand alloc] init];
        selectBrand.brandName = row.brandName;
        selectBrand.brandId = row.brandId;
        selectCategory = [[TK_ShareCategory alloc] init];
        selectCategory.title = row.categoryName;
        selectCategory.categoryId = row.categoryId;
        self.categoryText.text = row.categoryName;
        [self.firstPic setURL:row.picAddr1 withStatus:ImageStatus];
        [self.secondPic setURL:row.picAddr1 withStatus:ImageStatus];
        [self.firstPic setUserInteractionEnabled:NO];
        [self.secondPic setUserInteractionEnabled:NO];
    }
}



#pragma  mark  publish 



-(void)TKI_rightBarAction
{
    
    if(self.publishType == 1)
    {
        [self publishShowGoods];
    }
    else
    {
        [self publishReward];
    }
    
    
    
}

-(void)publishShowGoods
{
    [self publishReward];
}

-(void)publishReward
{
    [self hidKeyBord];
    
    // 发布请求
    
    if(image1 == nil && [NSString isStrEmpty:self.firstPic.remoutURL])
    {
        [[HFHUDView shareInstance] ShowTips:@"商品主图不能为空" delayTime:1.0 atView:NULL];
        return;
    }
    if(image2 == nil && [NSString isStrEmpty:self.firstPic.remoutURL])
    {
        [[HFHUDView shareInstance] ShowTips:@"商品吊牌图不能为空" delayTime:1.0 atView:NULL];
        return ;
    }
    
    [self beginSend];
}

/**
 图片上传结果返回
 **/
-(void)onImageUploadSuccess:(NSArray *)acks
{
    BOOL isAnyFailed = NO;
    NSMutableArray * picArray = [[NSMutableArray alloc] init];
    for(TK_UploadImageAck *a in acks)
    {
        if([a sucess])
        {
            [picArray addObject:a.data.imgUrl];
        }else
        {
            isAnyFailed = YES;
        }
    }
    
    if(isAnyFailed)
    {
        [self showLoadingError:@"上传图片失败"];
    }
    else
    {
        TK_PublishRewardArg * arg = [[TK_PublishRewardArg alloc] init];
        if(picArray.count > 0)
        {
            arg.picAddr1 = picArray[0];
        }
        if(picArray.count > 1)
        {
            arg.picAddr2 = picArray[1];
        }
        if(picArray.count > 3)
        {
            arg.picAddr3 = picArray[2];
        }
        if(picArray.count > 4)
        {
            arg.picAddr4 = picArray[3];
        }
        if(picArray.count > 5)
        {
            arg.picAddr5 = picArray[4];
        }
        if(picArray.count > 6)
        {
            arg.picAddr6 = picArray[5];
        }
        if(picArray.count > 7)
        {
            arg.picAddr7 = picArray[6];
        }
        if(picArray.count > 8)
        {
            arg.picAddr8 = picArray[7];
        }
        if(picArray.count > 9)
        {
            arg.picAddr9 = picArray[8];
        }
        
        arg.content = self.inputText.text;
        arg.rewardPrice = self.priceInputText.text;
        arg.source = @"1";// 1 自主发起
        arg.sourceId = [[TKUserCenter instance] getUser].userId;
        arg.categoryId = selectCategory.categoryId;
        arg.brandId = selectBrand.brandId;
        arg.receiverId = ackAddress.id; // 地址id
        arg.requireDay = requireDay;
    
        
        if(self.publishType == 1)
        {
            TKPublishShowGoodsArg *a = [TKPublishShowGoodsArg changeFromRrewardArg:arg];
            [self publishOrder:a];
            
        }else
        {
            [self publishReward:arg];
        }
        
    }
}


/**
 发表晒单
 **/
-(void)publishOrder:( TKPublishShowGoodsArg*) arg
{
    WS(weakSelf)
    [[TKProxy proxy].mainProxy publishShowGoods:arg withBlock:^(HF_BaseAck *ack) {
        if(ack.sucess)
        {
            [weakSelf onPublishSuccess];
        }else
        {
            [weakSelf showLoadingError:ack.msg];
        }
    }];

}

/**
 发布悬赏
 **/

-(void)publishReward:(TK_PublishRewardArg *) arg
{
    WS(weakSelf)
    [[TKProxy proxy].mainProxy publishReward:arg withBlock:^(HF_BaseAck *ack) {
        if(ack.sucess)
        {
            TK_PublishRewardAck * data = (TK_PublishRewardAck *)ack;
            [weakSelf requestPay:data.data.deposit postrewardId:data.data.rewardId];
        }else
        {
            [weakSelf showLoadingError:ack.msg];
        }
    }];
}

/**
 发起支付
 **/
-(void)requestPay:(NSString *) money postrewardId:(NSString *)postId
{
    WS(weakSelf)
    
    if(alertView)
    {
        [alertView removeFromSuperview];
        alertView = nil;
    }
    
    [TKPayProxy selectPayWay:money rewardId:postId fundType:0 withBlock:^(PayResult result) {
        if(result == PaySuccess || result == PayBigMoneySuccess)
        {
            [weakSelf onPublishSuccess];
        }
        else if(result == PayCancel)
        {
            [weakSelf payFailed];
        }
        else
        {
            [weakSelf payFailed];
        }
    }];
}




-(void)beginSend
{
    
    NSString * tips = self.publishType == 1? @"正在发布晒单,请稍等...":@"正在发布悬赏，请稍等...";
    
    alertView = [TKAlertView showHUDWithText:tips];
    
    if(self.showGoodsrowData != nil)
    {
        // 直接发表悬赏， 不上传图片
    
        TK_PublishRewardArg * arg  = [[TK_PublishRewardArg alloc] init];
        arg.content = self.inputText.text;
        arg.rewardPrice = self.priceInputText.text;
        arg.categoryId = selectCategory.categoryId;
        arg.brandId = selectBrand.brandId;
        arg.receiverId = ackAddress.id; // 地址id
        arg.requireDay = requireDay;
        GetOrderData * ack = self.showGoodsrowData.ackData;
        arg.source = @"0";// 1 晒单跟单
        arg.sourceId = ack.id;// 晒单ID
        arg.picAddr1 = ack.picAddr1;
        arg.picAddr2 = ack.picAddr2;
        arg.picAddr3 = ack.picAddr3;
        arg.picAddr4 = ack.picAddr4;
        arg.picAddr5 = ack.picAddr5;
        arg.picAddr6 = ack.picAddr6;
        arg.picAddr7 = ack.picAddr7;
        arg.picAddr8 = ack.picAddr8;
        arg.picAddr9 = ack.picAddr9;
        [self publishReward:arg];
        return;
    }
    else if(self.rewardData != nil)
    {
        TK_PublishRewardArg * arg  = [[TK_PublishRewardArg alloc] init];
        arg.content = self.inputText.text;
        arg.rewardPrice = self.priceInputText.text;
        arg.categoryId = selectCategory.categoryId;
        arg.brandId = selectBrand.brandId;
        arg.receiverId = ackAddress.id; // 地址id
        arg.requireDay = requireDay;
        RewardData * ack = self.rewardData;
        arg.source = @"2";// 1 悬赏 我也要
        arg.sourceId = ack.id;// 悬赏ID
        arg.picAddr1 = ack.picAddr1;
        arg.picAddr2 = ack.picAddr2;
        arg.picAddr3 = ack.picAddr3;
        arg.picAddr4 = ack.picAddr4;
        arg.picAddr5 = ack.picAddr5;
        arg.picAddr6 = ack.picAddr6;
        arg.picAddr7 = ack.picAddr7;
        arg.picAddr8 = ack.picAddr8;
        arg.picAddr9 = ack.picAddr9;
        [self publishReward:arg];
        return;
    }
    
    NSMutableArray * images = [[NSMutableArray alloc] init];
    
    [images addObject:image1];
    [images addObject:image2];
    [images addObjectsFromArray:otherPics];
    WS(weakSelf)
    [[TKProxy proxy].mainProxy uploadMutableImages:images withtype:1 withBlock:^(NSArray * acks) {
        
        [weakSelf onImageUploadSuccess:acks];
    } ];
}


-(void)showLoadingError:(NSString *)msg
{
    
    [alertView removeFromSuperview];
    [TKAlertView showFailedWithTitle:@"发表失败" withMessage:msg commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
    
}

-(void)onPublishSuccess{
    
    [alertView removeFromSuperview];
    NSString * title =  self.publishType == 1?@"晒单成功":@"悬赏成功";
    NSString * msg = self.publishType == 1?nil:@"等待买手接单";
    WS(weakSelf)
    [TKAlertView showSuccessWithTitle:title withMessage:msg commpleteBlock:^(NSInteger buttonIndex) {
        [weakSelf TKI_leftBarAction];
//    [self dismissViewControllerAnimated:YES completion:nil];
    } cancelTitle:nil determineTitle:@"确定"];
    
}

-(void)payFailed
{
    [alertView removeFromSuperview];
    [TKAlertView showFailedWithTitle:@"支付未完成" withMessage:@"支付被取消或者是支付异常" commpleteBlock:nil cancelTitle:nil determineTitle:@"确定"];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma  mark  TKWebViewDelegate

-(void)onAddressChange:(Address *)address
{
    ackAddress = address;
    NSString * string =  [NSString stringWithFormat:@"%@  %@  %@",ackAddress.province,ackAddress.city,ackAddress.address];
    self.addressText.text = string;
}

@end
