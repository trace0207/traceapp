//
//  SentPostViewController.h
//  GuanHealth
//
//  Created by hermit on 15/3/30.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableViewController.h"
#import "ZBMessageTextView.h"
#define FromHabit @"fromHabit"
#define FromSudo  @"fromSudo"
#define FromPersonal  @"fromPersonal"
#define FromPostBar @"fromPostBar"
#define FromUpdatePost @"fromUpdatePost"

//@protocol HFSentPostSuccessDelegate <NSObject>
//
//- (void)refreshPosts;
//
//@end

@interface SentPostViewController : BaseTableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    CGFloat pictureWidth;
}
@property (nonatomic, strong)          UIViewController *popViewController;
@property (nonatomic, strong)          NSMutableArray  *picturesArr;
@property (nonatomic, strong) IBOutlet UIView          *headerView;
@property (nonatomic, strong) IBOutlet ZBMessageTextView      *textView;
@property (nonatomic, strong) IBOutlet UILabel         *wordsNumLabel;
//@property (nonatomic,   weak)          id<HFSentPostSuccessDelegate>delegate;
@property (nonatomic, assign) HFSendPostType sendPostType;
@end
