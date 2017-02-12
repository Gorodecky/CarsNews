//
//  TopTableViewCell.m
//  HGCarsNews
//
//  Created by HG on 18.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "TopTableViewCell.h"
#import "TopCollectionViewCell.h"

@interface TopTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl* pageControl;

@end

@implementation TopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UINib *cellNib = [UINib nibWithNibName:@"TopCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib
          forCellWithReuseIdentifier:topCollectionViewCellidentifier];
    
    [self.pageControl addTarget:self
                         action:@selector(pageControlChanged:)
               forControlEvents:UIControlEventValueChanged];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listTopNews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCollectionViewCellidentifier
                                                                            forIndexPath:indexPath];
    
    News * showNews = _listTopNews[indexPath.row];
    
    [cell setNews:showNews];
    
    cell.contentView.layer.cornerRadius = 2.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(5, 3.0f);
    cell.layer.shadowRadius = 4.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                                       cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = (self.collectionView.contentOffset.x + pageWidth / 2) / pageWidth;
    
}

- (void)pageControlChanged:(id)sender {
    UIPageControl *pageControl = sender;
    CGFloat pageWidth = self.collectionView.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
    [self.collectionView setContentOffset:scrollTo animated:YES];
}

@end
