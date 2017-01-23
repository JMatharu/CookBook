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
#import "LandingPageViewController.h"

@interface LoginPageViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *signInWithGoogle;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //UI
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    FlatUIHelper *flatUIObj = [[FlatUIHelper alloc] init];
    [flatUIObj flatButton:self.signInWithGoogle withTitle:@"Sign In With Google"withWidth:300 withHeight:50];
    
    //Setup Firebase
    [self setFirebase];
    self.ref = [[FIRDatabase database] reference];
    
    
    
}

- (IBAction)clickSigninWithGoogle:(id)sender {
     [[GIDSignIn sharedInstance] signIn];
//        [self.navigationController performSegueWithIdentifier:@"LandingPageSegue" sender:self];
    
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
                
                //Temp Solution , move to helper
                UIDevice *device = [UIDevice currentDevice];
                NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
                
                NSDictionary *userInformation = @{@"email" : user.email,
                                                  @"photoURL" : user.photoURL.absoluteString,
                                                  @"displayName" : user.displayName,
                                                  @"isActiveUser" : @"True",
                                                  @"deviceId" : currentDeviceId};
                FIRDatabaseReference *usersReference = [_ref child:@"users"];
                FIRDatabaseReference *newUserReference = [usersReference child:user.uid];
                [newUserReference setValue:userInformation];
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
        
        //Temp Solution move to helper
        UIDevice *device = [UIDevice currentDevice];
        NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
        
        [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
            NSDictionary *userInformation = @{@"email" : user.email,
                                              @"photoURL" : user.photoURL.absoluteString,
                                              @"displayName" : user.displayName,
                                              @"isActiveUser" : @"False",
                                              @"deviceId" : currentDeviceId};
            
            FIRDatabaseReference *usersReference = [_ref child:@"users"];
            FIRDatabaseReference *newUserReference = [usersReference child:user.uid];
            [newUserReference setValue:userInformation];
        }];
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:NULL];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LaunchScreenSB"];
        [[self navigationController] pushViewController:vc animated:YES];
//        LandingPageViewController *landingPageViewController = [[LandingPageViewController alloc] init];
//        [self.navigationController pushViewController:landingPageViewController animated:YES];
    }
}

-(void) setFirebaseUserData {
//    FIrebase
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
