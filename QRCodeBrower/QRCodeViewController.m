//
//  QRCodeViewController.m
//  QRCodeBrower
//
//  Created by ChenZS on 16/6/27.
//  Copyright © 2016年 findabox. All rights reserved.
//

#import "QRCodeViewController.h"
#import <ZBarSDK/ZBarSDK.h>

@interface QRCodeViewController ()<ZBarReaderViewDelegate>

@property (strong, nonatomic, readwrite) NSString *stringValue;
@property (weak, nonatomic) IBOutlet UIView *qcView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZBarReaderView * view = [[ZBarReaderView alloc] init];
    
    view.frame = CGRectMake(0, 0, 220, 220);
    
    view.readerDelegate = self;
    
    view.torchMode = 0;
    
    [self.qcView addSubview:view];
    
    [view start];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image {
    for (ZBarSymbol * symbol in symbols){
        if (symbol.type == ZBAR_QRCODE) {
            if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
                self.stringValue = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
                NSLog(@"%@",self.stringValue);
            }
        }
        break;
    }
    [self dismiss];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"QRCodeValueKey" object:self.stringValue];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
