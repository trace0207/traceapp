//
//  HFDBCenter.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/6/8.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFDBCenter.h"
#import "FMDB.h"
#import "HFHabitAlarmClockRes.h"

@interface HFDBCenter()
{
    FMDatabase * fmdb;
}
@end

@implementation HFDBCenter

SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HFDBCenter, shareInstance)

- (NSString *)dateBasePath
{
    NSArray * pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * dir = [pathArray objectAtIndex:0];
    NSString * dbPath = [dir stringByAppendingPathComponent:@"hiifit.sqlite"];
    return dbPath;
}

- (void)getLocalDBdatebase
{
    fmdb = [FMDatabase databaseWithPath:[self dateBasePath]];
}

- (void)createDBTables
{
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    
    if (![fmdb tableExists:@"HABITLIST"]) {
        if (![fmdb executeUpdate:@"CREATE TABLE HABITLIST (ID INTEGER, NAME TEXT,URL TEXT,SIGN INTEGER,SUBNUM INTEGER,DUMNUM INTEGER)"]) {
            NSLog(@"创建HabitList table 失败！");
        }
    }
    
    if (![fmdb tableExists:@"CLOCKLIST"]) {
        if (![fmdb executeUpdate:@"CREATE TABLE CLOCKLIST (ID INTEGER,CLOCKID INTERGER,HOUR INTERGER, MIN INTERGER,STAUTS INTERGER, WEEKS TEXT)"]) {
            NSLog(@"创建clockList table 失败！");
        }
    }
    
    [fmdb close];
}

- (NSArray *)getHabitList
{
    //先去获取本地数据库->打开数据库->取出table的数值
    if (!fmdb) {
        [self getLocalDBdatebase];
        
        if (!fmdb)
        {
            NSLog(@"无法获取本地数据库!");
            return nil;
        }
    }
    
    [self createDBTables];
    
    if (![fmdb open])
    {
        NSLog(@"打开数据库失败!");
        return nil;
    }
    
    //增加查询效率
    [fmdb setShouldCacheStatements:YES];
    
    NSMutableArray * habitList = [[NSMutableArray alloc] init];
    FMResultSet * habitSet = [fmdb executeQuery:@"SELECT * FROM HABITLIST"];
    while ([habitSet next]) {
        HFHabitAlarmClockData * data = [[HFHabitAlarmClockData alloc] init];
        data.habitId = [habitSet intForColumnIndex:0];
        data.habitName = [habitSet stringForColumnIndex:1];
        data.habitIconUrl = [habitSet stringForColumnIndex:2];
        data.isSign = [habitSet intForColumnIndex:3];
        data.subscribeNum = [habitSet intForColumnIndex:4];
        data.dummyNum = [habitSet intForColumnIndex:5];
        
        FMResultSet * clockSet = [fmdb executeQuery:@"SELECT CLOCKID , HOUR, MIN, STAUTS, WEEKS FROM CLOCKLIST WHERE ID = ?",[NSNumber numberWithInteger:data.habitId]];
        NSMutableArray * clockList = [[NSMutableArray alloc] init];
        while ([clockSet next]) {
            HFHabitAlramClockListData * clockData = [[HFHabitAlramClockListData alloc] init];
            clockData.clockId = [clockSet intForColumnIndex:0];
            clockData.hour = [clockSet intForColumnIndex:1];
            clockData.minute = [clockSet intForColumnIndex:2];
            clockData.status = [clockSet intForColumnIndex:3];
            clockData.weeks = [clockSet stringForColumnIndex:4];
            
            [clockList addObject:clockData];
        }
        data.clockList = clockList;
        [habitList addObject:data];
    }
    
    [fmdb close];
    
    return habitList;
}

- (void)updateHabitList:(NSArray *)habitLists
{
    
    if (!fmdb) {
        [self getLocalDBdatebase];
        
        if (!fmdb)
        {
            NSLog(@"无法获取本地数据库!");
        }
    }

    [self deleteHabitList];
    
    [self createDBTables];
    
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    
    for (int i = 0; i < [habitLists count]; i++)
    {
        HFHabitAlarmClockData * data = [habitLists objectAtIndex:i];
        [fmdb executeUpdate:@"INSERT INTO HABITLIST (ID,NAME,URL,SIGN,SUBNUM,DUMNUM) VALUES (?,?,?,?,?,?)" ,@(data.habitId),data.habitName,data.habitIconUrl,@(data.isSign),@(data.subscribeNum),@(data.dummyNum)];
        
        for (int j = 0; j < [data.clockList count]; j++) {
            HFHabitAlramClockListData * clockData = [data.clockList objectAtIndex:j];
            [fmdb executeUpdate:@"INSERT INTO CLOCKLIST (ID,CLOCKID,HOUR,MIN,STAUTS,WEEKS) VALUES (?,?,?,?,?,?)" ,@(data.habitId),@(clockData.clockId),@(clockData.hour),@(clockData.minute),@(clockData.status),clockData.weeks];
        }
        
    }
    
    [fmdb close];
    
}

