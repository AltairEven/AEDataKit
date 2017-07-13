//
//  AEDKProcess.h
//  AEDataKit
//
//  Created by Altair on 10/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AEDKProcessStateReady,
    AEDKProcessStateProcessing,
    AEDKProcessStateSuspended,
    AEDKProcessStateCanceling,
    AEDKProcessStateCompleted
}AEDKProcessState;

@class AEDKServiceConfiguration;

@interface AEDKProcess : NSOperation

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, copy) AEDKServiceConfiguration *configuration;

@property (nonatomic, readonly) AEDKProcessState state;

@end
