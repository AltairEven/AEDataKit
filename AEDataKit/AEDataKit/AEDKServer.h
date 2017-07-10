//
//  AEDKServer.h
//  AEDataKit
//
//  Created by Altair on 07/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDKService.m"

@interface AEDKServer : NSObject

+ (instancetype)server;

//Service---------------------------------------------------

- (BOOL)registerService:(AEDKService *)service;

- (void)registerServices:(NSArray<AEDKService *> *)services;

- (BOOL)unregisterServiceWithName:(NSString *)name;

- (void)unregisterAllServices;

- (AEDKService *)registeredServiceWithName:(NSString *)name;

- (NSArray<AEDKService *> *)registeredServices;

//Delegate----------------------------------------------------

- (BOOL)addDelegate:(id<AEDKPlugProtocol>)delegate;

- (BOOL)removeDelegateWithIdentifier:(NSString *)identifier;

- (BOOL)removeDelegate:(id<AEDKPlugProtocol>)delegate;

- (NSArray<id<AEDKPlugProtocol>> *)allDelegates;

@end
