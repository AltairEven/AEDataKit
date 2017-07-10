//
//  AEDKService.h
//  AEDataKit
//
//  Created by Altair on 06/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDKPlugProtocol.h"

NS_ASSUME_NONNULL_BEGIN

//数据服务协议
extern NSString *const kAEDKServiceProtocolHttp;    //http
extern NSString *const kAEDKServiceProtocolHttps;   //https
extern NSString *const kAEDKServiceProtocolCache;    //缓存
extern NSString *const kAEDKServiceProtocolFile;    //文件
//extern NSString *const kAEDKServiceProtocolClass;   //类
extern NSString *const kAEDKServiceProtocolDataBase;    //数据库

//数据服务处理方式
extern NSString *const kAEDKServiceMethodGet;   //对应http/https协议的GET方式，或者其他协议的数据获取
extern NSString *const kAEDKServiceMethodPOST;  //对应http/https协议的POST方式，或者其他协议的数据修改
extern NSString *const kAEDKServiceMethodHEAD;  //对应http/https协议的HEAD方式，或者其他协议的数据描述获取
extern NSString *const kAEDKServiceMethodDELETE;//对应http/https协议的DELETE方式，或者其他协议的数据删除
extern NSString *const kAEDKServiceMethodPUT;   //对应http/https协议的PUT方式，或者其他协议的数据新增
extern NSString *const kAEDKServiceMethodPATCH; //对应http/https协议的PATCH方式
extern NSString *const kAEDKServiceMethodOPTIONS;   //对应http/https协议的OPTIONS方式
extern NSString *const kAEDKServiceMethodTRACE; //对应http/https协议的TRACE方式
extern NSString *const kAEDKServiceMethodCONNECT;   //对应http/https协议的CONNECT方式
extern NSString *const kAEDKServiceMethodMOVE;  //对应http/https协议的MOVE方式
extern NSString *const kAEDKServiceMethodCOPY;  //对应http/https协议的COPY方式
extern NSString *const kAEDKServiceMethodLINK;  //对应http/https协议的LINK方式
extern NSString *const kAEDKServiceMethodUNLINK;    //对应http/https协议的UNLINK方式
extern NSString *const kAEDKServiceMethodWRAPPED;   //对应http/https协议的WRAPPED方式


//数据服务路径
//缓存的服务路径
extern NSString *const kAEDKServiceCachePathMemory;
extern NSString *const kAEDKServiceCachePathDisk;
extern NSString *const kAEDKServiceCachePathMemoryAndDisk;
//数据库的服务路径
extern NSString *const kAEDKServiceDataBasePathSimple;
extern NSString *const kAEDKServiceDataBasePathSQL;


/**
 数据服务，遵循数据服务协议的服务
 协议格式如下：
 http://domain/path?parameterKey1=parameterValue1&parameterKey2=parameterValue2
 https://domain/path?parameterKey1=parameterValue1&parameterKey2=parameterValue2
 cache://cacheIdentifier/memoryAndDisk?key=value
 file://directory.searchPathDomainMask/path/filename.extension
 db://table.dbname/simple?key1=value1&key2=value2
 db://dbname/sql?urlencodedSQLQueryString
 */
@interface AEDKService : NSObject

/**
 数据服务的名称，用于区别不同的服务，同时唯一
 */
@property (nonatomic, copy) NSString *name;

/**
 数据服务的协议
 */
@property (nonatomic, copy) NSString *protocol;

/**
 数据服务的域
 如果是Http/Https，则表示url的domain；
 如果是Cache，则表示缓存名称，即缓存的id
 如果是File，则表示文件所在的NSSearchPathDirectory和NSSearchPathDomainMask；
 ---如果是Class，则表示提供服务的类名（暂不使用）；
 如果是DataBase，则表示表名和数据库文件名。
 */
@property (nonatomic, copy) NSString *domain;

/**
 数据服务的路径，需用“/”隔开（第一位补“/”，如“/path1/path2/..”）。
 如果是Cache，则表示读取路径是从内存缓存，还是磁盘缓存，或者都有（参考kAEDKServiceCachePath）；
 如果是DataBase，则表示是简单的键值读写，还是sql语句执行（参考kAEDKServiceDataBasePath）
 */
@property (nonatomic, copy) NSString *__nullable path;

/**
 服务请求方式
 遵循http/https协议的服务适用所有kAEDKServiceMethod，其他则只能使用GET/POST/HEAD/DELETE/PUT，默认为GET
 */
@property (nonatomic, copy) NSString *__nullable method;

- (instancetype)initWithProtocol:(NSString *)protocol domain:(NSString *)domain;

- (instancetype)initWithProtocol:(NSString *)protocol domain:(NSString *)domain path:(NSString *__nullable)path method:(NSString *__nullable)method;

/**
 是否合理的数据服务

 @return 是否合理
 */
- (BOOL)isValidService;

@end

NS_ASSUME_NONNULL_END
