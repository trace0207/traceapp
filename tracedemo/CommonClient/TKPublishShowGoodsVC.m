//
//  TKPublishShowGoodsVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/26.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKPublishShowGoodsVC.h"
#import "PictureCell.h"
#import "TK_PicAddView.h"
#import "CycleScrollView.h"
#import "ZYQAssetPickerController.h"
#import "ZHPickView.h"
#import "HFKeyBoard.h"
#import "TKUserCenter.h"
#import "TK_PublishMakeSureView.h"
#import "TKPicSelectTool.h"


static NSString * textDefault = @"此时此刻，分享你的宝贝心得吧";

@interface TKPublishShowGoodsVC ()
<TK_PicAddDelegate,TKPicSelectDelegate,CycleScrollViewDelegate,ZHPickViewDelegate,
UITextFieldDelegate,UITextViewDelegate,TKClearViewDelegate,HFKeyBoardDelegate>
{
    
    CGFloat pictureWidth;
    TK_PicAddView * picAddView;
    TK_ShareCategory * shareCategory;
    UITextField * editTextField;
    CGFloat  scrollOffest;
    TKPicSelectTool * picTool;
    

}

@property (nonatomic, strong) HFKeyBoard * keyBoard;
@end

@implementation TKPublishShowGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _picLoadingView.hidden = YES;
    CGRect  screenSize =  CGRectMake(0,0,TKScreenWidth, TKScreenHeight);
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:screenSize];
    [_rootScrollView setContentSize:screenSize.size];
    _mainContentView.frame = CGRectMake(0, 0, TKScreenWidth,TKScreenHeight);
    [_rootScrollView addSubview:_mainContentView];
    _rootScrollView.directionalLockEnabled = YES;
    _rootScrollView.alwaysBounceVertical = YES;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_rootScrollView];
    [_rootScrollView addSubview:_mainContentView];
    [self loadImageViewField];
    _picturesArr = [[NSMutableArray alloc] init];

    _tabViewForCloseKeybord.clearDelegate = self;
    
    self.inputTextView.delegate = self;
    self.inputTextView.font = [UIFont systemFontOfSize:16];
    self.inputTextView.placeHolderTextColor = [UIColor grayColor];
    self.inputTextView.placeHolder = textDefault;

    if([self showKeyBoard])

    {
        self.keyBoard = [[HFKeyBoard alloc] initWithSuperView:self.view withTextView:self.inputTextView];
        self.keyBoard.delegate = self;
        self.inputTextView.delegate = self;
    }
    
    self.countTextView.enabled = NO;
    self.tagPriceTextView.delegate = self;
    self.willByPrice.delegate = self;
    self.goodColorView.delegate = self;
    self.goodSizeView.delegate = self;
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self TKI_setBarRightDefaultText:@"发布"];
}

-(NSString *)navTitle
{

    return @"发布晒单";
}


-(void)TKI_leftBarAction{
//    CATransition* transition = [CATransition animation];
//    transition.type = kCATransitionPush;//可更改为其他方式
//    transition.subtype = kCATransitionFromBottom;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  加载图片
 */
-(void)tkReloadePic
{
    [_picLoadingView stopAnimating];
    _picLoadingView.hidden = YES;
    [picAddView tkReloadWithDefaultPic:_picturesArr];
    // 更新 容器高度和 scrollView的 contentsize
    [self resetContentSize];
    
}


/**
 *  更新 容器高度和 scrollView的 contentsize
 */
-(void)resetContentSize
{
    CGFloat newHeight = [picAddView tkGetViewsHeight];
    CGRect frame = CGRectMake(picAddView.frame.origin.x
                              , picAddView.frame.origin.y
                              , picAddView.frame.size.width, newHeight);
    picAddView.frame = frame;
    [picAddView layoutIfNeeded];
    _picHeight.constant = newHeight;

    [_rootScrollView setContentSize:CGSizeMake(TKScreenWidth,TKScreenHeight +  newHeight - 80 * TKScreenScale)];
    
}




-(void)loadImageViewField{
    picAddView = [[TK_PicAddView alloc]initDefaultAdd];
    picAddView.tkAddDelegate = self;
    [_picContainer addSubview:picAddView];
//    [self resetContentSize];
}


#pragma mark  TKPicSelectDelegate

-(void)onImageSelect:(UIImage *)image
{
    [_picturesArr addObject:image];
    [self tkReloadePic];
}
-(void)onImagesSelect:(NSArray *)images
{
    [_picturesArr addObjectsFromArray:images];
    [self tkReloadePic];
}

-(void)onLoadingImage
{
    [_picLoadingView startAnimating];
    _picLoadingView.hidden = NO;
}
#pragma  mark ---------  addPick delegate
-(void)onAddBtnAction
{
    if(!_picLoadingView.hidden)
    {
        return;
    }
    if (_picturesArr.count >= 9) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips")
                                            withMessage:_T(@"HF_Common_More_Pictures")
                                         commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        return;
    }
    
    if(!picTool)
    {
        picTool = [[TKPicSelectTool alloc]init];
        picTool.selectDelegate = self;
        picTool.viewController = self;
    }
    [picTool doSelectPic:@"添加图片" clipping:NO maxSelect:9-_picturesArr.count];
    
}

