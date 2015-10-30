//
//  WebRequest.h
//  Yoop
//
//  Created by Sosena Bekele on 10/25/15.
//  Copyright (c) All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol WebRequestDelegate <NSObject>

-(void)didHaveError:(NSError*)error;

@end


@class WebRequest;

typedef NS_ENUM(int, WebRequestMethod){
    WebRequestGET,
    WebRequestPOST
};

/*
 A convenience class for writing web requests.
 */

@interface WebRequest : NSObject

@property(nonatomic, strong) NSString *url;

// GET or POST?
@property(nonatomic) WebRequestMethod method;

// Setting the paremeters makes the url look like "url + key1=value1&key2=value2+..."
// URL must have a question mark at the end
@property(nonatomic, strong) NSDictionary *parameters;

@property(nonatomic, strong) NSString *body;

// If yes, the a dictionary rather than NSData is passed to the callback
@property(nonatomic) BOOL expectsJSON;

@property (nonatomic) NSString *authString;

// Convenience init
+ (WebRequest *) requestWithURL:(NSString *)url method:(WebRequestMethod)method;

// Begin the web request
- (void)startWithBlock:(void(^)(NSURLResponse *response, id responseBody, NSError *error))block;


@property(nonatomic, weak) id <WebRequestDelegate> delegate;
@end
