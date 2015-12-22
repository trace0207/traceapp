//
//  TK_UploadImageAck.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/21.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "HF_BaseAck.h"

@interface UPloadImageData : TK_BaseJsonModel

@property (nonatomic,strong) NSString * imgUrl;
@end

@interface TK_UploadImageAck : HF_BaseAck

@property (strong,nonatomic) UPloadImageData * data;

@end
