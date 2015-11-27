//
//  TKPublishShowGoodsVC.m
//  tracedemo
//
//  Created by 罗田佳 on 15/11/26.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TKPublishShowGoodsVC.h"
#import "PictureCell.h"



@interface TKPublishShowGoodsVC ()
{

    CGFloat pictureWidth;
}

@end

@implementation TKPublishShowGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   CGRect  screenSize =  CGRectMake(0,0,TKScreenWidth, TKScreenHeight);
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:screenSize];
    [self.view addSubview:_rootScrollView];
    _mainContentView.frame = CGRectMake(0, 0, TKScreenWidth,TKScreenHeight);
    [_rootScrollView addSubview:_mainContentView];
    _rootScrollView.directionalLockEnabled = YES;
    _rootScrollView.alwaysBounceVertical = YES;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    
//    _rootScrollView.backgroundColor = [UIColor blueColor];
    
    [self resetContentSize];
    [self loadImageViewField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetContentSize{

    CGSize contentSize = CGSizeMake(self.view.frame.size.width, _mainContentView.frame.size.height);
    [_rootScrollView setContentSize:contentSize];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self TKI_setBarRightDefaultText:@"发布"];
}


-(NSString *)TK_getBarTitle{

    return @"发布晒单";
}

-(void)TKI_rightBarAction{

    [[HFHUDView shareInstance] ShowTips:@"发布晒单成功" delayTime:1.0 atView:NULL];
    [self TKI_leftBarAction];
}

-(void)TKI_leftBarAction{
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromBottom;//可更改为其他方式 [self.navigationController.view.layeraddAnimation:transition forKey:kCATransition];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}



- (void)addPictureAction:(id)sender
{
//    if (_picturesArr.count >= 9) {
//        HFAlertView *alter = [HFAlertView initWithTitle:_T(@"HF_Common_Tips") withMessage:_T(@"HF_Common_More_Pictures") commpleteBlock:^(NSInteger buttonIndex) {
//            
//        } cancelTitle:nil determineTitle:_T(@"HF_Common_OK")];
//        [alter show];
//        return;
//    }
//    [_textView endEditing:YES];
//    [self.keyBoard tapBackgroud];
//    [self.titleField resignFirstResponder];
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:_T(@"HF_Common_Add_Pictures") delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        [sheet addButtonWithTitle:_T(@"HF_Common_Take_Picture")];
//    }
//    [sheet addButtonWithTitle:_T(@"HF_Common_Photo_Album")];
//    [sheet setCancelButtonIndex:[sheet addButtonWithTitle:_T(@"HF_Common_Cancel")]];
//    [sheet showInView:self.view];
}


-(void)loadImageViewField{

    
    pictureWidth = (kScreenWidth-35)/4;
    _picturesArr = [[NSMutableArray alloc]init];
    PictureCell *cell = [[PictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PictureCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.addBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_picContainer addSubview:cell];
    
 
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(_picContainer);
        make.height.equalTo(_picContainer);
        make.top.equalTo(_picContainer);
        make.left.equalTo(_picContainer);
        
    }];
    
   
    
    
    [cell setPicturesToCell:_picturesArr];
    
    [_picContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(pictureWidth+120);// pictureWidth;
    }];
    
    [_picContainer updateConstraints];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (void)setPicturesToCell:(NSArray *)pictures
//{
//    //    if (pictures.count == 0) {
//    //        self.placehordLable.hidden = NO;
//    //    }else{
//    //        self.placehordLable.hidden = YES;
//    //    }
//    for (int i = 0; i < 9; i++) {
//        UIImageView *imgView = (UIImageView*)[self viewWithTag:i+100];
//        if (imgView) {
//            [imgView removeFromSuperview];
//        }
//    }
//    
//    for (int i=0; i<pictures.count; i++) {
//        UIImage *tempImg = [pictures objectAtIndex:i];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i%4*(kPictureWidth+5)+10, (i/4)*(kPictureWidth+5)+5, kPictureWidth, kPictureWidth)];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
//        imageView.image = tempImg;
//        imageView.tag = i+100;
//        imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preview:)];
//        [imageView addGestureRecognizer:tap];
//        [self addSubview:imageView];
//    }
//    if (pictures.count == 9) {
//        self.addBtn.hidden = YES;
//    }else{
//        self.addBtn.hidden = NO;
//    }
//    WS(weakSelf);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        weakSelf.addBtn.frame = CGRectMake(10+(pictures.count%4)*(kPictureWidth+5), ((kPictureWidth+5)*(pictures.count/4)+5), kPictureWidth, kPictureWidth);
//    });
//}

@end
