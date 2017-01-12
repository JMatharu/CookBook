//
//  FlatUIHelper.h
//  CookBook
//
//  Created by Jagdeep Matharu on 2017-01-09.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlatUIKit.h"
#import <FlatUIKit/FlatUIKit.h>

@interface FlatUIHelper : NSObject

- (FUIButton *) flatButton: (FUIButton *) uiButton
                 withTitle:(NSString *) title
                 withWidth:(CGFloat) width
                withHeight:(CGFloat) height;

@end
