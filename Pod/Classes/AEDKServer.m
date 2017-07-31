//
//  AEDKServer.m
//  AEDataKit
//
//  Created by Altair on 07/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import "AEDKServer.h"

NSString *const kAEDKServiceProtocolHttp = @"http";
NSString *const kAEDKServiceProtocolHttps = @"https";
NSString *const kAEDKServiceProtocolCache = @"cache";
NSString *const kAEDKServiceProtocolFile = @"file";
//NSString *const kAEDKServiceProtocolClass = @"class";
NSString *const kAEDKServiceProtocolDataBase = @"db";


NSString *const kAEDKServiceCachePathMemory = @"kAEDKServiceCachePathMemory";
NSString *const kAEDKServiceCachePathDisk = @"kAEDKServiceCachePathDisk";
NSString *const kAEDKServiceCachePathMemoryAndDisk = @"kAEDKServiceCachePathMemoryAndDisk";

NSString *const kAEDKServiceDataBasePathSimple = @"kAEDKServiceDataBasePathSimple";
NSString *const kAEDKServiceDataBasePathSQL = @"kAEDKServiceDataBasePathSQL";



#pragma mark AEDKService

@interface AEDKService ()

@property (nonatomic, strong) NSOperationQueue *processQueue;

/**
 分配全新的服务执行进程
 
 @return 服务执行进程实例
 */
- (AEDKProcess *)assignExecutingProcess;

@end


@implementation AEDKService

#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithName:(nonnull NSString *)name protocol:(nonnull NSString *)protocol serviceConfiguration:(nonnull AEDKServiceConfiguration *)config {
    return [self initWithName:name protocol:protocol domain:nil path:nil serviceConfiguration:config];
}

- (instancetype)initWithName:(nonnull NSString *)name protocol:(nonnull NSString *)protocol domain:(NSString * _Nullable)domain path:(NSString * _Nullable)path serviceConfiguration:(nonnull AEDKServiceConfiguration *)config {
    self = [self init];
    if (self) {
        self.name = name;
        self.protocol = protocol;
        self.domain = domain;
        self.path = path;
        self.configuration = config;
    }
    return self;
}

#pragma mark Private methods

- (NSURLRequest *)standardRequest {
    NSString *wholeString = [NSString stringWithFormat:@"%@://%@%@", self.protocol, self.domain, self.path];
    NSURL *url = [NSURL URLWithString:wholeString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:self.configuration.method ? self.configuration.method : kAEDKServiceMethodGet];
    
    return request;
}

#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex forString:(NSString *)string{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:string];
}

- (BOOL)isValidHttpOrHttpsService {
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    NSString *wholeString = [NSString stringWithFormat:@"%@://%@%@", self.protocol, self.domain, self.path];
    
    return [self isValidateByRegex:regex forString:wholeString];
}

- (BOOL)isValidCacheService {
    BOOL isValid = NO;
    if (![self.domain isKindOfClass:[NSString class]] || [self.domain length] == 0) {
        return isValid;
    }
    if ([self.path isEqualToString:kAEDKServiceCachePathDisk] || [self.path isEqualToString:kAEDKServiceCachePathMemory] || [self.path isEqualToString:kAEDKServiceCachePathMemoryAndDisk]) {
        isValid = YES;
    }
    return isValid;
}

- (BOOL)isValidFileService {
    NSString *wholeString = [NSString stringWithFormat:@"%@", self.path];
    NSURL *url = [NSURL URLWithString:wholeString];
    return [url isFileURL];
}

- (BOOL)isValidDataBaseService {
    BOOL isValid = NO;
    if (![self.domain isKindOfClass:[NSString class]] || [self.domain length] == 0) {
        return isValid;
    }
    if ([self.path isEqualToString:kAEDKServiceDataBasePathSimple] || [self.path isEqualToString:kAEDKServiceDataBasePathSQL]) {
        isValid = YES;
    }
    return isValid;
}

#pragma mark Public methods

- (BOOL)isValidService {
    BOOL isValid = NO;
    if (![self.name isKindOfClass:[NSString class]] || [self.name length] == 0) {
        return isValid;
    }
    if ([self.protocol isEqualToString:kAEDKServiceProtocolHttp] || [self.protocol isEqualToString:kAEDKServiceProtocolHttps]) {
        isValid = [self isValidHttpOrHttpsService];
    } else if ([self.protocol isEqualToString:kAEDKServiceProtocolCache]) {
        isValid = [self isValidCacheService];
    } else if ([self.protocol isEqualToString:kAEDKServiceProtocolFile]) {
        isValid = [self isValidFileService];
    } else if ([self.protocol isEqualToString:kAEDKServiceProtocolDataBase]) {
        isValid = [self isValidDataBaseService];
    }
    return isValid;
}

- (AEDKProcess *)assignExecutingProcess {
    AEDKProcess *process = [[AEDKProcess alloc] init];
    process.request = [self standardRequest];
    process.configuration = self.configuration;
    [self.processQueue addOperation:process];
    return process;
}

@end

#pragma mark AEDKServer

