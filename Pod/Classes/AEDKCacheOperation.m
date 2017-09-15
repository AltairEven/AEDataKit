//
//  AEDKCacheOperation.m
//  Pods
//
//  Created by Altair on 14/09/2017.
//
//

#import "AEDKCacheOperation.h"
#import "AEDKServer.h"

@interface AEDKCacheOperation ()

@end

@implementation AEDKCacheOperation

+ (instancetype)operation {
    AEDKCacheOperation *operation = [[AEDKCacheOperation alloc] init];
    return operation;
}

- (AEDKCacheOperationObjectChain)withCacheIdentifier {
    return ^AEDKCacheOperation * (NSString *identifier) {
        _cacheIdentifier = [identifier copy];
        return self;
    };
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
        _key = [key copy];
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
    if ([self.key length] == 0) {
        return nil;
    }
    NSString *name = [NSString stringWithFormat:@"com.altaireven.cacheoperation-%@", [[NSUUID UUID] UUIDString]];
    NSString *domain = @"AEDKCacheOperation_NonPointedIdentifier";
    NSString *path = kAEDKServiceCachePathMemoryAndDisk;
    if ([self.cacheIdentifier length] > 0) {
        domain = self.cacheIdentifier;
    }
    if (self.route == AEDKCacheOperationRouteMemory) {
        path = kAEDKServiceCachePathMemory;
    } else if (self.route == AEDKCacheOperationRouteDisk) {
        path = kAEDKServiceCachePathDisk;
    } else {
        path = kAEDKServiceCachePathMemoryAndDisk;
    }
    path = [NSString stringWithFormat:@"%@/%@", path, self.key];
    
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
    
    AEDKService *service = [[AEDKService alloc] initWithName:name protocol:@"cache" domain:domain path:path serviceConfiguration:config];
    
    return service;
}

@end
