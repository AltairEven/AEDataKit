//
//  AEDKCacheOperation.h
//  Pods
//
//  Created by Altair on 14/09/2017.
//
//

#import <Foundation/Foundation.h>
#import "AEDKProtocol.h"

#define AEDKCacheObjectforkey(id, key)  ([[AEDKServer server] requestWithPerformer:[AEDKCacheOperation operation].withCacheIdentifier(id).withKey(key)]); 

@class AEDKCacheOperation;

typedef AEDKCacheOperation *(^ AEDKCacheOperationChain)(id obj);
typedef AEDKCacheOperation *(^ AEDKCacheOperationIntegerChain)(NSInteger obj);
typedef AEDKCacheOperation *(^ AEDKCacheOperationObjectChain)(id obj);

typedef enum {
    AEDKCacheOperationTypeRead,
    AEDKCacheOperationTypeWrite,
    AEDKCacheOperationTypeRemove,
    AEDKCacheOperationTypeClear
}AEDKCacheOperationType;

typedef enum {
    AEDKCacheOperationRouteMemory = 1 << 0,
    AEDKCacheOperationRouteDisk = 1 << 1,
}AEDKCacheOperationRoute;

@interface AEDKCacheOperation : NSObject <AEDKProtocol>

@property (nonatomic, strong, readonly) NSString *cacheIdentifier;

@property (nonatomic, readonly) AEDKCacheOperationType type;

@property (nonatomic, readonly) AEDKCacheOperationRoute route;

@property (nonatomic, strong, readonly) NSString *key;

@property (nonatomic, strong, readonly) id value;

+ (instancetype)operation;

- (AEDKCacheOperationObjectChain)withCacheIdentifier;

- (AEDKCacheOperationIntegerChain)withOperationType;

- (AEDKCacheOperationIntegerChain)from;

- (AEDKCacheOperationObjectChain)withKey;

- (AEDKCacheOperationObjectChain)withValue;

@end
