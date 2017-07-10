//
//  AEDKServer.m
//  AEDataKit
//
//  Created by Altair on 07/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import "AEDKServer.h"

static AEDKServer *_sharedInstance = nil;

@interface AEDKServer ()

@property (nonatomic, strong) NSMutableDictionary *services;

@property (nonatomic, strong) NSMutableDictionary *delegates;

@property (nonatomic, strong) dispatch_queue_t serviceSynchronizationQueue;

@property (nonatomic, strong) dispatch_queue_t delegateSynchronizationQueue;

@end

@implementation AEDKServer

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [AEDKServer allocWithZone:zone];
        _sharedInstance.services = [[NSMutableDictionary alloc] init];
        _sharedInstance.delegates = [[NSMutableDictionary alloc] init];
        
        NSString *serviceQueueName = [NSString stringWithFormat:@"com.altaireven.aeldmemorycache-%@", [[NSUUID UUID] UUIDString]];
        _sharedInstance.serviceSynchronizationQueue = dispatch_queue_create([serviceQueueName cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_CONCURRENT);
        
        NSString *delegateQueueName = [NSString stringWithFormat:@"com.altaireven.aeldmemorycache-%@", [[NSUUID UUID] UUIDString]];
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

#pragma mark Delegate

- (BOOL)addDelegate:(id<AEDKPlugProtocol>)delegate {
    if (!delegate || ![delegate conformsToProtocol:@protocol(AEDKPlugProtocol)]) {
        return NO;
    }
    dispatch_barrier_async(self.delegateSynchronizationQueue, ^{
        [self.delegates setObject:delegate forKey:[delegate plugIdentifier]];
    });
    return YES;
}

- (BOOL)removeDelegateWithIdentifier:(NSString *)identifier {
    if (![identifier isKindOfClass:[NSString class]] || [identifier length] == 0) {
        return nil;
    }
    dispatch_barrier_sync(self.delegateSynchronizationQueue, ^{
        [self.delegates removeObjectForKey:identifier];
    });
    return YES;
}

- (BOOL)removeDelegate:(id<AEDKPlugProtocol>)delegate {
    dispatch_barrier_sync(self.delegateSynchronizationQueue, ^{
        [self.delegates removeObjectForKey:[delegate plugIdentifier]];
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

@end
