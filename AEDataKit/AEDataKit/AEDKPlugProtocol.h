//
//  AEDKPlugProtocol.h
//  AEDataKit
//
//  Created by Altair on 06/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^ResponseAnalysis)(NSDictionary *originalResponse);

@protocol AEDKPlugProtocol <NSObject>

@required

- (NSString *)plugIdentifier;

- (void)canHandleRequest:(NSURLRequest *)request;

- (void)handleRequest:(NSURLRequest *)request withCompletion:(void(^)(NSURLRequest *executingReqeust, ResponseAnalysis responseAnalysis))completion;

@end
