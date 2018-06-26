//
//  VCContent.m
//  Shopping
//
//  Created by simple on 2018/6/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCContent.h"

@interface VCContent ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation VCContent

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.title = [self.data jk_stringForKey:@"title"];
    [self.webView loadHTMLString:[self installHtml:[self.data jk_stringForKey:@"content"]] baseURL:nil];
}


- (NSString*)installHtml:(NSString*)content{
    if(!content){
        content = @"";
    }
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"notice.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];
    [html appendString:content];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}

- (UIWebView*)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    }
    return _webView;
}

@end
