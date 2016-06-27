//
//  ViewController.m
//  QRCodeBrower
//
//  Created by ChenZS on 16/6/24.
//  Copyright © 2016年 findabox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic, readwrite) NSString *url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.uiwebView];
    [self addObserver:self forKeyPath:@"url" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.url = @"http://www.baidu.com";
    [self goURLWithString:self.url];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)goAction:(id)sender {
    [self goURLWithString:self.urlAddress.text];
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
}

@end
