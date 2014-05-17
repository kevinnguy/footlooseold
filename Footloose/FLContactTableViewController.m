//
//  FLContactTableViewController.m
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import "FLContactTableViewController.h"

#import "FLContactTableViewCell.h"

@interface FLContactTableViewController ()
@property (nonatomic, strong) NSMutableArray *contactArray;
@end

static NSString * const kJSQDemoAvatarNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarNameJobs = @"Steve Jobs";
static NSString * const kJSQDemoAvatarNameWoz = @"Steve Wozniak";

static NSString * const kCellIdentifier = @"FLContactTableViewCellIdentifier";


@implementation FLContactTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contactArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        NSString *name;
        if (i % 3 == 0) {
            name = kJSQDemoAvatarNameCook;
        }
        else if (i % 3 == 1) {
            name = kJSQDemoAvatarNameJobs;
        }
        else {
            name = kJSQDemoAvatarNameWoz;
        }
        
        [self.contactArray addObject:name];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FLContactTableViewCell" bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
    FLContactTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    self.tableView.rowHeight = CGRectGetHeight(cell.frame);
    
    self.tableView.sectionHeaderHeight = 20.0f;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = self.tableView.backgroundColor;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLContactTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    cell.contactTextLabel.text = self.contactArray[indexPath.row];
    
    if ([cell.contactTextLabel.text isEqualToString:kJSQDemoAvatarNameCook]) {
        cell.contactImageView.image = [UIImage imageNamed:@"demo_avatar_cook"];
    }
    else if ([cell.contactTextLabel.text isEqualToString:kJSQDemoAvatarNameJobs]) {
        cell.contactImageView.image = [UIImage imageNamed:@"demo_avatar_jobs"];
    }
    else {
        cell.contactImageView.image = [UIImage imageNamed:@"demo_avatar_woz"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLContactTableViewCell *cell = (FLContactTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [self.delegate didSelectContact:cell.contactTextLabel.text image:cell.contactImageView.image];
    
}

@end