static AEDKServer *_sharedInstance = nil;

@interface AEDKServer ()

@property (nonatomic, strong) NSMutableDictionary *services;

@property (nonatomic, strong) NSMutableDictionary *delegates;

@property (nonatomic, strong) NSMutableDictionary *processes;

@property (nonatomic, strong) dispatch_queue_t serviceSynchronizationQueue;

@property (nonatomic, strong) dispatch_queue_t delegateSynchronizationQueue;

@end

@implementation AEDKServer

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [super allocWithZone:zone];
        _sharedInstance.services = [[NSMutableDictionary alloc] init];
        _sharedInstance.delegates = [[NSMutableDictionary alloc] init];
        _sharedInstance.processes = [[NSMutableDictionary alloc] init];
        
        NSString *serviceQueueName = [NSString stringWithFormat:@"com.altaireven.aedkserver-%@", [[NSUUID UUID] UUIDString]];
        _sharedInstance.serviceSynchronizationQueue = dispatch_queue_create([serviceQueueName cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
        
        NSString *delegateQueueName = [NSString stringWithFormat:@"com.altaireven.aedkserver-%@", [[NSUUID UUID] UUIDString]];
        _sharedInstance.delegateSynchronizationQueue = dispatch_queue_create([delegateQueueName cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
    });
    return _sharedInstance;
}

+ (instancetype)new {
    return [[AEDKServer alloc] init];
}

- (id)copyWithZone:(NSZone *)zone {
    return _sharedInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _sharedInstance;
}

+ (instancetype)server {
    return [[AEDKServer alloc] init];
}

#pragma mark Public methods

#pragma mark Service

- (BOOL)registerService:(AEDKService *)service {
    if (![service isValidService]) {
        return NO;
    }
    dispatch_barrier_async(self.serviceSynchronizationQueue, ^{
        [self.services setObject:service forKey:service.name];
    });
    return YES;
}

- (void)registerServices:(NSArray<AEDKService *> *)services {
    dispatch_barrier_async(self.serviceSynchronizationQueue, ^{
        for (AEDKService *service in services) {
            if (![service isValidService]) {
                continue;
            }
            [self.services setObject:service forKey:service.name];
        }
    });
}

- (BOOL)unregisterServiceWithName:(NSString *)name {
    if (![name isKindOfClass:[NSString class]] || [name length] == 0) {
        return NO;
    }
    dispatch_barrier_sync(self.serviceSynchronizationQueue, ^{
        [self.services removeObjectForKey:name];
    });
    return YES;
}

- (void)unregisterAllServices {
    dispatch_barrier_sync(self.serviceSynchronizationQueue, ^{
        [self.services removeAllObjects];
    });
}

- (AEDKService *)registeredServiceWithName:(NSString *)name {
    if (![name isKindOfClass:[NSString class]] || [name length] == 0) {
        return nil;
    }
    __block AEDKService *service = nil;
    dispatch_barrier_sync(self.serviceSynchronizationQueue, ^{
        service = [self.services objectForKey:name];
    });
    return service;
}

- (NSArray<AEDKService *> *)registeredServices {
    __block NSArray *services = nil;
    dispatch_barrier_sync(self.serviceSynchronizationQueue, ^{
        services = [self.services allValues];
    });
    return services;
}

- (AEDKProcess *)requestServiceWithName:(NSString *)name {
    AEDKService *service = [self registeredServiceWithName:name];
    return [self requestService:service];
}

- (AEDKProcess *)requestService:(AEDKService *)service {
    if (![service isValidService]) {
        return nil;
    }
    return [service assignExecutingProcess];
}

#pragma mark Delegate

- (BOOL)addDelegate:(id<AEDKPlugProtocol>)delegate {
    if (!delegate || ![delegate conformsToProtocol:@protocol(AEDKPlugProtocol)]) {
        return NO;
    }
    dispatch_barrier_async(self.delegateSynchronizationQueue, ^{
        [self.delegates setObject:delegate forKey:NSStringFromClass([delegate class])];
    });
    return YES;
}

- (NSArray<id<AEDKPlugProtocol>> *)allDelegates {
    __block NSArray *delegates = nil;
    dispatch_barrier_sync(self.delegateSynchronizationQueue, ^{
        delegates = [self.delegates allValues];
    });
    return delegates;
}

- (BOOL)removeDelegateWithClassName:(NSString *)className {
    if (![className isKindOfClass:[NSString class]] || [className length] == 0) {
        return NO;
    }
    dispatch_barrier_sync(self.delegateSynchronizationQueue, ^{
        [self.delegates removeObjectForKey:className];
    });
    return YES;
}

- (BOOL)removeDelegate:(id<AEDKPlugProtocol>)delegate {
    if (!delegate || ![delegate conformsToProtocol:@protocol(AEDKPlugProtocol)]) {
        return NO;
    }
    dispatch_barrier_sync(self.delegateSynchronizationQueue, ^{
        [self.delegates removeObjectForKey:NSStringFromClass([delegate class])];
    });
    return YES;
}

@end
