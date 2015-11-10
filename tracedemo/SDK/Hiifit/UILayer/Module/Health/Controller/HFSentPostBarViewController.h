//
//  HFSentPostBarViewController.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/9/9.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ZBMessageTextView.h"
#define FromHabit @"fromHabit"
#define FromSudo  @"fromSudo"
#define FromPersonal  @"fromPersonal"
#define FromPostBar @"fromPostBar"

@protocol HFSentPostBarDelegate <NSObject>
- (void)refreshPostBar;

@end
@interface HFSentPostBarViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    CGFloat pictureWidth;
}

@property (nonatomic, strong)          UIViewController *popViewController;
@property (nonatomic, strong)          NSMutableArray  *picturesArr;
//@property (nonatomic, strong) IBOutlet UILabel         *placehordLable;
@property (nonatomic,   weak)          id<HFSentPostBarDelegate>delegate;
@property (nonatomic, assign) HFSendPostType sendPostType;

@end
