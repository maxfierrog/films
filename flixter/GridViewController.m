//
//  GridViewController.m
//  flixter
//
//  Created by maxfierro on 6/19/22.
//

#import "UIImageView+AFNetworking.h"
#import "GridViewController.h"
#import "GridMovieCell.h"
#import "Utils.h"
#import "APIManager.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *movieArray;
@property NSDictionary *movieDict;
@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIAlertController *alert = [Utils getNetworkingAlertController:^{
        [self viewDidLoad];
    }];
    
    self.movieGridView.dataSource = self;
    self.movieGridView.delegate = self;
    
    [APIManager fetchNowPlayingMovies:^(NSArray * _Nonnull movies, NSError * _Nonnull error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.movieArray = movies;
            [self.movieGridView reloadData];
        }
    }];
    
    [Utils getRefreshControl:self refreshSelector:@selector(doRefresh:) UIView:self.movieGridView];
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
            [self.movieGridView reloadData];
            [refreshControl endRefreshing];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridMovieCell" forIndexPath: indexPath];
    Movie *movie = self.movieArray[indexPath.row];
    [Utils setUIImageViewImage:cell.movieGridCellImage path:movie.posterPath];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
