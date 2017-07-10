//
//  NSURLRequest+AEDataKit.m
//  AEDataKit
//
//  Created by Altair on 04/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import "NSURLRequest+AEDataKit.h"
#import <objc/runtime.h>

@implementation NSURLRequest (AEDataKit)

- (void)setRetryCount:(NSUInteger)retryCount {
    NSNumber *count = [NSNumber numberWithUnsignedInteger:retryCount];
    objc_setAssociatedObject(self, @"AEDK_NSURLRequest_RetryCount", count, OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)retryCount {
    NSNumber *count = objc_getAssociatedObject(self, @"AEDK_NSURLRequest_RetryCount");
    return [count unsignedIntegerValue];
}

- (void)setQueryPath:(NSString *)queryPath {
    objc_setAssociatedObject(self, @"AEDK_NSURLRequest_QueryPath", queryPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)queryPath {
    return objc_getAssociatedObject(self, @"AEDK_NSURLRequest_QueryPath");
}

- (void)setParameter:(NSDictionary *)parameter {
    objc_setAssociatedObject(self, @"AEDK_NSURLRequest_Parameter", parameter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)parameter {
    return objc_getAssociatedObject(self, @"AEDK_NSURLRequest_Parameter");
}

- (void)setNextRequest:(NSURLRequest *)nextRequest {
    objc_setAssociatedObject(self, @"AEDK_NSURLRequest_NextRequest", nextRequest, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLRequest *)nextRequest {
    return objc_getAssociatedObject(self, @"AEDK_NSURLRequest_NextRequest");
}

- (void)setAssociatedFilePath:(NSString *)associatedFilePath {
    objc_setAssociatedObject(self, @"AEDK_NSURLRequest_AssociatedFilePath", associatedFilePath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)associatedFilePath {
    return objc_getAssociatedObject(self, @"AEDK_NSURLRequest_AssociatedFilePath");
}

//- (id)copy {
//    return nil;
//}
//
//- (id)mutableCopy {
//    return nil;
//}

@end
