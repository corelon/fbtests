//
//  TFBViewController.m
//  TestingFB
//
//  Created by Nikos Tzanos on 6/2/13.
//  Copyright (c) 2013 Nikos Tzanos. All rights reserved.
//

#import "TFBViewController.h"
#import "TFBAppDelegate.h"
#import "ShareViewController.h"

@interface TFBViewController ()
- (IBAction)publishButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
- (IBAction)sendRequestButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendRequestButton;


@end

@implementation TFBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    
    // Check the session for a cached token to show the proper authenticated
    // UI. However, since this is not initiated by the person using your
    // app, do not show the login UX.
    TFBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sessionStateChanged:(NSNotification *)notification
{
    if (FBSession.activeSession.isOpen) {
        self.publishButton.hidden = NO;
        [self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
        
        self.sendRequestButton.hidden = NO;
    } else {
        self.publishButton.hidden = YES;
        [self.authButton setTitle:@"Login" forState:UIControlStateNormal];
        
        self.sendRequestButton.hidden = YES;
    }
}

- (IBAction)authButtonAction:(id)sender {
    TFBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the person is authenticated, log out when the button is clicked.
    // If the person is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        // The person has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    
}
- (IBAction)publishButtonAction:(id)sender {
    ShareViewController *viewController = [[ShareViewController alloc]
                                           initWithNibName:@"ShareViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)sendRequestButtonAction:(id)sender {
    TFBAppDelegate *appDelegate = (TFBAppDelegate *) [[UIApplication sharedApplication] delegate];
    if (FBSession.activeSession.isOpen) {
        [appDelegate sendRequest];
    }
}
@end
