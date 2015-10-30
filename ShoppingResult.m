//
//  ShoppingResult.m
//  R2Hot
//
//  Created by Sosena Bekele on 10/24/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import "ShoppingResult.h"


@implementation ShoppingResult

- (id)init
{
    if(self = [super init]){
        self.carInfo = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)getCarInfo
{
    // get the quiz answ
    
   // QuizAnswers *answers = [QuizAnswers quizAnswers];
    
/*"http://api.hotwire.com/v1/search/car?apikey=dkyyssyur82kw7whprba443f&dest=LAX&startdate=11/21/2015&enddate=11/22/2015&pickuptime=10:00&dropofftime=13:30"*/
    // start the request
    WebRequest *request;
    request = [WebRequest requestWithURL:@"http://api.hotwire.com/v1/search/car?apikey=dkyyssyur82kw7whprba443f&" method:WebRequestGET];
    NSMutableDictionary *parameters  = [self getParameters];
   
    request.parameters = parameters;
    request.expectsJSON = NO;
    
    [request startWithBlock:^(NSURLResponse *response, NSDictionary *json, NSError *error) {
        
        if(!error){
            NSDictionary *result = [json objectForKey:@"Hotwire"];
            NSDictionary *errorResult = [result objectForKey:@"Errors"];
            if([errorResult count] != 0){
                NSString *errorMessage = @"";
                NSArray *errorMessages = [errorResult objectForKey:@"Error"];
                for(int i = 0 ; i < [errorMessages count]; i++){
                    NSString *tempMessage = [ [errorMessages[i] objectForKey:@"ErrorMessage"] objectForKey:@"text"];
                        errorMessage = [NSString stringWithFormat:@"%@ %@ ", errorMessage, tempMessage];
                     errorMessage = [NSString stringWithFormat:@"%@ \n ", errorMessage];
                }
         
                [self.delegate stopProgressHUD:errorMessage];
                
            } else {
                    NSDictionary *result2 = [result objectForKey:@"Result"];

                    NSArray *Car_result = [result2 objectForKey:@"CarResult"];

                    for(NSDictionary *carResult in Car_result){
                        NSMutableDictionary *car = [[NSMutableDictionary alloc] init];
                        [car setObject:[carResult objectForKey:@"DeepLink"] forKey:@"link"];
                        [car setObject:[carResult objectForKey:@"TotalPrice"] forKey:@"price"];
                        [car setObject:[carResult objectForKey:@"PickupDay"] forKey:@"PickupDay"];
                        [car setObject:[carResult objectForKey:@"PickupTime"] forKey:@"PickupTime"];
                        [car setObject:[carResult objectForKey:@"DropoffDay"] forKey:@"DropoffDay"];
                        [car setObject:[carResult objectForKey:@"DropoffTime"] forKey:@"DropoffTime"];
                        [car setObject:[carResult objectForKey:@"LocationDescription"] forKey:@"location"];
             
                        [self.carInfo addObject:car];
                   
                        }
                        [self.delegate didReceiveResults:self.carInfo];
            }
        }else{
            
            NSDictionary *userInfo = [error userInfo];
            NSError *underlyingError = [userInfo objectForKey:NSUnderlyingErrorKey];
            NSString *errorMessage = [underlyingError localizedDescription];
            
            [self.delegate stopProgressHUD:errorMessage];
            
            
        }
    }];
    
}

-(NSMutableDictionary *)getParameters
{
    
    /*http://api.hotwire.com/v1/search/car?apikey=abc123&dest=LAX&startdate=01/20/2010&enddate=01/23/2010&pickuptime=10:00&dropofftime=13:30*/
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setValue:[NSString stringWithFormat:@"%@" , self.dest] forKey:@"dest"];
    
    [parameters setValue:[NSString stringWithFormat:@"%@" , self.startDate] forKey:@"startdate"];
    
    [parameters setValue:[NSString stringWithFormat:@"%@" , self.endDate] forKey:@"enddate"];
    
    [parameters setValue:[NSString stringWithFormat:@"%@" , self.pickUpTime] forKey:@"pickuptime"];
    
    [parameters setValue:[NSString stringWithFormat:@"%@" , self.dropOffTime] forKey:@"dropofftime"];
    
    return parameters;
}


-(void)didHaveError:(NSError *)error
{
    NSDictionary *userInfo = [error userInfo];
    NSError *underlyingError = [userInfo objectForKey:NSUnderlyingErrorKey];
    NSString *errorMessage = [underlyingError localizedDescription];
    [self.delegate stopProgressHUD:errorMessage];
}







@end
