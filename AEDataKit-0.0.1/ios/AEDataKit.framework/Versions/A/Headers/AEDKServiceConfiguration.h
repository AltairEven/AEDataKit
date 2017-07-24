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
 指定的服务代理（类名）
 */
@property (nonatomic, copy) NSString *specifiedServiceDelegate;

/**
 服务进程携带的操作实体，如http/https请求中的dataBody，file保存请求中需要操作的对象实体，或者cache请求中的缓存实体等，默认nil
 */
@property (nonatomic, strong) id requestBody;

/**
 服务进程开始前，该block通知用户当前进程，如需修改则直接修改
 */
@property (nonatomic, copy) void (^__nullable BeforeProcess)(AEDKProcess *process);

/**
 服务进程进行中
 */
@property (nonatomic, copy) void (^__nullable Processing)(int64_t totalAmount, int64_t currentAmount, NSURLRequest *currentRequest);

/**
 服务进程结束前，该block通知用户当前服务的返回数据，需要用户返回解析后的数据模型
 */
@property (nonatomic, copy) id (^__nullable AfterProcess)(id __nullable responseData);

/**
 服务进程完成后，得到执行结果。如果用户实现了AfterProcess，则返回用户解析后的数据模型，否则返回原始数据
 */
@property (nonatomic, copy) void (^ ProcessCompleted)(AEDKProcess *currentProcess, NSError *error, id __nullable responseModel);

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
 请求参数
 */
@property (nonatomic, copy) NSDictionary *requestParameter;

/**
 关联的文件路径，用于上传或下载
 */
@property (nonatomic, copy) NSString *associatedFilePath;

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

