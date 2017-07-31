#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AEDataKit.h"
#import "AEDKPlugProtocol.h"
#import "AEDKProcess.h"
#import "AEDKServer.h"
#import "AEDKServiceConfiguration.h"
#import "AELocalDataPlug.h"

FOUNDATION_EXPORT double AEDataKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AEDataKitVersionString[];

