//
//  AEDKService.m
//  AEDataKit
//
//  Created by Altair on 06/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import "AEDKService.h"

NSString *const kAEDKServiceProtocolHttp = @"http";
NSString *const kAEDKServiceProtocolHttps = @"https";
NSString *const kAEDKServiceProtocolCache = @"cache";
NSString *const kAEDKServiceProtocolFile = @"file";
//NSString *const kAEDKServiceProtocolClass = @"class";
NSString *const kAEDKServiceProtocolDataBase = @"db";


NSString *const kAEDKServiceMethodGet = @"GET";
NSString *const kAEDKServiceMethodPOST = @"POST";
NSString *const kAEDKServiceMethodHEAD = @"HEAD";
NSString *const kAEDKServiceMethodDELETE = @"DELETE";
NSString *const kAEDKServiceMethodPUT = @"PUT";
NSString *const kAEDKServiceMethodPATCH = @"PATCH";
NSString *const kAEDKServiceMethodOPTIONS = @"OPTIONS";
NSString *const kAEDKServiceMethodTRACE = @"TRACE";
NSString *const kAEDKServiceMethodCONNECT = @"CONNECT";
NSString *const kAEDKServiceMethodMOVE = @"MOVE";
NSString *const kAEDKServiceMethodCOPY = @"COPY";
NSString *const kAEDKServiceMethodLINK = @"LINK";
NSString *const kAEDKServiceMethodUNLINK = @"UNLINK";
NSString *const kAEDKServiceMethodWRAPPED = @"WRAPPED";


NSString *const kAEDKServiceCachePathMemory = @"kAEDKServiceCachePathMemory";
NSString *const kAEDKServiceCachePathDisk = @"kAEDKServiceCachePathDisk";
NSString *const kAEDKServiceCachePathMemoryAndDisk = @"kAEDKServiceCachePathMemoryAndDisk";

NSString *const kAEDKServiceDataBasePathSimple = @"kAEDKServiceDataBasePathSimple";
NSString *const kAEDKServiceDataBasePathSQL = @"kAEDKServiceDataBasePathSQL";


@implementation AEDKService

#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.method = kAEDKServiceMethodGet;
    }
    return self;
}

- (instancetype)initWithProtocol:(NSString *)protocol domain:(NSString *)domain {
    return [self initWithProtocol:protocol domain:domain path:nil method:nil];
}

- (instancetype)initWithProtocol:(NSString *)protocol domain:(NSString *)domain path:(NSString *)path method:(NSString *)method {
    self = [self init];
    if (self) {
        self.protocol = protocol;
        self.domain = domain;
        self.path = path;
        self.method = method ? method : kAEDKServiceMethodGet;
    }
    return self;
}

#pragma mark Public methods

- (BOOL)isValidService {
    return YES;
}

@end
