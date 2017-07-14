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
    config.specifiedServiceDelegate = self.specifiedServiceDelegate;
    config.requestBody = self.requestBody;
    config.BeforeProcess = self.BeforeProcess;
    config.Processing = self.Processing;
    config.AfterProcess = self.AfterProcess;
    config.ProcessCompleted = self.ProcessCompleted;
    
    return config;
}

@end

@implementation AEDKHttpServiceConfiguration

+ (instancetype)defaultConfiguration {
    AEDKHttpServiceConfiguration *config = [[AEDKHttpServiceConfiguration alloc] init];
    config.displayDebugInfo = NO;
    [config setStringEncoding:NSUTF8StringEncoding];
    
    return config;
}

#pragma mark NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    AEDKHttpServiceConfiguration *config = [[AEDKHttpServiceConfiguration allocWithZone:zone] init];
    config.displayDebugInfo = self.displayDebugInfo;
    config.specifiedServiceDelegate = self.specifiedServiceDelegate;
    config.requestBody = self.requestBody;
    config.BeforeProcess = self.BeforeProcess;
    config.Processing = self.Processing;
    config.AfterProcess = self.AfterProcess;
    config.ProcessCompleted = self.ProcessCompleted;
    config.stringEncoding = self.stringEncoding;
    config.infoAppendingAfterQueryString = [self.infoAppendingAfterQueryString copy];
    config.infoInHttpHeader = [self.infoInHttpHeader copy];
    config.retryCount = self.retryCount;
    
    return config;
}


@end
