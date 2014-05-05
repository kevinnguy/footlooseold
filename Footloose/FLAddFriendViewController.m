//
//  FLAddFriendViewController.m
//  Footloose
//
//  Created by kevin on 5/5/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLAddFriendViewController.h"

@interface FLAddFriendViewController ()

@end

@implementation FLAddFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.phoneNumberTextField becomeFirstResponder];
}

- (IBAction)addFriendButtonPressed:(id)sender
{
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:nil
                                                                     action:nil];
    self.navigationItem.backBarButtonItem = backBarButton;
    
    [self performSegueWithIdentifier:@"SegueToProfile" sender:self];
}

@end
