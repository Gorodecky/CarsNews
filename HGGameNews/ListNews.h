//
//  ListNews.h
//  HGCarsNews
//
//  Created by HG on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNews : NSObject

@property (strong, nonatomic) NSArray* arrayListNews;
@property (strong, nonatomic) NSArray* arrayTopNews;
@property (strong, nonatomic) NSArray* arrayWithOutTopNews;
@property (nonatomic) BOOL availableTopNews;

- (void) newsParse:(NSArray*) arrayNews;
- (NSArray*) searchNews:(NSString*)searchInformation;

@end
