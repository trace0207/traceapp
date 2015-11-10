//
//  IParser.h
//  frame
//
//  Created by sjxu on 13-3-15.
//  Copyright (c) 2013年 sjxu. All rights reserved.
//

#ifndef frame_IParser_h
#define frame_IParser_h

@class ResponseData;

typedef ResponseData* (^ParseBlock)(NSDictionary *json);

#endif
