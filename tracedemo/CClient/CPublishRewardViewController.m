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


#define PICONE 101
#define PICSecond 102
#define PIC_ADD 103

@interface CPublishRewardViewController ()<TKPicSelectDelegate,CycleScrollViewDelegate,ZHPickViewDelegate,
UITextFieldDelegate,UITextViewDelegate,TKClearViewDelegate,HFKeyBoardDelegate,BrandSelectDelegate>
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
    defaultHeight = TKScreenHeight - 20;
    requireDay = @"3";
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
    self.clearView.clearDelegate = self;
    
    picWidth = (TKScreenWidth -  (picCountInLine+1)* picWiteSpaceWidth )/ picCountInLine;
    self.hidDefaultBackBtn = YES;
    self.navTitle = @"发布悬赏";
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
    [self resetPicField];
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
        
        int x = (i+2)%3;
        int y = (i+2)/3;
        
        CGRect frame = CGRectMake(picWiteSpaceWidth + x*(picWiteSpaceWidth + picWidth), picTopAndBtomPadding + y*(picWiteSpaceWidth + picWidth), picWidth, picWidth);
        [box setStatus:NormalImage];
        box.mainImage.image = [otherPics objectAtIndex:i];
        box.frame = frame;
        [self.imageContaner addSubview:box];
    }
    
    if(otherPics.count < 7)
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
//    [TKNotifycationViewController showNotifyCation:@"测试通知"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    [self TKI_leftBarAction];
    
}

-(void)TKI_rightBarAction
{
    
    [self hidKeyBord];
    
    // 发布请求
    
    if(image1 == nil)
    {
        DDLogInfo(@"iamge1 is nil");
        return;
    }
    if(image2 == nil)
    {
        DDLogInfo(@"image2 is nil");
        return ;
    }

    [self beginSend];
    
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
    self.dayBtn1.backgroundColor = [UIColor btnSelectBackgroundColor];
    self.dayBtn2.backgroundColor = [UIColor clearColor];
    self.dayBtn3.backgroundColor = [UIColor clearColor];
    requireDay = @"1";
    
}
- (IBAction)dayBtn2:(id)sender {
    
    self.dayBtn2.backgroundColor = [UIColor btnSelectBackgroundColor];
    self.dayBtn1.backgroundColor = [UIColor clearColor];
    self.dayBtn3.backgroundColor = [UIColor clearColor];
    requireDay = @"3";
    
}
- (IBAction)dayBtn3:(id)sender {
    self.dayBtn3.backgroundColor = [UIColor btnSelectBackgroundColor];
    self.dayBtn1.backgroundColor = [UIColor clearColor];
    self.dayBtn2.backgroundColor = [UIColor clearColor];
    requireDay = @"7";
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



#pragma  mark  publish 

/**
 图片上传结果返回
 **/
-(void)onImageUploadSuccess:(NSArray *)acks
{
    
    //        DDLogInfo(@"upload images array %@",acks);
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
        
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showLoadingError) object:nil];
        [self showLoadingError:@"上传图片失败"];
        
    }
    else
    {
        
//        self.images = nil;
        
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
    
        
        
        WS(weakSelf)
        [[TKProxy proxy].mainProxy publishReward:arg withBlock:^(HF_BaseAck *ack) {
            if(ack.sucess)
            {
                TK_PublishRewardAck * a = (TK_PublishRewardAck*)ack;
                [weakSelf requestPay:a.data.deposit postrewardId:a.data.rewardId];
            }
            else
            {
             
                [weakSelf showLoadingError:ack.msg];
            }
        }];
    }
}



-(void)requestPay:(NSString *) money postrewardId:(NSString *)postId
{
    
    TK_PayArg * arg = [[TK_PayArg alloc] init];
    arg.bigMoney = 0;
    arg.payAmount = money;
    
    arg.postrewardId = postId;
    arg.fundType = 0;//0 订金， 1 尾款， 2全款， 3 买手充值保证金
    //    arg.clientIp = @"192.168.1.1";
    
    WS(weakSelf)
    
    [TKPayProxy pay:arg
          withBlick:^(NSInteger result) {
              if(result == 1)
              {
//                  weakSelf.images = nil;
                  [weakSelf onPublishSuccess];
              }
              else
              {
                  
              }
          }];
}




-(void)beginSend
{
    
    alertView = [TKAlertView showHUDWithText:@"正在发布悬赏，请稍等"];
    
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
    
    [TKAlertView showSuccessWithTitle:@"发表悬赏成功" withMessage:nil commpleteBlock:^(NSInteger buttonIndex) {
    [self dismissViewControllerAnimated:YES completion:nil];
    } cancelTitle:nil determineTitle:@"确定"];
    
}

@end
