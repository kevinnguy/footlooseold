//
//  FLContactTableViewController.h
//  Footloose
//
//  Created by kevin on 5/17/14.
//  Copyright (c) 2014 kevinnguy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLContactTableViewDelegate <NSObject>

- (void)didSelectContact:(NSString *)contactName image:(UIImage *)image;

@end

@interface FLContactTableViewController : UITableViewController
@property (nonatomic, assign) id<FLContactTableViewDelegate> delegate;
@end
