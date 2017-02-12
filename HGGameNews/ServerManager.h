//
//  ServerManager.h
//  HGCarsNews
//
//  Created by HG on 14.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (ServerManager*) sharedManager;

- (void) getNews:(void(^)(NSArray* rezultValue)) blockName;

@end
