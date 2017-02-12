//
//  News.m
//  HGCarsNews
//
//  Created by HG on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "News.h"
#import <UIKit/UIKit.h>

@implementation News

- (id)initWithServerResponse:(NSDictionary*) responseObject {
    
    self = [super init];
    if (self) {
        
        self.newsName = responseObject[@"name"];
        self.newsLink = [NSURL URLWithString:responseObject [@"link"]];
        NSString *dateString = responseObject[@"createdAt"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        self.newsDateOfCreating = [dateFormatter dateFromString:dateString];
        NSString* photoUrl = responseObject[@"cover"];
        if (photoUrl != (id)[NSNull null]) {
            
            self.newsPhotoUrl = [NSURL URLWithString:photoUrl];
        }
        self.newsTopMark = [[responseObject objectForKey:@"top" ] boolValue];
    }
    return self;
}

- (NSString*)newsTimeDifferense {
    
    float difference = fabs(self.newsDateOfCreating.timeIntervalSinceNow);
    
    if (difference < 60) {
        
        return @"less 1 min";
        
    } else if (difference < 3600) {
        
        return @"less 1 hour";
        
    } else if (difference < 3600 * 24) {
        
        return @"less 1 day";
        
    } else {
        
        return @"more than 1 day";
    }
}

- (NSString*)showUrlString {
    
    NSArray* arrayString = [self.newsLink.absoluteString componentsSeparatedByString:@"/"];
    NSString* siteName = [arrayString objectAtIndex:2];
    
    return siteName;
}

@end
