//
//  NetManager.h
//  BlueToothDemo
//
//  Created by yanyu on 2018/6/11.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+(NetManager *)shareInstance;

- (void)requestPost:(NSString*)url paramater:(NSDictionary*)param withSuccess:(void(^)(id resobject))successBlock withFailure:(void(^)(NSError *error))errorBlock;

@end
