//
//  CarDetails.h
//  R2Hot
//
//  Created by Sosena Bekele on 10/30/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetails : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *linkLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *DropOffTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *pickUpTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dropOffDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *pickUpDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *location;
@property(nonatomic, strong) NSString *pickUpTime;
@property(nonatomic, strong) NSString *pickUpDay;
@property(nonatomic, strong) NSString *link;
@property(nonatomic, strong) NSString *DropOffTime;
@property(nonatomic, strong) NSString *DropOffDay;
@end
