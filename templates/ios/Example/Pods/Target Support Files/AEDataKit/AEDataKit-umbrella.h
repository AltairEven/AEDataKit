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
#import "AEDKCacheOperation.h"
#import "AEDKImageViewPlaceholder.h"
#import "AEDKPlugProtocol.h"
#import "AEDKProcess.h"
#import "AEDKProtocol.h"
#import "AEDKServer.h"
#import "AEDKServiceConfiguration.h"
#import "AEDKTools.h"
#import "AEDKWebImageLoader.h"
#import "AELocalDataPlug.h"
#import "AENetworkDataPlug.h"
#import "AENetworkReachabilityManager.h"
#import "AEReachability.h"
#import "AEWebImagePlug.h"

FOUNDATION_EXPORT double AEDataKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AEDataKitVersionString[];

