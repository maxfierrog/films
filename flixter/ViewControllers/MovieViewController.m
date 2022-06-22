//
//  MovieViewController.m
//  flixter
//
//  Created by maxfierro on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "APIManager.h"
#import "Utils.h"
#import "Movie.h"

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movieArray;
@property NSDictionary *movieDict;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIAlertController *alert = [Utils getNetworkingAlertController:^{
        [self viewDidLoad];
    }];
    [Utils getRefreshControl:self refreshSelector:@selector(doRefresh:) UIView:self.tableView];
    [self.activityIndicator hidesWhenStopped];
    [self.activityIndicator startAnimating];
    [APIManager fetchNowPlayingMovies:^(NSArray *movies, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.movieArray = movies;
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
        }
    }];
}

- (void)doRefresh:(UIRefreshControl *)refreshControl {
    UIAlertController *alert = [Utils getNetworkingAlertController:^{
        [self doRefresh:refreshControl];
    }];
    [APIManager fetchNowPlayingMovies:^(NSArray *movies, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.movieArray = movies;
            [self.tableView reloadData];
            [refreshControl endRefreshing];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *currMovie = self.movieArray[indexPath.row];
    cell.synopsisLabel.text = currMovie.overview;
    cell.titleLabel.text = currMovie.title;
    [Utils setUIImageViewImage:cell.posterView path:currMovie.posterPath];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:sender];
    Movie *movie = self.movieArray[cellIndexPath.row];
    DetailsViewController *detailsVC = [segue destinationViewController];
    detailsVC.movie = movie;
}

@end
