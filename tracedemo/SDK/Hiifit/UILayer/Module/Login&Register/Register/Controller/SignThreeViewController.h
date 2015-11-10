//
//  SignThreeViewController.h
//  GuanHealth
//
//  Created by hermit on 15/2/27.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@interface SignThreeViewController : BaseViewController
{
    int sex;
}

@property (weak, nonatomic) IBOutlet UIButton    *boyBtn;
@property (weak, nonatomic) IBOutlet UIButton    *girlBtn;
@property (weak, nonatomic) IBOutlet UIImageView *boyImage;
//@property (weak, nonatomic) IBOutlet UILabel     *boyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *girlImage;
//@property (weak, nonatomic) IBOutlet UILabel     *girlLabel;

- (IBAction)chooseBoyAction:(id)sender;
- (IBAction)chooseGirlAction:(id)sender;

@end
