//
//  CarDetails.m
//  R2Hot
//
//  Created by Sosena Bekele on 10/30/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import "CarDetails.h"

@interface CarDetails ()

@end

@implementation CarDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dropOffDayLabel.text = self.DropOffDay;
    self.DropOffTimeLabel.text= self.DropOffTime;
    self.linkLabel.text = self.link;
    self.priceLabel.text = [NSString stringWithFormat:@"$ %@",self.price];
    self.pickUpTimeLabel.text = self.pickUpTime;
    self.locationLabel.text = self.location;
    self.pickUpDayLabel.text = self.pickUpDay;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
@end
