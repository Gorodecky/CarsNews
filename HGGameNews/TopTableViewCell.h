//
//  TopTableViewCell.h
//  HGCarsNews
//
//  Created by HG on 18.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;
@property (strong, nonatomic) NSArray* listTopNews;
@end

static NSString* const topTableViewCellIdentifier =@"topTableViewCellIdentifier";
