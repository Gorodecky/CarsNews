//
//  TopCollectionViewCell.h
//  HGCarsNews
//
//  Created by HG on 13.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface TopCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *newsName;
@property (weak, nonatomic) IBOutlet UITextView *newsLink;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

- (void) setNews:(News*) news;

@end

static NSString* const topCollectionViewCellidentifier = @"topCollectionViewCellidentifier";
