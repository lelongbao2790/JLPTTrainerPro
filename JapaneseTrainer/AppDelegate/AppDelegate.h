//
//  AppDelegate.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/23/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationCustomController.h"
#import "TabBarCustomController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NavigationCustomController *navHomeController;
@property (strong, nonatomic) TabBarCustomController *tabbar;

+ (AppDelegate *)share;

@end

