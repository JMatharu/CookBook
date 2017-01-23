//
//  LandingPageViewController.m
//  CookBook
//
//  Created by Jagdeep Matharu on 2017-01-12.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//

#import "LandingPageViewController.h"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UI
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    //create a left button in the navigation bar for logout
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                     style:UIBarButtonItemStylePlain target:nil
                                                                    action:@selector(logoutFromApplication:)];
    [self.navigationItem setLeftBarButtonItem:logoutButton];
}

- (void) logoutFromApplication:(id) sender{
    
}

@end
