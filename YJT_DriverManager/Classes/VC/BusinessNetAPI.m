//
//  BusinessNetAPI.m
//  SSPNetWork
//
//  Created by ssp on 2019/8/16.
//  Copyright © 2019 ssp. All rights reserved.
//

#import "BusinessNetAPI.h"


#if DevelopSever
/** 接口前缀-开发服务器*/
//NSString *const kApiPrefix = @"http://101.37.24.52:19551";
//NSString *const kApiPrefix = @"http://112.233.243.245:8008/api/";
//NSString *const kApiPrefix = @"http://47.110.125.71:8014/api/";

//NSString *const kApiPrefix = @"http://221.226.116.70:19600";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"https://www.baidu.com";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"https://www.baidu.com";
#endif

@implementation BusinessNetAPI

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(SSRequestSuccess)success
    failure:(SSRequestFailure)failure{
    [BusinessNetAPI requestHTTPMethod:SSRequestMethodGET URLString:URLString parameters:parameters success:success failure:failure];
}


+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(SSRequestSuccess)success
     failure:(SSRequestFailure)failure{
      [BusinessNetAPI requestHTTPMethod:SSRequestMethodPOST URLString:URLString parameters:parameters success:success failure:failure];
}
+ (void)PUT:(NSString *)URLString
  parameters:(id)parameters
     success:(SSRequestSuccess)success
     failure:(SSRequestFailure)failure{
      [BusinessNetAPI requestHTTPMethod:SSRequestMethodPUT URLString:URLString parameters:parameters success:success failure:failure];
}

#pragma mark - 公共参数
+(id)addPublicDic:(id)parameters{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:parameters];
//    [dic setValue:kGlobalManager.token forKey:@"token"];
//    [dic setValue:kGlobalManager.getUUID forKey:@"uuid"];
//    [dic setValue:kGlobalManager.loginUserInfo.UserName forKey:@"username"];
    return dic;
    
}
//    统一参数    统一请求头   统一参数格式
+(id)publickReqConfig:(id)parameters{
    [super publickReqConfig:parameters];
//    NSString *token=kGlobalManager.loginUserInfo.Token;
//    [[SSNetManager sharedAgent] setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
//     [[SSNetManager sharedAgent] setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//    [SSNetworkConfig sharedConfig].baseUrl=kGlobalManager.XUrl;
    return parameters;
}
// 根据实际业务，处理response业务数据
+ (id)analyseResponseSuccess:(id)data{
//    return  [self ungzipDataMethodForDict:data];
    return data;
}
+ (id)analyseResponseFailure:(id)data{
    [super analyseResponseFailure:data];
    if ([data isKindOfClass: [NSError class]]) {
        NSError *errorCode=(NSError*)data;
//        后台定义token失效 错误码未401
        if (errorCode.code == 401) {
           dispatch_async(dispatch_get_main_queue(), ^{
            
//               [[AppDelegate sharedInstance] showLoginView];
                     
                  });
        }
   
    }
    return data;
}
#pragma mark - GZIP解压

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
+(NSDictionary *)dictFromJsonString:(NSString *)string
{
    if (string == nil) {
        return nil;
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
   NSError * __autoreleasing serializationError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&serializationError];
    return dict;
}
//解析
+(id)serializeJSONObject:(id)responseObject error:(NSError * _Nullable __autoreleasing *)error{

    if (responseObject == nil) {
        return nil;
    }
    NSError *validationError = nil;
    if ([responseObject isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)responseObject) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([responseObject isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:nil];
    }
    validationError =[[NSError alloc] initWithDomain:@"数据解析错误" code:0X1000 userInfo:nil];
    *error = validationError;
    return nil;
}



@end
