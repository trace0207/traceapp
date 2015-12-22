//
//  TK_UploadImageArg.m
//  tracedemo
//
//  Created by 罗田佳 on 15/12/21.
//  Copyright © 2015年 trace. All rights reserved.
//

#import "TK_UploadImageArg.h"
#import "TK_HttpFileData.h"

@interface TK_UploadImageArg()<TK_HttpFileProtocol>
{
    TK_HttpFileData * fileData;
    
}

@end


@implementation TK_UploadImageArg


-(TK_HttpFileData *)tkGetFileData
{
    if(!fileData)
    {
        fileData = [[TK_HttpFileData alloc] init];
        fileData.name = @"img";
        fileData.displayName = @"img.jpg";
        fileData.type = @"image/jpeg";
    }
    fileData.tkData = UIImageJPEGRepresentation(self.image, 0.5);
    return fileData;
}

@end
