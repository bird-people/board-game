//
//  NetManager.m
//  BlueToothDemo
//
//  Created by yanyu on 2018/6/11.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "NetManager.h"

static NetManager *_netManager;

@interface NetManager()
@property(nonatomic,strong)NSURLSessionConfiguration *configuration;
@property(nonatomic,strong)AFURLSessionManager *manager;
@end


@implementation NetManager


+(NetManager *)shareInstance
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        _netManager = [[NetManager alloc]init];
    });
    return _netManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:_configuration];
    }
    return self;
}

- (void)requestPost:(NSString*)url paramater:(NSDictionary*)param withSuccess:(void(^)(id resobject))successBlock withFailure:(void(^)(NSError *error))errorBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_Url,url];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:param error:nil];
    request.timeoutInterval = 10.0;
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    self.manager.responseSerializer = serializer;
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            if (errorBlock) {
                errorBlock(error);
            }
        } else {
            NSLog(@"%@",responseObject);
            if (successBlock) {
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
}

//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
@end
