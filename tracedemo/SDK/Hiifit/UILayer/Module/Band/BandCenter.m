//
//  BandCenter.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/6.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "BandCenter.h"
#import "libIwownBLE.h"

@interface BandCenter()<libIwownBLEDelegate>

@property(nonatomic,strong)BandDeviceBlock  searchBlock;
@property(nonatomic,strong)ConBandFinishBlock bindBlock;
@property(nonatomic,strong)SyncBandBlock syncBlock;
@property(nonatomic,strong)StopSearchBlock  stopBlock;
@property(nonatomic,strong)BlueToothBlock   blueToothBlock;
@property(nonatomic,strong)NSTimer  * mTimer;
@property(nonatomic,strong)NSMutableArray * mBands;
@property(nonatomic,strong)CBPeripheral * bandDev;
@property(nonatomic,assign)BOOL  bPhotoSwi;
@property(nonatomic,assign)BOOL  bMsgSwi;

@property(nonatomic,assign)BOOL  bReconnctBand;
@property(nonatomic,copy)NSString * bandModel;
@end


@implementation BandCenter

#pragma mark -
#pragma mark private
SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(BandCenter, shareInstance)

- (void)dealloc
{

}

- (void)stopSearch
{
    
    [[libIwownBLE shareInstance] stopScanDevice];
    
    [self.mBands removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.stopBlock)
        {
            self.stopBlock();
        }
    });
}

- (BOOL)filterHistoryData:(NSDictionary *)dict
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSInteger  nowDay = [[formatter stringFromDate:date] integerValue];
    NSInteger  dataDay = [[dict objectForKey:@"CDAY"] integerValue];
    
    if (dataDay == nowDay)
    {
        return YES;
    }
    
    return NO;
}


#pragma mark -
#pragma mark Public

- (void)getBlueTooth:(BlueToothBlock)block
{
    [self connnetLib];
    
    self.blueToothBlock = block;
    
    [self performSelector:@selector(blueTooth) withObject:nil afterDelay:2.0];
    
}

- (void)blueTooth
{
    if (self.blueToothBlock)
    {
        self.blueToothBlock([[libIwownBLE shareInstance] getCentralStatus]);
    }
}


- (void)updateServiceData:(NSDictionary *)dict
{
    ReportBandArg * arg = [[ReportBandArg alloc] init];
    arg.step = [[dict objectForKey:@"CSTEP"] integerValue];
    arg.calorie = [[dict objectForKey:@"CCALO"] integerValue];
    arg.manufacturer = 1;
    arg.productModel = @"Braceli5";
    
    NSInteger year = [[dict objectForKey:@"CYEAR"] integerValue];
    NSInteger mon = [[dict objectForKey:@"CMONTH"] integerValue];
    NSInteger day = [[dict objectForKey:@"CDAY"] integerValue];
   
    
    NSString * date = [NSString stringWithFormat:@"%04ld-%02ld-%02ld",year,mon,day];
    
    arg.createDate = date;
    [[[HIIProxy shareProxy] bandProxy] reportBandInfo:arg withBlock:^(HF_BaseAck *ack) {
        if ([ack sucess])
        {
            NSLog(@"上报服务器成功");
        }
    }];
}

- (void)connnetLib
{
    self.bMsgSwi = YES;
    self.bPhotoSwi = YES;
    [[libIwownBLE shareInstance] setDelegate:self];
}


- (void)searchDevice:(BandDeviceBlock)block  andStop:(StopSearchBlock)stop
{
    
    self.bReconnctBand = NO;
    
    self.searchBlock = block;
    self.stopBlock  = stop;
    //扫描设备
    [[libIwownBLE shareInstance] unbindDevice];
    [[libIwownBLE shareInstance] disConnectCurrentDevice];
    [[libIwownBLE shareInstance] scanDevice];
    
    [self performSelector:@selector(stopSearch) withObject:nil afterDelay:5.0];
    
  //  [[libIwownBLE shareInstance] findConnectedDevice];
}


- (void)bindBand:(CBPeripheral *)dev finish:(ConBandFinishBlock)block
{
    self.bindBlock = block;
    self.bandDev = dev;
    // 停止扫描
    [[libIwownBLE shareInstance] stopScanDevice];
    
    [[libIwownBLE shareInstance] connectDevice:dev];
}


- (void)disConnectBand
{
     [[libIwownBLE shareInstance] disConnectCurrentDevice];
}

- (void)disBindBand:(UnBindBlock)block
{
    [[libIwownBLE shareInstance] unbindDevice];
    [[libIwownBLE shareInstance] disConnectCurrentDevice];
    
    //向服务器提交已经绑定的
    [[[HIIProxy shareProxy] bandProxy] bindingBand:@"" withBlock:^(HF_BaseAck *ack)
     {
         if ([ack sucess])
         {
             
             NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"step",@"",@"name", nil];
             [[GlobInfo shareInstance] saveBandInfo:dict];
             
             self.bandModel = @"";
             
             [[[HIIProxy shareProxy] userProxy] getUserInfo:^(BOOL finsih){
                 block(true);
             }];
         }
         else
         {
             block(false);
         }
         
     }];
    
}

