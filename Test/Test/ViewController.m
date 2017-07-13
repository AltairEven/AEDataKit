//
//  ViewController.m
//  Test
//
//  Created by Altair on 04/07/2017.
//  Copyright © 2017 Altair. All rights reserved.
//

#import "ViewController.h"
#import <AEDataKit/AEDataKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AEDKHttpServiceConfiguration *config = [AEDKHttpServiceConfiguration defaultConfiguration];
    
    AEDKService *service = [[AEDKService alloc] initWithName:@"TestService" protocol:@"http" domain:@"test.alisports.com" path:@"/testPath" serviceConfiguration:config];
    [[AEDKServer server] registerService:service];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AEDKProcess *process = [[AEDKServer server] requestServiceWithName:@"TestService"];
    process.configuration.BeforeProcess = ^AEDKServiceConfiguration * _Nonnull(AEDKServiceConfiguration * _Nonnull currentconfiguration) {
        NSLog(@"Before Process Callback.");
        return currentconfiguration;
    };
    process.configuration.Processing = ^(int64_t totalAmount, int64_t currentAmount, NSURLRequest * _Nonnull currentRequest) {
        NSLog(@"Processing Callback.");
    };
    process.configuration.AfterProcess = ^id _Nonnull(id  _Nullable responseData) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
