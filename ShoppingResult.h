//
//  ShoppingResult.h
//  R2Hot
//
//  Created by Sosena Bekele on 10/24/15.
//  Copyright (c) 2015 Sosena Bekele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebRequest.h"

@protocol ShoppingResultDelegate <NSObject>

-(void)didReceiveResults:(NSMutableArray*)carInfo;
-(void)stopProgressHUD:(NSString*)errorMessage;

@end

@interface ShoppingResult : NSObject <WebRequestDelegate>

- (void)getCarInfo;

@property(nonatomic, strong) NSMutableArray * carInfo ;
@property(nonatomic, strong) NSString *startDate;
@property(nonatomic, strong) NSString *endDate;
@property(nonatomic, strong) NSString *dest;
@property(nonatomic, strong) NSString *dropOffTime;
@property(nonatomic, strong) NSString *pickUpTime;

@property(nonatomic, weak) id <ShoppingResultDelegate> delegate;
@end
