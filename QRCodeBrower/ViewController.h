//
//  ViewController.h
//  QRCodeBrower
//
//  Created by ChenZS on 16/6/24.
//  Copyright © 2016年 findabox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *headBarView;
@property (weak, nonatomic) IBOutlet UITextField *urlAddress;
@property (weak, nonatomic) IBOutlet UIButton *qrButton;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIWebView *uiwebView;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

