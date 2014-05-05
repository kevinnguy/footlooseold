//
//  FLLoginViewController.m
//  Footloose
//
//  Created by kevin on 5/5/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLLoginViewController.h"

@interface FLLoginViewController ()

@end

@implementation FLLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)loginButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"SegueToMain" sender:self];
}


@end
