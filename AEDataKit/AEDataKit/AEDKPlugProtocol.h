//
//  AEDKPlugProtocol.h
//  AEDataKit
//
//  Created by Altair on 06/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDKProcess.h"

@protocol AEDKPlugProtocol <NSObject>

@required

- (BOOL)canHandleProcess:(AEDKProcess *)process;

- (void)handleProcess:(AEDKProcess *)process;

@end
