//
//  SentPostViewController.m
//  GuanHealth
//
//  Created by hermit on 15/3/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "SentPostViewController.h"
#import "ZYQAssetPickerController.h"
#import "CycleScrollView.h"
#import "PictureCell.h"
#import "UploadRes.h"
#import "NSString+HFStrUtil.h"
#import "FaceBoard.h"
#import "HFSentPostViewModule.h"
#import "ZBMessageInputView.h"
#import "ZBMessageManagerFaceView.h"
#import "HFKeyBoard.h"
#import "ZBMessageTextView.h"
#import "GlobNotifyDefine.h"

@interface SentPostViewController ()<ZYQAssetPickerControllerDelegate,CycleScrollViewDelegate,PictureCellDelegate, FaceBoardDelegate, HFKeyBoardDelegate, UITextFieldDelegate>
{
    CGRect keyboardRect;
    
    double animationDuration;
    
    NSDictionary * _faceMap;
    
    BOOL showKeyBoard;
    
    BOOL firstLogin;
}
@property (nonatomic, copy) NSString *from;

//@property (nonatomic, strong) ZBMessageInputView * mInputView;

//@property (nonatomic, strong) ZBMessageManagerFaceView * faceView;

@property (nonatomic,assign) CGFloat previousTextViewContentHeight;

@property (nonatomic, strong) HFKeyBoard * keyBoard;

@property (nonatomic, strong) UITextField * titleField;

@property (nonatomic, strong) UILabel * discusstionWordNum;

@property (nonatomic, strong) ZBMessageTextView * discusstionTextView;

@property (nonatomic, strong) UIView * smallBgView;
@end


@implementation SentPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.sendPostType == HFSendDiary) {
        [self addRightBarItemWithTitle:@"发表"];
        return;
    }
    [self addRightBarItemWithTitle:@"发送"];
    [self loadUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (firstLogin) {
        firstLogin = NO;
        if (!showKeyBoard) {
            if (self.sendPostType == HFSendDiscussion) {
                [self.titleField becomeFirstResponder];
                return;
            }else {
                [self.textView becomeFirstResponder];
            }
            showKeyBoard = YES;
        }
    }
}
- (void)loadUI
{
    firstLogin = YES;
    
    if (_sendPostType == HFSendDiscussion) {
        [self initDiscussion];
        return;
    }
    pictureWidth = (kScreenWidth-35)/4;
    _picturesArr = [[NSMutableArray alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 110);
    self.tableView.tableHeaderView = self.headerView;
    _from = [self.param objectForKey:kParamFrom];
    if ([_from isEqualToString:FromSudo]) {
        UIImage *shotImage = [self.param objectForKey:kParamImg];
        if (shotImage) {
            [_picturesArr addObject:shotImage];
            [self.tableView reloadData];
        }
    }
    
    self.keyBoard = [[HFKeyBoard alloc] initWithSuperView:self.view withTextView:self.textView];
    self.keyBoard.delegate = self;
    
    self.textView.delegate = self;
    self.textView.placeHolder = @"此刻我想说点什么...";

    if (self.sendPostType == HFSendDiary) {
        [self addNavigationTitle:@"健康日记"];
        self.wordsNumLabel.hidden = YES;
    }else{
        [self addNavigationTitle:@"叨叨一下"];
    }
}
- (void)initDiscussion
{
    pictureWidth = (kScreenWidth-35)/4;
    _picturesArr = [[NSMutableArray alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addNavigationTitle:@"发帖"];
    self.headerView.frame = CGRectMake(0, 5, kScreenWidth - 5, 110 + 40);//增加一个textfield的高度
    _smallBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 5, 110 + 40)];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView addSubview:_smallBgView];
    _from = [self.param objectForKey:kParamFrom];
    if ([_from isEqualToString:FromSudo]) {
        UIImage *shotImage = [self.param objectForKey:kParamImg];
        if (shotImage) {
            [_picturesArr addObject:shotImage];
            [self.tableView reloadData];
        }
    }
    self.titleField.frame = CGRectMake(10, 5, kScreenWidth - 20, 30);

    //添加一条灰色细线
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleField.frame) + 2, kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor HFColorStyle_6];
    [_smallBgView addSubview:lineView];

    self.discusstionTextView = [[ZBMessageTextView alloc] initWithFrame:CGRectMake(5, CGRectGetMinY(self.titleField.frame) + 40, kScreenWidth - 10, 90)];
    [_smallBgView addSubview:self.discusstionTextView];
    self.discusstionTextView.delegate = self;
    self.discusstionTextView.placeHolder = @"在这里写帖子内容...";
    self.discusstionTextView.placeHolderTextColor = [UIColor HFColorStyle_6];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeText:) name:UITextViewTextDidChangeNotification object:nil];
    self.keyBoard = [[HFKeyBoard alloc] initWithSuperView:self.view withTextView:self.discusstionTextView];
    self.keyBoard.delegate = self;
    
    self.wordsNumLabel.hidden = YES;
    self.discusstionWordNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 130, CGRectGetMaxY(self.discusstionTextView.frame), 130, 21)];
    self.discusstionWordNum.font = [UIFont systemFontOfSize:14.0f];
    self.discusstionWordNum.textColor = self.wordsNumLabel.textColor;
    self.discusstionWordNum.text = @"还能输入400个字符";
    [_smallBgView addSubview:self.discusstionWordNum];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didChangeText:(NSNotificationCenter *)notification
{
    if (400-(int)_discusstionTextView.text.length>=0) {
        self.discusstionWordNum.text = [NSString stringWithFormat:@"还能输入%i个字符",400-(int)_discusstionTextView.text.length];
    }else{
        self.discusstionWordNum.text = [NSString stringWithFormat:@"还能输入0个字符"];
    }
}
- (void)leftBarItemAction:(id)sender
{
    [self.textView resignFirstResponder];
    [_discusstionTextView resignFirstResponder];
    [_titleField resignFirstResponder];
    if (self.textView.text.length > 0 || _titleField.text.length > 0) {
        WS(weakSelf)
        HFAlertView *alter = [HFAlertView initWithTitle:@"删除确定" withMessage:@"取消完成会删除当前的图文记录，确认删除？" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                if (weakSelf.popViewController) {
                    [weakSelf.navigationController popToViewController:weakSelf.popViewController animated:YES];
                }else{
                    [super leftBarItemAction:sender];
                }
            }
        } cancelTitle:_T(@"HF_Common_Cancel") determineTitle:@"继续关闭"];
        [alter show];
    }else{
        
        if ([_from isEqualToString:FromUpdatePost]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:PublishSuccessNotification object:FromUpdatePost];
        }
        
        if (self.popViewController) {
            [self.navigationController popToViewController:self.popViewController animated:YES];
        }else{
            [super leftBarItemAction:sender];
        }
    }
    
}

