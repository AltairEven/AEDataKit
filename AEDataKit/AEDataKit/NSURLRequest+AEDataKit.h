//
//  NSURLRequest+AEDataKit.h
//  AEDataKit
//
//  Created by Altair on 04/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (AEDataKit)

@property (nonatomic, assign) NSUInteger retryCount;

@property (nonatomic, copy) NSString *queryPath;

@property (nonatomic, strong) NSDictionary *parameter;

@property (nonatomic, strong) NSURLRequest *nextRequest;

@property (nonatomic, copy) NSString *associatedFilePath;

@end
