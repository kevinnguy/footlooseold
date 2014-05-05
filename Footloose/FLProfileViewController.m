//
//  FLProfileViewController.m
//  Footloose
//
//  Created by kevin on 5/5/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLProfileViewController.h"

@interface FLProfileViewController ()

@end

@implementation FLProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar
{
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *homeBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(homeBarButtonPressed:)];
    
    self.navigationItem.leftBarButtonItem = homeBarButton;
}

- (void)homeBarButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
