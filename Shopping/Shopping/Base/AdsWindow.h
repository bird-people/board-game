//
//  AdsWindow.h
//  ab
//
//  Created by yanyu on 2018/5/11.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

static UIWindow *adsWindow = nil;

@interface AdsWindow : UIWindow
- (id)init;
- (void)updateData:(NSString*)urlStr withTime:(NSInteger)time;
- (void)show;
- (void)dismiss;
@end