- (BOOL)isBandI5
{
    if ([self.bandModel isEqualToString:@"I5"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL)getBindStauts
{
    //从服务器获取的字段读取是否该账户绑定
    
    NSString * bandId = [[GlobInfo shareInstance] usr].bandDeviceId;
    
    if (bandId == nil || [bandId isEqualToString:@""])
    {
        return NO;
    }
   
    return YES;
}

- (void)syncBandData:(SyncBandBlock)block
{
    self.bReconnctBand = YES;
    
    self.syncBlock = block;
    
    if (![[libIwownBLE shareInstance] getCentralStatus])
    {
        block(SyncDataCode_NoBlueTooth);
    }
    
//    BLEState state =  [[libIwownBLE shareInstance] state];
//    
//    
//    if (state != kBLEBindConnectedState)
//    {
        [[libIwownBLE shareInstance] findConnectedDevice];
//    }
}

#pragma mark -
#pragma mark libIwownBLEDelegate

- (void)updateProtocolVerTo:(NSInteger)ver;// notice protocol version changed, let user know, the firmware upgrade to the bracelet is wrong, and upgrade the right firmware if ver not kProtocolVer2_0; or UI have some change?
{
    NSLog(@"通知用户手环有新的版本，请用户选择升级");
}

// 下面两个函数当第一次连接和断开重连会被call到
- (void)updateDeviceInfo:(NSMutableDictionary *)deviceInfo; // SDK更新设备信息给App
{
    //更新到本地
    
    self.bandModel =  [deviceInfo objectForKey:@"MODEL"];
    
    NSLog(@"更新设备的信息");
}

- (void)updateBattery:(NSInteger)batteryLevel; // SDK更新电池电量给App
{
    NSLog(@"更新电池的电量");
}

// CDATE(yyyyMMdd0000)，CDAY, CMONTH, CYEAR, CCALO, CDIST, CSTEP
- (void)updateDayData:(NSMutableDictionary *)dict; // 日冻结
{
    if (self.syncBlock)
    {
        self.syncBlock(SyncDataCode_Success);
    }
    
    NSLog(@"已经获取日冻结数据：%@",dict);
    
    //过滤掉历史数据
    BOOL bNow = [self filterHistoryData:dict];
    
    if (bNow)
    {
        
        NSMutableDictionary * bandInfo = [kUserDefaults objectForKey:kParamBandInfo];
        
        NSString * name = [bandInfo objectForKey:@"name"];
        
        NSDictionary * bandDict = [[NSDictionary alloc] initWithObjectsAndKeys:[dict objectForKey:@"CSTEP"],@"setp",name,@"name", nil];
    
        [[GlobInfo shareInstance] saveBandInfo:bandDict];
        
        [self updateServiceData:dict];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KBandSyncDayDataNotication object:dict];
    }
    
    //本地也回去存一份日数据，同时负责数据上报到服务器
    
}

// CMINUTE CHOUR CDAY CMONTH CYEAR CFLAG CSTEPS CDIST CCALO CCALO
- (void)update5MinData:(NSMutableDictionary *)dict; // 分冻结
{
    NSLog(@"开始分冻结数据：%@",dict);
    
    //本地也回去存一份5分数据，同时负责数据上报到服务器
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KBandSync5minDataNotication object:dict];
    
}

- (void)notifyToTakePicture; // 通知拍照 // 需要做拍照保护，拍照在未保存完成前不要开启第二次拍照。
{
    NSLog(@"通过手环通知手机拍照");
}

- (void)notifyToSearchPhone; // 通知找手机 请播放音乐或者其他动作
{
    NSLog(@"通过手环找手机,手机可以选择播放音乐");
}

//- (NSString *)personalStr; // 从app端获取个人信息字串
//{
//    NSLog(@"从app端获取个人信息字串");
//    NSString *hexStr = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",170, 60, 0, 25, 0xaa, 0x3c]; // heightStr.intValue,weightStr.intValue,intGender,(curYearStr.intValue-birthYearStr.intValue),lowByte,highByte ,具体看协议,最后两项为目标
//    
//    NSLog(@"personal info str is %@",hexStr);
//    return hexStr;
//}

//- (NSString *)alertStrByIndex:(NSInteger)index; // 从APP端获取闹钟字串写入手环，根据index来获取。index从0-7，0和1请返回关闭的状态的字串。2-7是正常闹钟字串。
//{
//    NSLog(@"这里看需要把APP端数据写入到手环内");
//    NSString *acStr;
//    
//    if (index == 0) {
//        acStr = @"0000001700";
//    }
//    else if (index == 1)
//    {
//        acStr = @"0100000800";
//    }
//    else
//    {
//        acStr = [NSString stringWithFormat:@"%02lx00%02x%02x%02x",(long)index, (Byte)0XFF/*WEEK*/,0X0B/*(long)hour*/,0X00/*(long)minute*/];//(Byte)week,(long)minute,(long)hour 具体看协议
//    }
//    
//    return acStr;
//}

