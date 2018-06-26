//
//  WindowDateSelect.m
//  LockDemo
//
//  Created by yanyu on 2018/4/27.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "AdsWindow.h"

#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICEHEIGHT [UIScreen mainScreen].bounds.size.height

@interface AdsWindow()

@property (nonatomic, strong) UIView *mainView;
@property(nonatomic,strong)UIWebView *ivAds;
@property(nonatomic,assign)NSInteger time;

@property(nonatomic,strong)UIButton *btnExit;
@property (nonatomic, strong) dispatch_source_t _timer;

@property(nonatomic,strong)UIView *vBg;
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)NSString *url;
@end

@implementation AdsWindow

- (id)init
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        adsWindow = self;
        [self setupSubviews];
    }
    
    return self;
}

- (void)updateData:(NSString*)urlStr withTime:(NSInteger)time{
    _time = time;
    
    _url = urlStr;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.ivAds loadRequest:request];
    [self startTimer];
    
}

- (void)setupSubviews{
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_mainView];

    
    _ivAds = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];

    _ivAds.contentMode = UIViewContentModeScaleAspectFit;
    _ivAds.scrollView.alwaysBounceHorizontal = NO;
    _ivAds.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:_ivAds];
    
    

    
    
    [_mainView addSubview:_btnExit];
    
    
    _vBg = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 75, 80, 60)];
    _vBg.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    _vBg.layer.cornerRadius = 17.5;
    [_mainView addSubview:_vBg];
    
    _ivImg = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, 25, 25)];
    _ivImg.image = [UIImage imageNamed:@"tb1"];
    _ivImg.backgroundColor = [UIColor redColor];
    [_vBg addSubview:_ivImg];
    
    _lbText = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, _vBg.frame.size.width, 16)];
    _lbText.textColor = [UIColor whiteColor];
    _lbText.font = [UIFont systemFontOfSize:14];
    _lbText.textAlignment = NSTextAlignmentCenter;
    _lbText.text = @"回首页";
    [_vBg addSubview:_lbText];
    
    /*
    _btnRefresh = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 55, 80, 35)];
    [_btnRefresh setTitle:@"回首页" forState:UIControlStateNormal];
    _btnRefresh.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btnRefresh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnRefresh.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [_btnRefresh addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnRefresh.layer.cornerRadius = 17.5;
    [_mainView addSubview:_btnRefresh];
    */
}

- (void)clickAction:(UIButton*)sender{
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.ivAds loadRequest:request];
}

- (void)startTimer{
    NSInteger ts = self.time;
    __block NSInteger t = ts;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self._timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(self._timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __weak typeof(self) weakself = self;
    dispatch_source_set_event_handler(self._timer, ^{
        
        if(t<= 0){ //倒计时结束，关闭
            dispatch_source_cancel(weakself._timer);
            weakself._timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself dismiss];
            });
        }else{
            t--;
        }
    });
    dispatch_resume(weakself._timer);
}

- (void)dealloc{
    NSLog(@"[DEBUG] delloc:%@",self);
}

- (void)show {
    [self makeKeyAndVisible];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.mainView.alpha = 1.0;
    }];
}

- (void)dismiss {
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        adsWindow.alpha = 0;
        weakself.mainView.alpha = 0;
    } completion:^(BOOL finished) {
        NSArray *subs = [adsWindow subviews];
        for (UIView *v in subs) {
            [v removeFromSuperview];
        }
        adsWindow = nil;
        [self resignKeyWindow];
    }];
    
}

@end
