//
//  TK_PublishMakeSureView.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/1.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface TK_PublishMakeSureView : BaseView
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UILabel *loadingTips;
@property (strong, nonatomic) IBOutlet UIImageView *errorImage;
- (IBAction)cancelAction:(id)sender;

@property (strong,nonatomic) NSObject * publishData;


@end
