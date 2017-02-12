//
//  ListNews.m
//  HGCarsNews
//
//  Created by HG on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ListNews.h"
#import "News.h"

@implementation ListNews

- (void) newsParse:(NSArray*) arrayNews {
    
    NSMutableArray * array = [NSMutableArray array];
    
    int i = 0;

    for (NSDictionary* dictionary in arrayNews) {
        i++;
        News* news = [[News alloc] initWithServerResponse:dictionary];
        [array addObject:news];
    }
    
    self.arrayListNews = array;
    
    NSMutableArray* arrayTopNews = [NSMutableArray array];
    NSMutableArray* arrayWithOutTopNews = [NSMutableArray array];
    
    for (News* news in self.arrayListNews) {
        
        if (news.newsTopMark == YES) {
            [arrayTopNews addObject:news];
        } else {
            [arrayWithOutTopNews addObject:news];
        }
    }
    self.arrayTopNews = arrayTopNews;
    
    self.arrayWithOutTopNews = arrayWithOutTopNews;
    
    if (self.arrayTopNews > 0) {
        self.availableTopNews = YES;
    }
}

- (NSArray*) searchNews:(NSString*)searchInformation {
    
    if (!searchInformation) {
        
        return self.arrayListNews;
        
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(newsName contains[c] %@)",searchInformation];
        NSArray *filteredArray = [self.arrayListNews filteredArrayUsingPredicate:predicate];
        return filteredArray;
    }
    return nil;
}

@end
