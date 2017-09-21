//
//  AEWebImagePlug.m
//  Pods
//
//  Created by Altair on 13/09/2017.
//
//

#import "AEWebImagePlug.h"

@implementation AEWebImagePlug

- (BOOL)canHandleProcess:(AEDKProcess *)process{
    if (!process || ![process isKindOfClass:[AEDKProcess class]]) {
        return NO;
    }
    NSString *protocol = [process.request.URL scheme];
    if (![protocol isEqualToString:kAEDKServiceProtocolHttp] || ![protocol isEqualToString:kAEDKServiceProtocolHttps]) {
        return NO;
    }
    AEDKHttpServiceConfiguration *config = (AEDKHttpServiceConfiguration *)(process.configuration);
    if (config.mimeType == AEDKHttpServiceMimeTypeImage) {
        return YES;
    }
    
    return NO;
}

- (void)handleProcess:(AEDKProcess *)process{
}


@end