-(void)tkPreviewPicturesAtIndex:(NSInteger)index
{
    CycleScrollView *cycle = [[CycleScrollView alloc]initWithFrame:kScreenBounds
                                                    cycleDirection:CycleDirectionLandscape
                                                          pictures:_picturesArr
                                                        startIndex:(int)index];
    cycle.alpha = 0;
    cycle.delegate = self;
    [[UIKitTool getAppdelegate].window addSubview:cycle];
    [UIView animateWithDuration:0.12f animations:^{
        cycle.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma CycleScrollViewDelegate

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView
             didSelectImageView:(NSMutableArray *)index
{
    [UIView animateKeyframesWithDuration:0.2f
                                   delay:0.0f
                                 options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{
                                  cycleScrollView.alpha = 0.0f;
                              } completion:^(BOOL finished) {
                                  if (finished) {
                                      [cycleScrollView removeFromSuperview];
                                  }
                              }];
    int flag = 0;
    for (int i = 0; i < index.count; i++) {
        NSString *str = [index objectAtIndex:i];
        if ([str isEqualToString:@"0"]) {
            [_picturesArr removeObjectAtIndex:i-flag];
            flag = flag + 1;
        }
    }
    if (flag) {
        [self tkReloadePic];
    }
}


#pragma  mark clearDelegate

-(void)onClearViewEvent
{
    if(editTextField)
    {
        [editTextField resignFirstResponder];
        self.rootScrollView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        editTextField = nil;
    }else{
        [self.inputTextView resignFirstResponder];
    }
    
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
//    if (textView.text.length>0) {
//        [self.textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-15, textView.contentSize.width, 10) animated:NO];
//    }
    
    if(textView.text.length > 0)
    {
        self.inputTextView.placeHolder = @"";
    }
    else
    {
        self.inputTextView.placeHolder = textDefault;
    }
    
    if (400-(int)textView.text.length>=0) {
        self.textCountView.text = [NSString stringWithFormat:@"还能输入%i个字符",400-(int)textView.text.length];
    }else{
        self.textCountView.text = [NSString stringWithFormat:@"还能输入0个字符"];
    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }[|
    
    
    if (textView.text.length>=400 && text.length>0) {
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    CGRect rect =   [textField.superview convertRect:textField.frame toView:self.view];
    int offset =  216 + rect.origin.y - self.view.frame.size.height + 85;
    //rect.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
    {
       self.rootScrollView.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
       scrollOffest = offset;
    }
    
    editTextField = textField;
    
    
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    editTextField  = nil;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.rootScrollView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}



#pragma  mark  ZHPickViewDelegate

-(void)tkTooBarComplete:(NSObject *)obj
{
    DDLogInfo(@"select complete %@",obj);
    if(obj && [obj isKindOfClass:[TK_ShareCategory class]])
    {
        shareCategory = (TK_ShareCategory *)obj;
        _typeTextView.text = shareCategory.title;
    }
}



#pragma mark  private method
- (IBAction)typeBtnEvent:(UIButton *)sender {
    NSArray * array = [TKUserCenter instance].userNormalVM.shareCategorys;
    ZHPickView * picker = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:YES];
    picker.delegate = self;
    picker.cell = nil;
    [picker show];

    
}

/*
  发布晒单
 */
-(void)TKI_rightBarAction
{
    
//    if(!shareCategory)
//    {
//        [[HFHUDView shareInstance] ShowTips:@"请选择品类" delayTime:1.0 atView:NULL];
//        return;
//    }
//    else if(self.inputTextView.text.length == 0)
//    {
//        [[HFHUDView shareInstance] ShowTips:@"请输入描述信息" delayTime:1.0 atView:NULL];
//        return;
//    }else if(self.picturesArr.count == 0)
//    {
//        [[HFHUDView shareInstance] ShowTips:@"请选择图片" delayTime:1.0 atView:NULL];
//        return;
//    }
    
    TK_PublishMakeSureView * popView = [[TK_PublishMakeSureView alloc]init];
    [self onClearViewEvent];
    
    NSArray * pics = [[NSArray alloc] initWithArray:self.picturesArr];
    popView.images = pics;
    popView.content = self.inputTextView.text;
    popView.showPrice =  [self.willByPrice.text integerValue] * 100;
    
    [[AppDelegate getAppDelegate].window addSubview:popView];
    
    
    [popView beginSend];
    self.picturesArr = nil;
    
    
//    [[HFHUDView shareInstance] ShowTips:@"发布晒单成功" delayTime:1.0 atView:NULL];
}

- (IBAction)countAddAction:(id)sender {
    
    NSInteger value = [_countTextView.text intValue];
    value ++ ;
//    NSString *text = [NSNumber numberWithLong:value].stringValue;
    NSString * text = [NSString stringWithFormat: @"%ld", value];
    _countTextView.text = text;
}

- (IBAction)countMinusAction:(id)sender {
    NSInteger value =  [_countTextView.text intValue];
    if(value <=1)
    {
        return;
    }
    _countTextView.text = [NSNumber numberWithLong:--value].stringValue;
}

-(BOOL)showKeyBoard
{
    return true;
}

@end
