//
//  AEDKProcess.h
//  AEDataKit
//
//  Created by Altair on 10/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AEDKProcessStateProcessing,
    AEDKProcessStateSuspended,
    AEDKProcessStateCanceling,
    AEDKProcessStateCompleted
}AEDKProcessState;

@class AEDKServiceConfiguration;

@interface AEDKProcess : NSObject

@property (nonatomic, strong) AEDKServiceConfiguration *serviceConfiguration;

@property (nonatomic, readonly) AEDKProcessState state;

- (void)resume;
- (void)suspend;
- (void)cancel;

@end
