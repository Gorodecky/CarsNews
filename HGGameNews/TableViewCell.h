//
//  TableViewCell.h
//  HGCarsNews
//
//  Created by HG on 18.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
@class News;

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImageLable;
@property (weak, nonatomic) IBOutlet UILabel *newsNameLable;
@property (weak, nonatomic) IBOutlet UILabel *newsDateLable;
@property (weak, nonatomic) IBOutlet UITextView *newsLinkLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

- (void) submitNews: (News*) news;

@end

static NSString* const standartTableViewCellIdentifier =@"standartCell";
