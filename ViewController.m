//
//  ViewController.m
//  R2Hot
//
//  Created by Sosena Bekele on 10/24/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "CarInformation.h"
#import "RKDropdownAlert.h"

@interface ViewController ()

@property(nonatomic, strong)ShoppingResult *shoppingResult;

@end

@implementation ViewController

NSString *startDate;
NSString *endDate;
NSString *destination;
NSString *dropOffTime;
NSString *pickUpTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.getBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [[self.getBtn layer] setBorderWidth:1.0f];
    [[self.getBtn layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    self.getBtn.enabled = NO;
    self.shoppingResult = [[ShoppingResult alloc] init];
    self.shoppingResult.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getInfo:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.shoppingResult.dest = destination;
    self.shoppingResult.startDate = startDate;
    self.shoppingResult.endDate = endDate;
    self.shoppingResult.pickUpTime = pickUpTime;
    self.shoppingResult.dropOffTime = dropOffTime;
    
    [self.shoppingResult getCarInfo];
    //self.shoppingResult.
}


- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(theTextField.tag == 0){
        NSString *start_date = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([start_date length] == 0){
            self.getBtn.enabled = NO;
        }else{
           startDate = start_date;
        }
    }else if(theTextField.tag == 1){
        NSString *end_date = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([end_date length] == 0){
            self.getBtn.enabled = NO;
        }else{
            endDate = end_date;
        }
    } else if(theTextField.tag == 2){
        NSString *dest = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([dest length] == 0){
            self.getBtn.enabled = NO;
        }else{
            destination = dest;
        }
    }  else if(theTextField.tag == 3){
        NSString *drop_time = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([drop_time length] == 0){
            self.getBtn.enabled = NO;
        }else{
            dropOffTime = drop_time;
        }
        
    }  else if(theTextField.tag == 4){
        NSString *pick_time = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([pick_time length] == 0){
            self.getBtn.enabled = NO;
        }else{
            pickUpTime = pick_time;
        }
    }
    
    if(destination && startDate && dropOffTime && endDate && pickUpTime){
        self.getBtn.enabled = YES;
    }
    return YES;
}

#pragma ShoppingResultDelegate methods
-(void)didReceiveResults:(NSMutableArray *)carInfo
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    /*if([self checkInput]){
        [self performSegueWithIdentifier:@"showResult" sender:carInfo];
    }*/
    
   [self performSegueWithIdentifier:@"showResult" sender:carInfo];
    //self.price = [carInfo ]
    NSLog(@"car info is %@ ", carInfo);
}

-(BOOL)checkInput
{
    if(![self checkTimeFormat:startDate]){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *message = @"startDate should be in the format MM/DD/YEAR";
        [RKDropdownAlert title:@"Error" message:message backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photoColor"]] textColor:[UIColor whiteColor] time:2.0];
        return NO;
    }
    if(![self checkTimeFormat:endDate]){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *message = @"endDate should be in the format MM/DD/YEAR";
        [RKDropdownAlert title:@"Error" message:message backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photoColor"]] textColor:[UIColor whiteColor] time:2.0];
    }
    return YES;
}
-(BOOL)checkTimeFormat:(NSString*)date
{
    if([date length] == 10 ){
       const char *checkChar = [date UTF8String];
        if( (checkChar[2] == '/') && (checkChar[5] == '/')){
            
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showResult"]){
        UINavigationController *nagivation = segue.destinationViewController;
        CarInformation *controller = (CarInformation *) nagivation.topViewController;
        NSMutableArray *car = (NSMutableArray*)sender;
        controller.carInfo = car;
        
    }
}
-(void)stopProgressHUD:(NSString *)errorMessage
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    // NSString *temp = [error userInfo][@"error"];
    [RKDropdownAlert title:@"Error" message:errorMessage backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"photoColor"]] textColor:[UIColor whiteColor] time:4.0];
}

@end


