//
//  ServerManager.m
//  HGCarsNews
//
//  Created by HG on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"


@implementation ServerManager

+ (ServerManager*) sharedManager {
    
    static ServerManager* manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc]init];
    });
    return manager;
}

- (void) getNews:(void(^)(NSArray* rezultValue)) blockName {
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
        [manager GET:@"http://owledge.ru/api/v1/feedNews?lang=en&count=10&sources=7,19,13,5,15,16,12,9,10012,10010,10013,10014,10019,10018,10011&feedLineId=5"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, NSArray* responseObject) {
                 
            NSLog(@"JSON: %@", responseObject);
                 
                 if (responseObject) {
                     blockName(responseObject);
                 } else {
                     blockName (nil);
                 }
                 
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            blockName (nil);
        }];
}

@end