//- (NSString *)motionRemindStr;
//{
//    /*
//     字段名           格式     说明
//     Nma_Idx         Uint8	久坐索引
//     Nma_Conf        Uint8	b7：重复标记  b6~b0：周日~周一开启标记，取值1开启
//     Nma_StartHour	Uint8	久坐起始判定小时
//     Nma_EndHour     Uint8	久坐结束判定小时
//     Nma_Duration	Uint8	久坐判定生效持续时间，5分钟为单位
//     Nma_Threshold	Uint16	久坐判定生效运动量
//     */
//    return @"00FF0000060000"; // 只用到第一个，只设置第一个。
//}

- (void)updateDeviceSearch:(NSMutableArray *)peripherals; // SDK更新搜索到的设备列表给App
{
    if (self.bReconnctBand)
    {
        NSMutableDictionary * bandInfo = [kUserDefaults objectForKey:kParamBandInfo];
        NSString * bandName = [bandInfo objectForKey:@"name"];
        
        for (CBPeripheral * dev in peripherals)
        {
            if ([dev.name isEqualToString:bandName])
            {
                [[libIwownBLE shareInstance] connectDevice:dev];
                break;
            }
        }
    }

    
    if ([self.mBands count] == [peripherals count])
    {
        for (int i = 0; i < [self.mBands count]; i++)
        {
            CBPeripheral * oldBand = [self.mBands objectAtIndex:i];
            CBPeripheral * newBand = [peripherals objectAtIndex:i];
            
            if (![oldBand isEqual:newBand])
            {
                [self.mBands removeAllObjects];
                [self.mBands addObjectsFromArray:peripherals];
                if (self.searchBlock)
                {
                    self.searchBlock(self.mBands);
                }
                break;
            }
        }
    }
    else
    {
        [self.mBands removeAllObjects];
        [self.mBands addObjectsFromArray:peripherals];
        
        if (self.searchBlock)
        {
             self.searchBlock(self.mBands);
        }
       
    }
}

- (void)didConnectedPeripheralNotice;   // 通知设备已经连接上，需做show pair的pair检查，才能bind
{
    NSLog(@"目前的状态 state:%d", [[libIwownBLE shareInstance] state]);
    
    if (![[libIwownBLE shareInstance] isBind])
    {
        NSLog(@"绑定中...");
        [[libIwownBLE shareInstance] showPairCodeOnDevice:YES endBlock:^{  }]; // for pair
    }
    else
    {
        NSLog(@"设备已经连接上...,可以去获取一次数据");
        NSLog(@"已经绑定 didconnectstate:%d", [[libIwownBLE shareInstance] state]);
        
        [[libIwownBLE shareInstance] syncDayData];
        
    }
}

- (void)pairSuccess; // 通知已检查pair成功，需调用bindDevice和APP其他逻辑。
{
    NSLog(@"绑定成功!");
    // 绑定设备
    [[libIwownBLE shareInstance] bindDevice];

    
    
    NSString * uploadName;
    
    if ([self.bandDev.name isEqualToString:@""] || self.bandDev.name == nil)
    {
        uploadName = @"未知设备";
    }else
    {
        uploadName = self.bandDev.name;
    }
    
    //向服务器提交已经绑定的
    [[[HIIProxy shareProxy] bandProxy] bindingBand:uploadName withBlock:^(HF_BaseAck *ack)
    {
        if (![ack sucess])
        {
            NSLog(@"向服务器提交绑定数据失败");
        }
        else
        {
            NSMutableDictionary * bandInfo = [kUserDefaults objectForKey:kParamBandInfo];
            NSString * step = [bandInfo objectForKey:@"step"];
            NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:step,@"step", self.bandDev.name,@"name", nil];
            [[GlobInfo shareInstance] saveBandInfo:dict];
            
            [[[HIIProxy shareProxy] userProxy] getUserInfo:^(BOOL finished) {
                self.bindBlock();
            }];
        }
    }];
    
}

- (void)makeToast:(NSString *)str; // if no need notice user. return in this interface.
{
    return;
}

- (BOOL)phoneCallSwitch
{
    return [GlobInfo shareInstance].usr.isMobileRemind;
}

- (BOOL)msgSwitch
{
    return [GlobInfo shareInstance].usr.isSmsRemind;
}

#pragma mark -
#pragma mark getter

- (NSMutableArray *)mBands
{
    if (!_mBands)
    {
        _mBands = [[NSMutableArray alloc] init];
    }
    return _mBands;
}


@end
