//
//  AppDelegate.h
//  CookBook
//
//  Created by Jagdeep Matharu on 2017-01-09.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LandingPageViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@property (strong, nonatomic) LandingPageViewController *landingPageViewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end

