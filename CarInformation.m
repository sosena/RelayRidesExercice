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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backToSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
