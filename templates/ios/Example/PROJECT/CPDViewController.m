//
//  CPDViewController.m
//  PROJECT
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright (c) TODAYS_YEAR PROJECT_OWNER. All rights reserved.
//

#import "CPDViewController.h"
#import <AEDataKit/AEDataKit.h>
#import "PostCodeModel.h"

@interface CPDViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CPDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.imageView.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
    AEDKHttpServiceConfiguration *config = [AEDKHttpServiceConfiguration defaultConfiguration];
    
    AEDKService *service = [[AEDKService alloc] initWithName:@"TestService" protocol:@"http" domain:@"test.alisports.com" path:@"/testPath" serviceConfiguration:config];
    [[AEDKServer server] registerService:service];
    
    AEDKImageViewPlaceholder *placeholder = [[AEDKImageViewPlaceholder alloc] init];
    placeholder.placeholderImage = [UIImage imageNamed:@"80_80.jpg"];
    placeholder.imageViewMinRatio = 0;
    placeholder.imageViewMaxRatio = CGFLOAT_MAX;
    placeholder.showMode = UIViewContentModeCenter;
    
    UIImage *image = [placeholder fitPlaceholderImageForView:self.imageView];
    [self.imageView setImage:image];
    
    
    [self testImageView];
    [self normalRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [AEDKCacheOperation setObject:@"test quick set" forKey:@"test key"];
    
    id value = [AEDKCacheOperation objectForKey:@"test key"];
    NSLog(@"%@", value);
    
    AEDKProcess *process = [[AEDKServer server] requestServiceWithName:@"TestService"];
    process.configuration.BeforeProcess = ^(AEDKProcess * _Nonnull process) {
        NSLog(@"Before Process Callback.");
    };
    process.configuration.Processing = ^(int64_t totalAmount, int64_t currentAmount, NSURLRequest * _Nonnull currentRequest) {
        NSLog(@"Processing Callback.");
    };
    process.configuration.AfterProcess = ^id _Nonnull(AEDKProcess * _Nonnull currentProcess, NSError * _Nonnull error, id  _Nullable responseData) {
        NSLog(@"After Process Callback.");
        return responseData;
    };
    process.configuration.ProcessCompleted = ^(AEDKProcess * _Nonnull currentProcess, NSError * _Nonnull error, id  _Nullable responseModel) {
        NSLog(@"Process Completed Callback.");
    };
    [process start];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testImageView{
    AEDKWebImageLoader *loader = [[AEDKWebImageLoader alloc]init]; 
    [loader setImageForImageView:_imageView withURL:[NSURL URLWithString:@"http://img3.redocn.com/tupian/20150312/haixinghezhenzhubeikeshiliangbeijing_3937174.jpg"] placeholderImage:nil progress:^(int64_t totalAmount, int64_t currentAmount) {
        
    } completed:^(NSURL * _Nullable imageUrl, UIImage * _Nullable image, NSError * _Nullable error) {
        NSLog(@"图片请求结束");
    }];
    
    
}

- (void)normalRequest{
    AEDKProcess *process = [[AEDKServer server] requestServiceWithName:@"AskPostCodes"];
    process.configuration.BeforeProcess = ^(AEDKProcess * _Nonnull process) {
        //        if ([process.configuration isKindOfClass:[AEDKHttpServiceConfiguration class]]) {
        //            AEDKHttpServiceConfiguration *config = (AEDKHttpServiceConfiguration *)(process.configuration);
        //            config.requestParameter = @{@"f":@"f"};
        //        }
    };
    process.configuration.Processing = ^(int64_t totalAmount, int64_t currentAmount, NSURLRequest * _Nonnull currentRequest) {
    };
    
    process.configuration.AfterProcess = ^id _Nonnull(AEDKProcess * _Nonnull currentProcess, NSError * _Nonnull error, id  _Nullable responseData) {
        NSArray *modelArray = [PostCodeModel allPostcode:(NSDictionary *)responseData];
        return modelArray;
    };
    
    process.configuration.ProcessCompleted = ^(AEDKProcess * _Nonnull currentProcess, NSError * _Nonnull error, id  _Nullable responseModel) {
        // final result
        NSLog(@"请求完全结束");
    };
    [process start];
}

@end
