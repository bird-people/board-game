//
//  global.h
//  Shopping
//
//  Created by simple on 2018/6/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#ifndef global_h
#define global_h

#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define RATIO_WIDHT320 [UIScreen mainScreen].bounds.size.width/320.0
#define RATIO_WIDHT750 [UIScreen mainScreen].bounds.size.width/375.0

#define NAV_STATUS_HEIGHT 64
#define NAV_HEIGHT 44
#define TABBAR_HEIGHT 49

//颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1)
#define RGB3(v) RGB(v,v,v)

#define randomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#endif /* global_h */
