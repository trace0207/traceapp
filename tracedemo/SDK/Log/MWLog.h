//
//  MWLog.h
//  MobileWallet
//
//  Created by luotianjia on 15/5/20.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#ifndef MobileWallet_MWLog_h
#define MobileWallet_MWLog_h

#import "CocoaLumberjack.h"
#import "MWLogFormatter.h"

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelInfo;
#endif


#endif
