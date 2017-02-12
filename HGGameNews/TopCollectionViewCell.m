//
//  TopCollectionViewCell.m
//  HGCarsNews
//
//  Created by HG on 13.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "TopCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface TopCollectionViewCell () <UITextViewDelegate> {
    NSURL * redirectURL;
}
@end

@implementation TopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.newsLink.delegate = self;
    self.newsLink.editable = NO;
    self.newsLink.scrollEnabled =NO;
    self.newsLink.dataDetectorTypes = UIDataDetectorTypeLink;
    self.newsLink.backgroundColor = [UIColor clearColor];
    
}

- (void) setNews:(News*) news {
    
    redirectURL = news.newsLink;
    self.newsName.text = news.newsName;
    self.newsDate.text = [news newsTimeDifferense];
    
    if (news.newsPhotoUrl) {
        
        [self.newsImage setImageWithURL:news.newsPhotoUrl
                       placeholderImage:[UIImage imageNamed: @"400*200"]];
    }
    
    if (news.newsLink) {
        
        self.newsLink.hidden = NO;
        self.newsLink.text = [news showUrlString];
        
    } else {
        
        self.newsLink.hidden = YES;
    }
    
}

- (IBAction)presNews {
 [[UIApplication sharedApplication] openURL:redirectURL];
    
}
@end
