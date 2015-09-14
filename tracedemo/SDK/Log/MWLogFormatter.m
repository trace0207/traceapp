//
//  MWLogFormatter.m
//  MobileWallet
//
//  Created by luotianjia on 15/5/20.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import "MWLogFormatter.h"

@interface MWLogFormatter()
{
    NSDateFormatter *_dateFormatter;
}

@end

@implementation MWLogFormatter

- (id)init
{
    return [self initWithDateFormatter:nil];
}

- (id)initWithDateFormatter:(NSDateFormatter *)aDateFormatter
{
    if ((self = [super init]))
    {
        if (aDateFormatter)
        {
            _dateFormatter = aDateFormatter;
        }
        else
        {
            _dateFormatter = [[NSDateFormatter alloc] init];
            [_dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4]; // 10.4+ style
            [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        }
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *dateAndTime = [_dateFormatter stringFromDate:(logMessage->_timestamp)];
    NSString* file = [[logMessage->_file stringByAppendingPathComponent:@"/"] lastPathComponent];
    return [NSString stringWithFormat:@"%@ [%d:%@][%@:%lu][%@] %@", dateAndTime, (int)getpid(), logMessage->_threadID, file, (unsigned long)logMessage->_line, logMessage->_function, logMessage->_message];
}


@end
