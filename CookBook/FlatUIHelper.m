//
//  FlatUIHelper.m
//  CookBook
//
//  Created by Jagdeep Matharu on 2017-01-09.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//

#import "FlatUIHelper.h"

@implementation FlatUIHelper

- (FUIButton *) flatButton:(FUIButton *)uiButton withTitle:(NSString *)title withWidth:(CGFloat)width withHeight:(CGFloat)height{
    uiButton.buttonColor = [UIColor turquoiseColor];
    uiButton.shadowColor = [UIColor greenSeaColor];
    uiButton.shadowHeight = 3.0f;
    uiButton.cornerRadius = 6.0f;
    uiButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [uiButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [uiButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [uiButton setTitle:title forState:UIControlStateNormal];
    // Button Dimentions
    CGRect buttonFrame = uiButton.frame;
    buttonFrame.size = CGSizeMake(width, height);
    uiButton.frame = buttonFrame;
    return uiButton;
}

@end
