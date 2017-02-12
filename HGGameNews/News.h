//
//  News.h
//  HGCarsNews
//
//  Created by HG on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (strong, nonatomic) NSString* newsName;
@property (strong, nonatomic) NSURL* newsLink;
@property (strong, nonatomic) NSDate* newsDateOfCreating;
@property (strong, nonatomic) NSURL* newsPhotoUrl;
@property (nonatomic) BOOL newsTopMark;

- (News*)initWithServerResponse:(NSDictionary*) responseObject;
- (NSString*)newsTimeDifferense;
- (NSString*)showUrlString;
@end
