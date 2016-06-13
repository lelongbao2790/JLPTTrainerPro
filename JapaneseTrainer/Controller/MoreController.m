//
//  MoreController.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/10/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "MoreController.h"

@interface MoreController ()

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnHistory:(id)sender {
}

- (IBAction)btnHome:(id)sender {
    
    [Utilities changeRootViewToTabBar:nil andView:[AppDelegate share].navHomeController isTabbar:NO];
    
}

@end
