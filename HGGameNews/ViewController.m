//
//  ViewController.m
//  HGCarsNews
//
//  Created by HG on 13.04.16.
//  Copyright (c) 2016 Vitaliy Horodecky. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"
#import "ListNews.h"
#import "News.h"
#import "TopTableViewCell.h"
#import "TableViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

{
    ListNews*    listNews;
    BOOL         searchMode;
    NSString*    searchText;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarTopLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.hidden = true;
    self.tableView.hidden = true;
    [SVProgressHUD show];
    searchMode = NO;
    [self showSearchBar];
    
    [self.searchBar setReturnKeyType:UIReturnKeySearch];
    
    //topCell Xib
    UINib *topNib = [UINib nibWithNibName:@"TopTableViewCell" bundle:nil];
    
    [[self tableView] registerNib:topNib forCellReuseIdentifier:topTableViewCellIdentifier];
    
    //standartCell Xib
    
    UINib * standartNib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    
    //NSString* standartNewsTableViewCellIdentifier = @"standartCell";
    
    [[self tableView] registerNib:standartNib forCellReuseIdentifier:standartTableViewCellIdentifier];
    
    [[ServerManager sharedManager] getNews:^(NSArray *rezultValue) {
        if (rezultValue == nil) {
            [SVProgressHUD dismiss];
            
            
            // Вывести алерт
        } else {
            
            listNews = [[ListNews alloc] init];
            
            [listNews newsParse:rezultValue];
            self.tableView.hidden = false;
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            // listNews.arrayListNews;
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onSearch:(id)sender {
    
    if (searchMode) {
        
        self.searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                      target:self
                                                                      action:@selector(onSearch:)];
        self.navigationItem.rightBarButtonItem = self.searchButton;
        
        searchText = nil;
        searchMode = NO;
        [self.searchBar resignFirstResponder];
        
    } else {
        
        self.searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(onSearch:)];
        
        self.navigationItem.rightBarButtonItem = self.searchButton;
        
        searchMode = YES;
        [self.searchBar becomeFirstResponder];
    }
    
    [self showSearchBar];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (searchMode == NO) {
        if (listNews.arrayTopNews.count > 0) {
            return listNews.arrayWithOutTopNews.count + 1;
        } else {
            return listNews.arrayListNews.count;
        }
    } else {
        return [listNews searchNews:searchText].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (listNews.arrayTopNews.count > 0) {
        
        if (indexPath.row == 0) {
            
            TopTableViewCell* topCell = [tableView dequeueReusableCellWithIdentifier:topTableViewCellIdentifier];
            topCell.listTopNews = listNews.arrayTopNews;
            
            return topCell;
            
        } else {
            
            TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:standartTableViewCellIdentifier];
            News* news = listNews.arrayListNews [indexPath.row];
            [cell submitNews:news];
            
            return cell;
        }
        
    } else {
        
        TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:standartTableViewCellIdentifier];
        News* news = listNews.arrayListNews [indexPath.row];
        cell.newsNameLable.text = news.newsName;
        [cell submitNews:news];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 298;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)theSearchText {
    if (theSearchText.length == 0) {
        searchText = nil;
    } else {
        searchText = theSearchText;
    }
    [self.tableView reloadData];
}

#pragma mark - Private Methods

- (void)showSearchBar {
    
    if (searchMode) {
        self.searchBar.hidden = false;
        [UIView animateWithDuration:0.5 animations:^{
            self.searchBarTopLayout.constant = 0;
            [self.view layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.8 animations:^{
            self.searchBarTopLayout.constant = -44;
                        [self.view layoutIfNeeded];

        }  completion:^(BOOL finished) {
            if (finished) {
                self.searchBar.hidden = true;
            }
        }];
    }
}

@end
