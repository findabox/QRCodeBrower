//
//  ViewController.m
//  QRCodeBrower
//
//  Created by ChenZS on 16/6/24.
//  Copyright © 2016年 findabox. All rights reserved.
//

#import "ViewController.h"
#import "NJKWebViewProgressView.h"

@interface ViewController ()

@property (strong, nonatomic, readwrite) NSString *url;
@property (strong, nonatomic, readwrite) NJKWebViewProgressView *progressView;
@property (strong, nonatomic, readwrite) NJKWebViewProgress *progressProxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.uiwebView];
    [self addObserver:self forKeyPath:@"url" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goWithNotificationURL:) name:@"QRCodeValueKey" object:nil];
    [self configProgress];
    
    self.url = @"http://www.baidu.com";
    [self goURLWithString:self.url];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.headBarView addSubview:self.progressView];
}

- (void)configProgress {
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.uiwebView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.headBarView.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
}

- (IBAction)goAction:(id)sender {
    [self goURLWithString:self.urlAddress.text];
}

- (void)goWithNotificationURL:(NSNotification *)notification {
    self.url = notification.object;
    [self goURLWithString:self.url];
}

- (void)goURLWithString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.uiwebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"url"]) {
        self.urlAddress.text = self.url;
        NSLog(@"Url change to %@", self.url);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goAction:textField];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.status.text = @"Start";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.status.text = @"Finished";
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    self.status.text = @"Error";
    NSString *errorMessage = [NSString stringWithFormat:@"url: %@\n error:%@",
                              self.urlAddress.text,
                              [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}

@end
