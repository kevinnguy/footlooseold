//
//  FLMainViewController.m
//  Footloose
//
//  Created by kevin on 5/5/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLMainViewController.h"

@interface FLMainViewController () <UITableViewDataSource, UITableViewDelegate>

@end

#define CELL_IDENTIFIER @"CellIdentifier"

@implementation FLMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(menuBarButtonPressed:)];
    
    UIBarButtonItem *addFriendBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Friend" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriendBarButtonPressed:)];
    
    self.navigationItem.leftBarButtonItem = menuBarButton;
    self.navigationItem.rightBarButtonItem = addFriendBarButton;
}

- (void)setupTableView
{
    self.notificationTableView.delegate = self;
    self.notificationTableView.dataSource = self;
    
    
}

- (void)menuBarButtonPressed:(id)sender
{
    
}

- (void)addFriendBarButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"SegueToAddFriend" sender:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    cell.textLabel.text = @"Some notification";
    
    return cell;
}

@end
