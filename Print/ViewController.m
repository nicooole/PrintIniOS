//
//  ViewController.m
//  Print
//
//  Created by nanke on 16/7/27.
//  Copyright © 2016年 nanke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate, UIPrintInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)printAction:(UIBarButtonItem *)sender;

@property (nonatomic, strong) NSString *currentUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.currentUrl = webView.request.URL.absoluteString;
    
    NSLog(@"URL:%@", self.currentUrl);
}

- (IBAction)printAction:(UIBarButtonItem *)sender {
    UIPrintInteractionController *printC =[UIPrintInteractionController sharedPrintController];
    
    printC.delegate = self;
    
    //准备打印信息以预设值初始化的对象
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    //设置输出类型
    printInfo.outputType = UIPrintInfoOutputGeneral;
    //横向打印
    printInfo.orientation = UIPrintInfoOrientationLandscape;
    //显示的页面范围
    printC.showsPageRange = YES;
    
    printC.printInfo = printInfo;
    
    //打印页面(网页)
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.115/NormalEvaluate.html?evaluateNo=J4181A160217001"]]];
    //布局打印视图绘制的内容
    printC.printFormatter = [self.webView viewPrintFormatter];
    
    void (^completionHandle)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            NSLog(@"可能无法完成，因为印刷错误: %@", error);
        }
    };
    //如果设备是iPad时
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [printC presentFromBarButtonItem:self.navigationItem.leftBarButtonItem
                                animated:YES
                       completionHandler:completionHandle];
    }
    else
    {
        [printC presentAnimated:YES completionHandler:completionHandle];//在iPhone上弹出打印那个页面
    }

}
@end
