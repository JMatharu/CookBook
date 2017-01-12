//
//  PlistHelper.m
//  CookBook
//
//  Created by Jagdeep Matharu on 2017-01-12.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//

#import "PlistHelper.h"

@implementation PlistHelper

- (NSString *) getPlistInfoFromGoogleServicewithKey:(NSString *)key {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GoogleService-Info" ofType:@"plist"];
    NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSString *value = dictPlist[key.uppercaseString];
    return value;
}

@end
