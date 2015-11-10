//
//  DeviceInfo.m
//  GuanHealth
//
//  Created by hermit on 15/2/26.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFDeviceInfo.h"
#import "SSKeychain.h"
#include <sys/utsname.h>
#import  <CoreTelephony/CTTelephonyNetworkInfo.h>
#import  <CoreTelephony/CTCarrier.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

static NSString *kSSToolkitTestsServiceName = @"SSToolkitTestService";
static NSString *kSSToolkitTestsAccountName = @"SSToolkitTestAccount";

@implementation HFDeviceInfo
SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(HFDeviceInfo, shareInstance)
- (NSString*)getDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

- (NSString*)getDeviceOSVersion
{
    return [UIDevice currentDevice].systemVersion;
}

- (NSString*)getDeviceUUID
{
    NSString *strUUID = [SSKeychain passwordForService:kSSToolkitTestsServiceName account:kSSToolkitTestsAccountName];
    
    if ([strUUID length] <= 0) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
        [SSKeychain setPassword:strUUID forService:kSSToolkitTestsServiceName account:kSSToolkitTestsAccountName];
    }
    return strUUID;
}

- (NSString*)getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString*)getCarrierName
{
    CTTelephonyNetworkInfo  *networkInfo = [[ CTTelephonyNetworkInfo alloc]init];
    return networkInfo.subscriberCellularProvider.carrierName;
}

- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
//    NSString *adr = nil;
//    if (addresses && [addresses isKindOfClass:[NSDictionary class]]) {
//        adr = [addresses objectForKey:@"en0/ipv4"];
//    }
//    return adr?adr:@"0.0.0.0";
    
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

- (NSString*)getDeviceId
{
    static NSString *deviceId = nil;
    NSString *IMEI          = [self getDeviceUUID];
    NSString *version       = [self getAppVersion];
    NSString *carrierName   = [self getCarrierName];
    NSString *deviceModel   = [self getDeviceModel];
    NSString *OSVersion     = [self getDeviceOSVersion];
    deviceId = [NSString stringWithFormat:@"IMEI=%@|VERSION=%@|SNAME=%@|DEVICE=%@|OSVERSION=%@",IMEI,version,carrierName,deviceModel,OSVersion];
    return [deviceId base64String];
}

- (NSString*)getBehaviorInfo
{
    static NSString *behaviorInfo = nil;
    NSString *appAddress = [self getIPAddress:YES];
    behaviorInfo = [[NSString stringWithFormat:@"NETTYPE=%@",appAddress]base64String];
    [kUserDefaults setObject:behaviorInfo forKey:kParamBehavoirInfo];
    [kUserDefaults synchronize];
    return behaviorInfo;
}

@end
