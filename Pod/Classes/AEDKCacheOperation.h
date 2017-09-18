//
//  AEDKCacheOperation.h
//  Pods
//
//  Created by Altair on 14/09/2017.
//
//

#import <Foundation/Foundation.h>
#import "AEDKProtocol.h"

@class AEDKCacheOperation;

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
    AEDKCacheOperationRouteDisk = 1 << 1
}AEDKCacheOperationRoute;

@interface AEDKCacheOperation : NSObject <AEDKProtocol>

@property (nonatomic, readonly) AEDKCacheOperationType type;

@property (nonatomic, strong, readonly) NSString *key;

@property (nonatomic, strong, readonly) id value;

@property (nonatomic, readonly) AEDKCacheOperationRoute route;

+ (instancetype)operation;

- (AEDKCacheOperationIntegerChain)withOperationType;

- (AEDKCacheOperationIntegerChain)from;

- (AEDKCacheOperationObjectChain)withKey;

- (AEDKCacheOperationObjectChain)withValue;

- (id)withResult;

//快捷方法

+ (id)aedk_Cache_ObjectForKey:(NSString *)key;

+ (void)aedk_Cache_SetObject:(id)object forKey:(NSString *)key;

+ (void)aedk_Cache_RemoveObjectForKey:(NSString *)key;

+ (void)aedk_Cache_ClearMemoryCacheWithRoute:(AEDKCacheOperationRoute)route;

@end
