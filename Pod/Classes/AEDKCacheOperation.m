//
//  AEDKCacheOperation.m
//  Pods
//
//  Created by Altair on 14/09/2017.
//
//

#import "AEDKCacheOperation.h"
#import "AEDKServer.h"
#import "AEDKTools.h"

@interface AEDKCacheOperation ()

@end

@implementation AEDKCacheOperation
@synthesize key = _key;

+ (instancetype)operation {
    AEDKCacheOperation *operation = [[AEDKCacheOperation alloc] init];
    return operation;
}

- (NSString *)key {
    return [AEDKTools urlDecodeString:_key];
}

- (AEDKCacheOperationIntegerChain)withOperationType {
    return ^AEDKCacheOperation * (NSInteger type) {
        _type = (AEDKCacheOperationType)type;
        return self;
    };
}

- (AEDKCacheOperationIntegerChain)from {
    return ^AEDKCacheOperation * (NSInteger route) {
        _route = (AEDKCacheOperationRoute)route;
        return self;
    };
}

- (AEDKCacheOperationObjectChain)withKey {
    return ^AEDKCacheOperation * (NSString *key) {
        _key = [[AEDKTools urlEncodeString:key] copy];
        return self;
    };
}

- (AEDKCacheOperationObjectChain)withValue {
    return ^AEDKCacheOperation * (id value) {
        _value = value;
        return self;
    };
}

#pragma mark AEDKProtocol

- (AEDKService *)dataService {
    NSString *name = [NSString stringWithFormat:@"com.altaireven.cacheoperation-%@", [[NSUUID UUID] UUIDString]];
    NSString *path = kAEDKServiceCachePathMemoryAndDisk;
    if (_route == AEDKCacheOperationRouteMemory) {
        path = kAEDKServiceCachePathMemory;
    } else if (_route == AEDKCacheOperationRouteDisk) {
        path = kAEDKServiceCachePathDisk;
    } else {
        path = kAEDKServiceCachePathMemoryAndDisk;
    }
    path = [NSString stringWithFormat:@"/%@/%@", path, self.key];
    
    AEDKServiceConfiguration *config = [AEDKServiceConfiguration defaultConfiguration];
    switch (self.type) {
        case AEDKCacheOperationTypeRead:
        {
            config.method = kAEDKServiceMethodGet;
        }
            break;
        case AEDKCacheOperationTypeWrite:
        {
            config.method = kAEDKServiceMethodPOST;
        }
            break;
        case AEDKCacheOperationTypeRemove:
        case AEDKCacheOperationTypeClear:
        {
            config.method = kAEDKServiceMethodDELETE;
        }
            break;
        default:
            break;
    }
    
    config.requestBody = self.value;
    
    AEDKService *service = [[AEDKService alloc] initWithName:name protocol:@"cache" domain:@"AEDKCacheOperation" path:path serviceConfiguration:config];
    
    return service;
}

- (id)withResult {
    AEDKProcess *quickProcess = [[AEDKServer server] requestWithPerformer:self];
    __block id result = nil;
    quickProcess.configuration.ProcessCompleted = ^(AEDKProcess * _Nonnull currentProcess, NSError * _Nonnull error, id  _Nullable responseModel) {
        result = responseModel;
    };
    [quickProcess start];
    return result;
}

#pragma mark Quick Methods

+ (id)aedk_Cache_ObjectForKey:(NSString *)key {
    key = [AEDKTools urlEncodeString:key];
    return [[AEDKCacheOperation operation].withKey(key) withResult];
}

+ (void)aedk_Cache_SetObject:(id)object forKey:(NSString *)key {
    key = [AEDKTools urlEncodeString:key];
    [[AEDKCacheOperation operation].withKey(key).withValue(object).withOperationType(AEDKCacheOperationTypeWrite) withResult];
}

+ (void)aedk_Cache_RemoveObjectForKey:(NSString *)key {
    key = [AEDKTools urlEncodeString:key];
    [[AEDKCacheOperation operation].withKey(key).withOperationType(AEDKCacheOperationTypeRemove) withResult];
}

+ (void)aedk_Cache_ClearMemoryCacheWithRoute:(AEDKCacheOperationRoute)route {
    [[AEDKCacheOperation operation].withOperationType(AEDKCacheOperationTypeClear).from(route) withResult];
}

@end
