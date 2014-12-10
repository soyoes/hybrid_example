//
//  ViewController.m
//  snowmatch
//
//  Created by soyoes on 12/9/14.
//  Copyright (c) 2014 Liberhood ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"web"]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
