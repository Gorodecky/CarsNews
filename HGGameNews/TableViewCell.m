//
//  TableViewCell.m
//  HGCarsNews
//
//  Created by HG on 18.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "News.h"
#import <QuartzCore/QuartzCore.h>


@interface TableViewCell () <UITextViewDelegate>
{
    NSURL *redirectURL;
}

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.newsLinkLable.editable = NO;
    self.newsLinkLable.scrollEnabled = NO;
    self.newsLinkLable.dataDetectorTypes = UIDataDetectorTypeLink;
    self.newsLinkLable.delegate = self;
    
    self.newsImageLable.layer.cornerRadius = 5;
    self.newsImageLable.layer.masksToBounds = NO;
    self.newsImageLable.layer.masksToBounds = NO;
    self.newsImageLable.layer.shadowOffset = CGSizeMake(5, 5);
    self.newsImageLable.layer.shadowRadius = 5;
    self.newsImageLable.layer.shadowOpacity = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void) submitNews: (News*) news {
    
    redirectURL = news.newsLink;
    
    if (news.newsPhotoUrl) {
        
        self.imageHeight.constant = 186;
        [self.newsImageLable setImageWithURL:news.newsPhotoUrl
                            placeholderImage:[UIImage imageNamed: @"400*200"]];
    } else {
        
        self.imageHeight.constant = 0;
    }
    
    [self updateConstraints];
    
    self.newsNameLable.text = news.newsName;
    self.newsDateLable.text = [news newsTimeDifferense];
    if (news.newsLink) {
        self.newsLinkLable.text = [news showUrlString];
    }
}

- (IBAction)callSafari {
    [[UIApplication sharedApplication] openURL:redirectURL];
}

#pragma mark - Private

- (void)prepareForReuse {
    redirectURL = nil;
    self.newsImageLable.image = nil;
    self.newsLinkLable.delegate = nil;
}

@end
