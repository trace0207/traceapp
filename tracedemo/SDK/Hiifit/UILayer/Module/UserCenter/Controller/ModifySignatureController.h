//
//  ModifySignatureController.h
//  GuanHealth
//
//  Created by hermit on 15/5/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseViewController.h"

@protocol ModifySignatureControllerDelegate <NSObject>

- (void)finishModify;

@end
@interface ModifySignatureController : BaseViewController

@property (nonatomic, weak) id<ModifySignatureControllerDelegate>delegate;
@property (nonatomic, weak)   IBOutlet       UITextView   *textView;
@property (nonatomic, weak)   IBOutlet       UILabel      *placehorderLabel;
@property (nonatomic, weak)   IBOutlet       UILabel      *wordsNumLabel;
//@property (nonatomic, weak)   IBOutlet       UIView       *bgView;

@end
