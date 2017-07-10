//
//  AEDKServiceConfiguration.m
//  AEDataKit
//
//  Created by Altair on 10/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import "AEDKServiceConfiguration.h"

@implementation AEDKServiceConfiguration

+ (instancetype)defaultConfiguration {
    AEDKServiceConfiguration *config = [[AEDKServiceConfiguration alloc] init];
    config.displayDebugInfo = NO;
    
    return config;
}


#pragma mark NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    AEDKServiceConfiguration *config = [[AEDKServiceConfiguration allocWithZone:zone] init];
    config.displayDebugInfo = self.displayDebugInfo;
    config.BeforeProcess = self.BeforeProcess;
    config.Processing = self.Processing;
    config.ProcessCompleted = self.ProcessCompleted;
    
    return config;
}

@end

@implementation AEDKHttpServiceConfiguration

+ (instancetype)defaultConfiguration {
    AEDKHttpServiceConfiguration *config = (AEDKHttpServiceConfiguration *)[AEDKServiceConfiguration defaultConfiguration];
    [config setStringEncoding:NSUTF8StringEncoding];
    [config setTimeoutSeconds:10.0];
    [config setHttpMethod:@"GET"];
    
    return config;
}

#pragma mark NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    AEDKHttpServiceConfiguration *config = [[AEDKHttpServiceConfiguration allocWithZone:zone] init];
    config.displayDebugInfo = self.displayDebugInfo;
    config.BeforeProcess = self.BeforeProcess;
    config.Processing = self.Processing;
    config.ProcessCompleted = self.ProcessCompleted;
    config.stringEncoding = self.stringEncoding;
    config.timeoutSeconds = self.timeoutSeconds;
    config.httpMethod = self.httpMethod;
    config.infoAppendingAfterQueryString = [self.infoAppendingAfterQueryString copy];
    config.infoInHttpHeader = [self.infoInHttpHeader copy];
    config.retryCount = self.retryCount;
    config.ResponseValidation = self.ResponseValidation;
    
    return config;
}


@end
