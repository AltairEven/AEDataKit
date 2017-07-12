//
//  AEDKServiceConfiguration.h
//  AEDataKit
//
//  Created by Altair on 10/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AEDKProcess;

NS_ASSUME_NONNULL_BEGIN

@interface AEDKServiceConfiguration : NSObject <NSCopying>

/**
 是否开启日志，默认NO
 */
@property (nonatomic, assign) BOOL displayDebugInfo;

/**
 服务进程开始前
 */
@property (nonatomic, copy) AEDKProcess *(^__nullable BeforeProcess)(AEDKProcess *currentProcess);

/**
 服务进程进行中
 */
@property (nonatomic, copy) void (^__nullable Processing)(int64_t totalAmount, int64_t currentAmount, NSURLRequest *currentRequest);

/**
 服务进程结束前
 */
@property (nonatomic, copy) id (^__nullable AfterProcess)(id __nullable responseData);

/**
 服务进程完成后
 */
@property (nonatomic, copy) void (^ ProcessCompleted)(AEDKProcess *currentProcess, NSError *error, id responseModel);

/**
 默认配置

 @return 配置实例
 */
+ (instancetype)defaultConfiguration;

@end

@interface AEDKHttpServiceConfiguration : AEDKServiceConfiguration

/**
 字符编码
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;

/**
 超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutSeconds;

/**
 method
 */
@property (nonatomic, copy) NSString *httpMethod;

/**
 拼在链接后的用户信息
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *infoAppendingAfterQueryString;

/**
 http头中的用户信息
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *infoInHttpHeader;

/**
 重试次数， 默认0
 */
@property (nonatomic, assign) NSUInteger retryCount;

@end


NS_ASSUME_NONNULL_END

