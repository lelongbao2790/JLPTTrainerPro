//
//  NavCustomHomeController.m
//  JLPTTrainerPro
//
//  Created by Bao (Brian) L. LE on 6/13/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "NavCustomHomeController.h"

@interface NavCustomHomeController ()<UINavigationControllerDelegate>

@end

@implementation NavCustomHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    }
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[GrammarController class]] ||
        [viewController isKindOfClass:[VocabularyController class]] ||
        [viewController isKindOfClass:[BookmarkController class]] ||
        [viewController isKindOfClass:[AlphabetController class]]) {
         [self createHomeBarButton:viewController];
    }
}

- (void)createHomeBarButton:(UIViewController *)controller {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;// it was -6 in iOS 6  you can set this as per your preference
    
    
    UIImage* imageHome = [UIImage imageNamed:@"home_nav.png"];
    CGRect frameimg = CGRectMake(0,0, 38,38);
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:frameimg];
    [homeButton setBackgroundImage:imageHome forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(moveToHome)
         forControlEvents:UIControlEventTouchUpInside];
    [homeButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *barHomebutton =[[UIBarButtonItem alloc] initWithCustomView:homeButton];
    [controller.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,barHomebutton, nil] animated:NO];
}

- (void)moveToHome {
    [Utilities changeRootViewToTabBar:nil andView:[AppDelegate share].navHomeController isTabbar:NO];
}

@end