- (HFHabitAlarmClockData *)getHabitDataWithId:(NSInteger)habitId
{
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    
    HFHabitAlarmClockData * data = [[HFHabitAlarmClockData alloc] init];
    data.habitId = habitId;
    FMResultSet * alarmSet = [fmdb executeQuery:@"SELECT  NAME, URL, SIGN, SUBNUM, DUMNUM FROM HABITLIST WHERE ID = ?",[NSNumber numberWithInteger:data.habitId]];
    while ([alarmSet next]) {
        data.habitName = [alarmSet stringForColumnIndex:0];
        data.habitIconUrl = [alarmSet stringForColumnIndex:1];
        data.isSign = [alarmSet intForColumnIndex:2];
        data.subscribeNum = [alarmSet intForColumnIndex:3];
        data.dummyNum = [alarmSet intForColumnIndex:4];
    }
    
    [fmdb close];
    
    return data;
}

#pragma mark -
#pragma mark private
- (void)deleteHabitList
{
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    
    if ([fmdb tableExists:@"HABITLIST"])
    {
        [fmdb executeUpdate:@"DELETE FROM HABITLIST"];
    }
    
    if ([fmdb tableExists:@"CLOCKLIST"])
    {
        [fmdb executeUpdate:@"DELETE FROM CLOCKLIST"];
    }
    
    [fmdb close];
}


#pragma mark - 本地敏感词库操作

- (void)createSensitiveWordsTable
{
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    if (![fmdb tableExists:@"WORDSLIST"]) {
        if (![fmdb executeUpdate:@"CREATE TABLE WORDSLIST (WORD TEXT)"]) {
            NSLog(@"创建WORDSLIST table 失败！");
        }
    }
    [fmdb close];
}

- (void)deleteSensitiveWordsTable
{
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    
    if ([fmdb tableExists:@"WORDSLIST"])
    {
        [fmdb executeUpdate:@"DELETE FROM WORDSLIST"];
    }
    
    [fmdb close];
}

//更新本地敏感词库
- (void)updateSensitiveWords:(NSArray *)words
{
    if (!fmdb) {
        [self getLocalDBdatebase];
        
        if (!fmdb)
        {
            NSLog(@"无法获取本地数据库!");
        }
    }
    
    [self deleteSensitiveWordsTable];
    
    [self createSensitiveWordsTable];
    
    if (![fmdb open]) {
        NSLog(@"打开数据库失败!");
    }
    
    for (int i = 0; i < [words count]; i++)
    {
        NSString * word = [words objectAtIndex:i];
        if(![fmdb executeUpdate:@"INSERT INTO WORDSLIST (WORD) VALUES (?)" ,word]){
            NSLog(@"插入失败");
        }
    }
    
    [fmdb close];
}

//从数据库中取出敏感词库
- (NSArray *)getSensitiveWords
{
    
    //先去获取本地数据库->打开数据库->取出table的数值
    if (!fmdb) {
        [self getLocalDBdatebase];
        
        if (!fmdb)
        {
            NSLog(@"无法获取本地数据库!");
            return nil;
        }
    }
    
    [self createSensitiveWordsTable];
    
    if (![fmdb open])
    {
        NSLog(@"打开数据库失败!");
        return nil;
    }
    
    //增加查询效率
    //[fmdb setShouldCacheStatements:YES];
    
    NSMutableArray *wordList = [[NSMutableArray alloc] init];
    FMResultSet * wordsSet = [fmdb executeQuery:@"SELECT * FROM WORDSLIST"];
    while ([wordsSet next]) {
        NSString *word = [wordsSet stringForColumnIndex:0];
        [wordList addObject:word];
    }
    [fmdb close];
    
    return wordList;
}
@end
