//
//  CarInformation.h
//  R2Hot
//
//  Created by Sosena Bekele on 10/30/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInformation : UITableViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)backToSearch:(id)sender;

@property (strong, nonatomic) NSMutableArray *carInfo;

@end
