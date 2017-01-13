//
//  ViewController.m
//  CookBook
//
//  Created by Jagdeep Matharu on 2017-01-09.
//  Copyright © 2017 Jagdeep Matharu. All rights reserved.
//
@import Firebase;
@import GoogleSignIn;
#import "FlatUIKit.h"
#import "PlistHelper.h"
#import "FlatUIHelper.h"
#import "LoginPageViewController.h"
#import <FlatUIKit/FlatUIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface LoginPageViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *signInWithGoogle;


@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FlatUIHelper *flatUIObj = [[FlatUIHelper alloc] init];
    [flatUIObj flatButton:self.signInWithGoogle withTitle:@"Sign In With Google"withWidth:300 withHeight:50];
    
    //Setup Firebase
    [self setFirebase];
    
}

- (IBAction)clickSigninWithGoogle:(id)sender {
     [[GIDSignIn sharedInstance] signIn];
}

- (IBAction)clearCache:(id)sender {
    [[GIDSignIn sharedInstance] disconnect];
}

//FireBase
- (void) setFirebase{
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    PlistHelper *plistHelperObj = [[PlistHelper alloc] init];
    signIn.clientID = [plistHelperObj getPlistInfoFromGoogleServicewithKey:@"client_id"];
    signIn.shouldFetchBasicProfile = YES;
    signIn.scopes = @[@"profile", @"email"];
    signIn.delegate = self;
    signIn.uiDelegate = self;
}

-(void) signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    if (error==nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken accessToken:authentication.accessToken];
        
        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            AMSmoothAlertView *alert;
            if (user) {
                alert = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Success"
                                                                  andText:[NSString stringWithFormat:@"Welcome %@", user.displayName]
                                                          andCancelButton:NO
                                                             forAlertType:AlertSuccess];
            } else {
                alert = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Failure"
                                                                  andText:@"Sorry Something Went Wrong"
                                                          andCancelButton:NO
                                                             forAlertType:AlertFailure];
            } //WIFI Connectivity TODO
            [alert show];
        }];
    }
}

-(void) signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error{
    if (error==nil) {
        AMSmoothAlertView *alert;
        alert = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"Good By !!"
                                                          andText:@""
                                                  andCancelButton:NO
                                                     forAlertType:AlertInfo];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
