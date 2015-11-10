//
//  HFEditDiaryViewController.m
//  GuanHealth
//
//  Created by zhuxiaoxia on 15/8/5.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFEditDiaryViewController.h"
#import "ZBMessageTextView.h"
#import "HFKeyBoard.h"
#import "CycleScrollView.h"
#import "UploadRes.h"
#import "PublishUserDiaryArg.h"
#import "LoadSchemeDataAck.h"
#import "NSString+HFStrUtil.h"

@interface HFEditDiaryViewController ()<HFKeyBoardDelegate,CycleScrollViewDelegate, UIScrollViewDelegate>
{
    UIButton *addBtn;
    UILabel *tipLabel;
    BOOL showKeyBoard;
}

@property (nonatomic, strong) ZBMessageTextView *textView;
@property (nonatomic, strong) HFKeyBoard * keyBoard;
@property (nonatomic, strong) NSMutableArray *pictureArr;

@end

@implementation HFEditDiaryViewController
@synthesize textView = _textView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationTitle:@"健康日记"];
    [self addRightBarItemWithTitle:@"发表"];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = scrollView.frame.size;
    scrollView.alwaysBounceVertical = YES;
    scrollView.alwaysBounceHorizontal = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    _textView = [[ZBMessageTextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 110)];
    _textView.placeHolder = @"此刻我想说点什么";
    [scrollView addSubview:_textView];
    
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(15, 120, 65, 65);
    [addBtn setBackgroundImage:IMG(@"addPhotos") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(getPicture:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addBtn];
    
    tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 200 - 15, CGRectGetMaxY(_textView.frame), 200, 20)];
    [tipLabel setFont:[UIFont systemFontOfSize:14.0f]];
    tipLabel.textAlignment = NSTextAlignmentRight;
    [tipLabel setTextColor:[UIColor HFColorStyle_5]];
    tipLabel.text = @"还能输入400个字符";
    [scrollView addSubview:tipLabel];
    
    self.keyBoard = [[HFKeyBoard alloc] initWithSuperView:self.view withTextView:_textView];
    self.keyBoard.delegate = self;

    
    [self.textView addObserver:self forKeyPath:@"textLenght" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!showKeyBoard) {
        [self.textView becomeFirstResponder];
        showKeyBoard = YES;
    }
}

- (void)dealloc
{
    [self.textView removeObserver:self forKeyPath:@"textLenght" context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarItemAction:(id)sender
{
    if (self.textView.text.length > 0 || self.pictureArr.count > 0) {
        [self.keyBoard tapBackgroud];
        HFAlertView *alter = [HFAlertView initWithTitle:@"删除确定" withMessage:@"取消完成会删除当前的图文记录，确认删除？" commpleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [super leftBarItemAction:sender];
            }
        } cancelTitle:_T(@"HF_Common_Cancel") determineTitle:@"继续关闭"];
        [alter show];
    }else {
        [super leftBarItemAction:sender];
    }
}

- (void)rightBarItemAction:(id)sender
{
    //发表
    [self.keyBoard tapBackgroud];
    if (![UIKitTool checkSensitiveWords:_textView.text]) {
        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:@"你发送的内容含有敏感词汇，请修改后发送。" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
        [alter show];
        
        return;
    }
    if (_textView.text.length>400) {
        HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"发表内容不能超火400个字符" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:@"确定"];
        [alter show];
        return;
    }
    
    NSString *content = [_textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (content.length==0) {
        HFAlertView *alter = [HFAlertView initWithTitle:@"提示" withMessage:@"不能发表空内容" commpleteBlock:^(NSInteger buttonIndex) {
            
        } cancelTitle:nil determineTitle:@"确定"];
        [alter show];
        return;
    }
    
    if (_pictureArr.count>0) {
        WS(weakSelf)
        [[NetHTTPClient shareInstance]uploadImage:[_pictureArr firstObject] type:HIUploadImageTypeDiary callback:^(ResponseData *responseData) {
            if ([responseData success]) {
                UploadRes *res = (UploadRes*)responseData;
                [weakSelf uploadDiaryWithPicture:res.path content:_textView.text];
            }
        }];
        
    }else {
        [self uploadDiaryWithPicture:nil content:_textView.text];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"textLenght"]) {
        if (400-(int)self.textView.textLenght >= 0) {
            tipLabel.text = [NSString stringWithFormat:@"还能输入%i个字符",400-(int)self.textView.textLenght];
        }else{
            tipLabel.text = [NSString stringWithFormat:@"还能输入0个字符"];
            if (IOS8VERSION) {
                NSString *string = [self.textView.text copy];
                self.textView.text = [string substringToIndex:400];
            }
           
        }
    }
}

- (void)uploadDiaryWithPicture:(NSString *)path content:(NSString *)content
{
    PublishUserDiaryArg *arg = [[PublishUserDiaryArg alloc]init];
    arg.schemeId = self.schemeData.schemeId;
    arg.day = self.schemeData.currDay;
    arg.picAddr = path;
    arg.content = [content URLEncodedForString];
    WS(weakSelf)
    [[[HIIProxy shareProxy]schemeProxy]publishUserDiary:arg withBlock:^(HF_BaseAck *ack) {
        if (ack.recode == 1) {
            
            
            if (_delegate && [_delegate respondsToSelector:@selector(retPushDiraySuccess)])
            {
                [_delegate retPushDiraySuccess];
            }

            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

//弹出actionsheet
- (void)getPicture:(UIButton *)btn
{
    [self.keyBoard tapBackgroud];
    if (self.pictureArr.count) {
        [self previewPicture];
    }else {
        [self doSelectPic:@"添加图片" clipping:NO maxSelect:1];
    }
}

- (void)onOneImageBack:(UIImage *)image
{
    if (image) {
        [self.pictureArr addObject:image];
        [addBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

//预览图片
- (void)previewPicture
{
    CycleScrollView *cycle = [[CycleScrollView alloc]initWithFrame:kScreenBounds cycleDirection:CycleDirectionLandscape pictures:_pictureArr startIndex:1];
    cycle.alpha = 0;
    cycle.delegate = self;
    [[UIKitTool getAppdelegate].window addSubview:cycle];
    [UIView animateWithDuration:0.12f animations:^{
        cycle.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSMutableArray *)pictureArr
{
    if (!_pictureArr) {
        _pictureArr = [[NSMutableArray alloc]init];
    }
    return _pictureArr;
}

#pragma mark - CycleScrollViewDelegate

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(NSMutableArray *)index
{
    
    [UIView animateKeyframesWithDuration:0.2f delay:0.0f options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        cycleScrollView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [cycleScrollView removeFromSuperview];
        }
    }];
    NSString *str = [index objectAtIndex:0];
    if ([str isEqualToString:@"0"]) {
        [_pictureArr removeAllObjects];
        [addBtn setBackgroundImage:IMG(@"btn_add") forState:UIControlStateNormal];
    }
}
#pragma mark - UIScrollDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isEqual:self.textView]) {
        [self.textView resignFirstResponder];
    }
}
@end
