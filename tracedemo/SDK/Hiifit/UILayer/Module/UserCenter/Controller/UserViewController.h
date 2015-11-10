//
//  UserViewController.h
//  GuanHealth
//
//  Created by hermit on 15/5/4.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableViewController.h"

@interface UserViewController : BaseTableViewController<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableViewCell *headCell;

@property (nonatomic, strong) IBOutlet UIImageView *headImage;

- (IBAction)seeBigHeadImage:(id)sender;

@end
