//
//  CarInformation.m
//  R2Hot
//
//  Created by Sosena Bekele on 10/30/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import "CarInformation.h"
#import "CarDetails.h"
@interface CarInformation ()

@end

@implementation CarInformation

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.carInfo count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *carInfo = [self.carInfo objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showDetail" sender:carInfo];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDetail"]){
       // UINavigationController *nagivation = segue.destinationViewController;
        CarDetails *controller = (CarDetails *) segue.destinationViewController;
        NSMutableDictionary *carInfo = (NSMutableDictionary*)sender;
        NSString *price = (NSString*)[ [carInfo objectForKey:@"price"] objectForKey:@"text"];
         NSString *location  = (NSString*)[[carInfo objectForKey:@"location"] objectForKey:@"text"];
         NSString *pickUpTime = (NSString*)[[carInfo objectForKey:@"PickupTime"] objectForKey:@"text"];
          NSString *pickUpDay = (NSString*)[[carInfo objectForKey:@"PickupDay"] objectForKey:@"text"];
         NSString *link = (NSString*)[[carInfo objectForKey:@"link"]objectForKey:@"text"];
         NSString *DropOffTime = (NSString*)[[carInfo objectForKey:@"DropoffTime"]objectForKey:@"text"];
         NSString *DropOffDay = (NSString*)[[carInfo objectForKey:@"DropoffDay"] objectForKey:@"text"];
        
        controller.pickUpDay = pickUpDay;
        controller.price = price;
        controller.location = location;
        controller.pickUpTime = pickUpTime;
        controller.link = link;
        controller.DropOffTime = DropOffTime;
        controller.DropOffDay = DropOffDay;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarInfo" forIndexPath:indexPath];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CarInfo"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Car number %ld", (long)indexPath.row];
    
    return cell;
}



- (IBAction)backToSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
