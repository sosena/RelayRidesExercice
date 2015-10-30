//
//  ViewController.h
//  R2Hot
//
//  Created by Sosena Bekele on 10/24/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingResult.h"

@interface ViewController : UIViewController <UITextFieldDelegate, ShoppingResultDelegate>
@property (strong, nonatomic) IBOutlet UILabel *dropOffTime;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *link;
@property (strong, nonatomic) IBOutlet UILabel *dropOffDay;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIButton *getBtn;
- (IBAction)getInfo:(id)sender;


@end

