
//
//  WebRequest.m
//  Yoop
//
//  Created by Sosena Bekele on 10/25/15.
//  Copyright (c) All rights reserved.
//

#import "WebRequest.h"
#import "XMLReader.h"

@implementation WebRequest

+ (WebRequest *)requestWithURL:(NSString *)url method:(WebRequestMethod)method
{
    WebRequest *request = [[WebRequest alloc] init];
    if( request){
        request.url = url;
        request.method = method;
    }
    return request;
}


- (void)startWithBlock:(void (^)(NSURLResponse *, id, NSError *))block
{
    // create and configure the request
    NSString *urlString = [NSString stringWithString:self.url];
    
    urlString = [urlString stringByAppendingString:@"&"];
    
    
    // add parameters to the url
    NSArray *parameterKeys = self.parameters.allKeys;
    for(int i = 0; i < parameterKeys.count; i++){
        if(i > 0) {
            // add an ampersand in front of it
            urlString = [urlString stringByAppendingString:@"&"];
        }
        NSString *key = parameterKeys[i];
        NSString *value = self.parameters[key];
        NSString *appendingString = [NSString stringWithFormat:@"%@=%@", key, value];
       // urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, value]];
        urlString = [urlString stringByAppendingString:appendingString];
    }
    
    // make the url request
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if(self.method == WebRequestGET){
        request.HTTPMethod = @"GET";
    }
    else if(self.method == WebRequestPOST){
        request.HTTPMethod = @"POST";
    }
    else {
        // default to GET
        self.method = WebRequestGET;
        request.HTTPMethod = @"GET";
    }
    
    if(self.body){
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
        request.HTTPBody = [self.body dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if(self.authString) {
        NSData *authData = [self.authString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    }
    
    // make and start the session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *json;
            

            if(self.expectsJSON){
                
                NSError *jsonerror;
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
                json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&jsonerror];
                NSLog(@"%@ %@",json , str);
                block(response, json, error
                      );
            }
            else {
                 NSError *jsonerror;
                  NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
               json =  [XMLReader dictionaryForXMLString:str error:&jsonerror];
                if(!jsonerror){
                    block(response,json, error);
                }else{
     
                    [self.delegate didHaveError:jsonerror] ;
                    //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                   // NSString *temp = [error userInfo][@"error"];

                }
              /*  NSError *parseError = nil;
                NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
                NSLog(@" %@", xmlDictionary);*/
                //block(response,json, error);
            }
            
        });
    }];
    [task resume];
}





@end