/**
  发送按钮 click事件
 **/
- (void)rightBarItemAction:(id)sender
{
    AFNetworkReachabilityStatus state = [BaseHFHttpClient shareInstance].netState;
    if (state == AFNetworkReachabilityStatusNotReachable || state == AFNetworkReachabilityStatusUnknown) {
        [MBProgressHUD showMessage:@"请检查你的网络设置" toView:nil];
        return;
    }
    [self.textView endEditing:YES];
    [self.discusstionTextView endEditing:YES];
    [self.titleField endEditing:YES];
    HIWeiboType type = 0;
    NSInteger _id = 0;
    SendData * data = [[SendData alloc]init];
    
    if ([_from isEqualToString:FromHabit]) {
        _id = [[self.param objectForKey:kParamHabitId]integerValue];
        type = HIWeiboTypeHabit;
    }else if([_from isEqualToString:FromSudo]){
        _id = HIModuleTypeGame;
        type = HIWeiboTypeModule;
    }else if([_from isEqualToString:FromPersonal]){
        _id = 10000;
        type = HIWeiboTypeModule;
    }else if ([_from isEqualToString:FromPostBar]){
        _id = [[self.param objectForKey:kparamSchemeId] integerValue];
        type = HIWeiboTypePostBar;
    }else if ([_from isEqualToString:FromUpdatePost]) {
        _id = [[self.param objectForKey:kparamSchemeId] integerValue];
        data.tiebaId = [[self.param objectForKey:kParamTiebaId] integerValue];
        type = HIWeiboTypePostBar;
    }
    
    data.id = _id;
    data.type = type;
    data.content = self.textView.text;
    data.picArray = self.picturesArr;
    if (self.sendPostType == HFSendDiscussion) {
        data.title = self.titleField.text;
        data.content = self.discusstionTextView.text;
        if ([self replaceString:data.title].length == 0) {
            HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"标题不能为空" commpleteBlock:^(NSInteger buttonIndex) {
                
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [alter show];
            return;
        }
        if (data.title.length > 20) {
            HFAlertView * alter = [HFAlertView initWithTitle:@"提示" withMessage:@"标题不能超过20个字符" commpleteBlock:^(NSInteger buttonIndex) {
                
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [alter show];
            return;
        }
        if ([self replaceString:data.content].length == 0) {
            HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"内容不能为空" commpleteBlock:^(NSInteger buttonIndex) {
                
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [alter show];
            return;
        }
        if (![UIKitTool checkSensitiveWords:data.title]) {
            HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"你发送的内容含有敏感词汇，请修改后发送。" commpleteBlock:^(NSInteger buttonIndex) {
                
            } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
            [alter show];
            return;
        }
    }
    if ([[[HFSentPostViewModule alloc]init] sendMomentData:data]) {

       [MobClick event:Send_Emotion_Msg];
       [self popViewControllerStack];
    };
}

- (void)popViewControllerStack
{
    if (self.popViewController) {
        [self.navigationController popToViewController:self.popViewController animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addPictureAction:(id)sender
{
    if (_picturesArr.count >= 9) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:_T(@"HF_Common_More_Pictures") commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        return;
    }
    [_textView endEditing:YES];
    [self.keyBoard tapBackgroud];
    [self.titleField resignFirstResponder];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:_T(@"HF_Common_Add_Pictures") delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:_T(@"HF_Common_Take_Picture")];
    }
    [sheet addButtonWithTitle:_T(@"HF_Common_Photo_Album")];
    [sheet setCancelButtonIndex:[sheet addButtonWithTitle:_T(@"HF_Common_Cancel")]];
    [sheet showInView:self.view];
}

- (void)presentImagePickerController
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)presentPhotoLibrary
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9 - _picturesArr.count;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
        {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_picturesArr.count>=9) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"不能一次上传多于9张图片" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        return;
    }
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"拍照"]) {
        [self presentImagePickerController];
    }else if ([title isEqualToString:@"相册"]){
        [self presentPhotoLibrary];
    }
}

