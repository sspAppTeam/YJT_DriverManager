//
//  SSHttpRequest.m
//  SSPNetWork
//
//  Created by ssp on 2019/8/15.
//  Copyright © 2019 ssp. All rights reserved.
//


#import "SSHttpRequest.h"
#import "SSNetManager.h"
#import "SSNetworkConfig.h"


@implementation SSHttpRequest


#pragma mark - 请求的公共方法

+ (void)requestHTTPMethod:(SSRequestMethod)method
                URLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(SSRequestSuccess)success
                  failure:(SSRequestFailure)failure
{
    NSAssert(URLString, @"请求地址不能为空");
    NSAssert([SSNetworkConfig sharedConfig].baseUrl, @"请求地址不能为空");
    parameters =[self publickReqConfig:parameters];
    //    针对url已经是请求地址的情况如：激活码
    URLString =  [URLString hasPrefix:@"http:"]?URLString:[[SSNetworkConfig sharedConfig].baseUrl stringByAppendingString:URLString];
    
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    switch (method) {
        case SSRequestMethodGET:
        {
            __block  NSURLSessionTask *dataTask=  [[SSNetManager sharedAgent] GET:URLString parameters:parameters success:^(id  _Nullable responseObject) {
                [self parseResponseData:dataTask response:responseObject success:success failure:failure];
            } failure:^(NSError * _Nullable error) {
                [self parseResponseFailed:error failure:failure];
            }];
        }
            break;
        case SSRequestMethodPOST:
        {
            __block   NSURLSessionTask *dataTask =  [[SSNetManager sharedAgent] POST:URLString parameters:parameters success:^(id  _Nullable responseObject) {
                [self parseResponseData:dataTask response:responseObject success:success failure:failure];
            } failure:^(NSError * _Nullable error) {
                [self parseResponseFailed:error failure:failure];
            }];
        }
            break;
            
        default:
            
            break;
    }
    
}

//    统一参数    统一请求头   统一参数格式
+(id)publickReqConfig:(id)parameters{
    [[SSNetManager sharedAgent] setRequestTimeoutInterval:SSDefautetimeoutInterval];
    [[SSNetManager sharedAgent] setRequestSerializer:SSRequestSerializerJSON];
    return parameters;
}
+ (id)analyseResponseSuccess:(id)data{
    return data;
}
+ (id)analyseResponseFailure:(id)data{
    return data;
}
#pragma mark - net call back
+ (void)parseResponseData:(NSURLSessionTask*)task
                 response:(id)responseObject
                  success:(SSRequestSuccess)success
                  failure:(SSRequestFailure)failure
{
    NSError * __autoreleasing serializationError = nil;
    NSError * __autoreleasing validationError = nil;
    
    NSError *requestError = nil;
    BOOL succeed = YES;
    id dicResp = [self serializeJSONObject:responseObject error:&serializationError];
//    NSString *code = [NSString stringWithFormat:@"%@",[dicResp valueForKey:[SSNetworkConfig sharedConfig].net_resp_code_key]];
//    id data = [dicResp objectForKey:[SSNetworkConfig sharedConfig].net_resp_body_key];
//    if (![code isEqualToString:[SSNetworkConfig sharedConfig].net_resp_succ_code]) {
//        validationError=[[NSError alloc] initWithDomain:[code intValue] == 3?@"参数有误，参数为空":@"接口调用失败" code:[code intValue] userInfo:nil];
//    }
    NSHTTPURLResponse *responses = (NSHTTPURLResponse *)task.response;
    
    if (serializationError) {
        succeed = NO;
        requestError = serializationError;
    }else if (validationError){
        succeed = NO;
        requestError = validationError;
    }
    if ([dicResp isKindOfClass:[NSArray class]]) {
        
    }else
    {
       if ([dicResp objectForKey:@"code"] && [dicResp objectForKey:@"message"]) {
                   NSInteger code=responses.statusCode;
                      succeed = NO;
                   requestError = [[NSError alloc] initWithDomain:[dicResp objectForKey:@"message"] code:code == 401 ? code :[[dicResp objectForKey:@"code"] intValue] userInfo:nil];;
                 }
    }
  
    
    id resultData;
    
    if (succeed) {
      resultData = [self analyseResponseSuccess:dicResp];
        success(resultData);
    } else {
         resultData = [self analyseResponseFailure:requestError];
        failure(resultData);
    }
   
   
      NetLog(@"\n**************************************\n网络 URL= %@ \n METHOD=%@ \n HEADER=%@ \n RESPONSE= %@\n**************************************",task.currentRequest.URL,task.currentRequest.HTTPMethod,task.currentRequest.allHTTPHeaderFields,[self jsonStringWithDictionary:dicResp]);
    
}

+ (void)parseResponseFailed:(id)responseObject
                    failure:(SSHttpRequestFailed)failure
{
    NSError *error=(NSError *)responseObject;
    if ([responseObject isKindOfClass:[NSError class]]) {
        NSString * errorString =[error.userInfo objectForKey:@"NSLocalizedDescription"];
        errorString = [errorString isEqualToString:@""]?error.domain:errorString;
        
    }
     id errorData = [self analyseResponseFailure:error];
    failure(errorData);
}

//解析
+(id)serializeJSONObject:(id)responseObject error:(NSError * _Nullable __autoreleasing *)error{
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

// dict字典转json字符串
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict
{
    if (dict && 0 != dict.count)
    {
        NSError *error = nil;
        // NSJSONWritingOptions 是"NSJSONWritingPrettyPrinted"的话有换位符\n；是"0"的话没有换位符\n。
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    
    return nil;

}

@end
