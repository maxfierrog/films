//
//  GridViewController.m
//  flixter
//
//  Created by maxfierro on 6/19/22.
//

#import "UIImageView+AFNetworking.h"
#import "GridViewController.h"
#import "GridMovieCell.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property NSDictionary *movieDict;
@property (nonatomic, strong) NSArray *movieArray;
@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIAlertController *alert = [UIAlertController
                      alertControllerWithTitle:@"Network Error"
                                       message:@"No internet connection."
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
                    actionWithTitle:@"Reload"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action) {
        [self viewDidLoad];
    }];
    [alert addAction:ok];
    self.movieGridView.dataSource = self;
    self.movieGridView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=0e3e4cf020820c13098e4a8ddad6a61b"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                            timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                                [NSURLSessionConfiguration defaultSessionConfiguration]
                            delegate:nil
                            delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                 completionHandler:^(NSData *data,
                                                    NSURLResponse *response,
                                                    NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.movieDict = [NSJSONSerialization
                              JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                           error:nil];
            self.movieArray = self.movieDict[@"results"];
            [self.movieGridView reloadData];
        }
    }];
    [task resume];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(doRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.movieGridView insertSubview:refreshControl atIndex:0];
}

- (void)doRefresh:(UIRefreshControl *)refreshControl {
    UIAlertController *alert = [UIAlertController
                      alertControllerWithTitle:@"Network Error"
                                       message:@"No internet connection."
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
                    actionWithTitle:@"Reload"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * _Nonnull action) {
        [self doRefresh:refreshControl];
    }];
    [alert addAction:ok];
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=0e3e4cf020820c13098e4a8ddad6a61b"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                            timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                                [NSURLSessionConfiguration defaultSessionConfiguration]
                            delegate:nil
                            delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                 completionHandler: ^(NSData *data,
                                                      NSURLResponse *response,
                                                      NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.movieDict = [NSJSONSerialization
                              JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                           error:nil];
            self.movieArray = self.movieDict[@"results"];
            [self.movieGridView reloadData];
            [refreshControl endRefreshing];
        }
    }];
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridMovieCell" forIndexPath: indexPath];
    NSDictionary *currMovie = self.movieArray[indexPath.row];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = currMovie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString
                                     stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.movieGridCellImage.image = nil;
    [cell.movieGridCellImage setImageWithURL:posterURL];
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
