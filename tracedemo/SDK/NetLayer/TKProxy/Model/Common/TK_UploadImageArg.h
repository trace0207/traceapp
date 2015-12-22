//
//  TK_UploadImageArg.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/21.
//  Copyright © 2015年 trace. All rights reserved.
//

@interface TK_UploadImageArg : HF_BaseArg


@property (nonatomic,strong)UIImage<Ignore> * image;
@property (nonatomic,assign)NSInteger fileType;
@property (nonatomic,assign)NSInteger needCompress;

@end
