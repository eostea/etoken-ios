//
//  ETHttpTool.m
//  Etoken
//
//  Created by lingbyAir on 2018/4/19.
//  Copyright © 2018年 eosfans. All rights reserved.
//

#import "ETHttpTool.h"
#import "AFNetworking.h"

#define domin @"http://cn.party.eosfans.io:8888"

@implementation ETHttpTool

SINGLETON_FOR_CLASS_M(ETHttpTool)

- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *dic))success failure:(void (^)(NSError *error))failure
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [self setActivityVisible:YES];
    
    NSString *mUrl = [NSString stringWithFormat:@"%@%@",domin,url];
    [manager GET:mUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self setActivityVisible:NO];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if (success) {
            success(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self setActivityVisible:NO];
        if (failure) {
            failure(error);
        }
        
    }];
}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *dic))success failure:(void (^)(NSError *error))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [self setActivityVisible:YES];
    NSString *mUrl = [NSString stringWithFormat:@"%@%@",domin,url];

    [manager POST:mUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self setActivityVisible:NO];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if (success) {
            success(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self setActivityVisible:NO];
        
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)setActivityVisible:(BOOL)isVisible
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:isVisible];
}


@end