#pragma mark - ZYQAssetPickerControllerDelegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = [assets objectAtIndexedSubscript:i];
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        CGImageRef fullResImage = [assetRepresentation fullResolutionImage];
        NSString *adjustment = [[assetRepresentation metadata] objectForKey:@"AdjustmentXMP"];
        if (adjustment) {
            NSData *xmpData = [adjustment dataUsingEncoding:NSUTF8StringEncoding];
            CIImage *image = [CIImage imageWithCGImage:fullResImage];
            
            NSError *error = nil;
            NSArray *filterArray = [CIFilter filterArrayFromSerializedXMP:xmpData
                                                         inputImageExtent:image.extent
                                                                    error:&error];
            CIContext *context = [CIContext contextWithOptions:nil];
            if (filterArray && !error) {
                for (CIFilter *filter in filterArray) {
                    [filter setValue:image forKey:kCIInputImageKey];
                    image = [filter outputImage];
                }
                fullResImage = [context createCGImage:image fromRect:[image extent]];
            }
        }
        UIImage *result = [UIImage imageWithCGImage:fullResImage
                                              scale:[assetRepresentation scale]
                                        orientation:(UIImageOrientation)[assetRepresentation orientation]];
        
        [_picturesArr addObject:[UIKitTool fixOrientation:result]];
        if (i == assets.count-1) {
            [self.tableView reloadData];
        }
    }
}

#pragma UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    [picker.view addSubview:indicatorView];
    [indicatorView startAnimating];
    [self dismissViewControllerAnimated:YES completion:^{
        [indicatorView removeFromSuperview];
    }];
    
    UIImage *image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
    UIImage *configImage = [UIKitTool fixOrientation:image];
    [_picturesArr addObject:configImage];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma CycleScrollViewDelegate

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(NSMutableArray *)index
{
    [UIView animateKeyframesWithDuration:0.2f delay:0.0f options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
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
        [self.tableView reloadData];
    }
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_picturesArr.count<4) {
        return kPictureWidth+10;
    }else if (_picturesArr.count<8){
        return 2*kPictureWidth + 10 + 5;
    }else{
        return 3*kPictureWidth + 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell"];
    if (!cell) {
        cell = [[PictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PictureCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    [cell.addBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell setPicturesToCell:_picturesArr];
    return cell;
}

#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        [self.textView scrollRectToVisible:CGRectMake(0, textView.contentSize.height-15, textView.contentSize.width, 10) animated:NO];
    }
    if (400-(int)textView.text.length>=0) {
        self.wordsNumLabel.text = [NSString stringWithFormat:@"还能输入%i个字符",400-(int)textView.text.length];
    }else{
        self.wordsNumLabel.text = [NSString stringWithFormat:@"还能输入0个字符"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length>=400 && text.length>0) {
        return NO;
    }
    return YES;
}

#pragma picture delegate
- (void)previewPicturesAtIndex:(NSInteger)index
{
    [self.keyBoard tapBackgroud];
    [self.titleField resignFirstResponder];
    CycleScrollView *cycle = [[CycleScrollView alloc]initWithFrame:kScreenBounds cycleDirection:CycleDirectionLandscape pictures:_picturesArr startIndex:(int)index];
    cycle.alpha = 0;
    cycle.delegate = self;
    [[UIKitTool getAppdelegate].window addSubview:cycle];
    [UIView animateWithDuration:0.12f animations:^{
        cycle.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

//- (void)hf_keyBoardReportHeight:(CGFloat)keyboardHeight
//{
//    //mBgScrollView.frame = CGRectMake(0, mBgScrollView.frame.origin.y, mBgScrollView.frame.size.width, self.view.frame.size.height - keyboardHeight);
//}

//- (NSString *)hf_textViewPlaceholder
//{
//    return @"此刻我想说点什么...";
//}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:self.textView]) {
        [self.titleField resignFirstResponder];
        [self.keyBoard tapBackgroud];
    }
}
#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyBoard dismissKeyboard];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -
#pragma mark privateFunction
- (NSString *)replaceString:(NSString *)string
{
    NSString * str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}
- (UITextField *)titleField
{
    if (!_titleField) {
        _titleField = [[UITextField alloc] init];
        self.titleField.placeholder = @" 请输入标题(20个字符)";
        self.titleField.delegate = self;
        self.titleField.font = [UIFont systemFontOfSize:16];
        [_smallBgView addSubview:self.titleField];
    }
    return _titleField;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
