//
//  GridViewController.m
//  flixter
//
//  Created by maxfierro on 6/19/22.
//

#import "GridViewController.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property NSDictionary *movieDict;
@property (nonatomic, strong) NSArray *movieArray;
@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the activity indicator to hide when it stops.
    [self.activityIndicator hidesWhenStopped];
    
    // Set up networking error alert.
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
    
    // Which object we are getting data from and delegating to do things.
    self.movieGridView.dataSource = self;
    self.movieGridView.delegate = self;
    
    // URL object, apparently that's a thing here.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=0e3e4cf020820c13098e4a8ddad6a61b"];
    
    // Request object, apparently that's also a thing here.
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                            timeoutInterval:10.0];
    
    // Session object, apparently... no, this one makes sense I guess.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                                [NSURLSessionConfiguration defaultSessionConfiguration]
                            delegate:nil
                            delegateQueue:[NSOperationQueue mainQueue]];

    // URL Session Data Task object. Imagine abstraction.
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                 completionHandler:^(NSData *data,
                                                    NSURLResponse *response,
                                                    NSError *error) {
        // Start to spin loading animation.
        [self.activityIndicator startAnimating];
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.movieDict = [NSJSONSerialization
                              JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                           error:nil];

            // An artifact of how the API disbursed the data. We deduced
            // what goes here by looking at it 'manually'.
            self.movieArray = self.movieDict[@"results"];

            // Generating tables is faster than getting the data; since
            // we are making tables from the data, we have to refresh
            // once we have it.
            [self.movieGridView reloadData];

            // Stop spinning loading animation.
            [self.activityIndicator stopAnimating];
        }
    }];
    
    // I believe this tells the task created above to execute.
    [task resume];
    
    // Initialize a UIView > UIRefreshControl for refreshing the data.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // High level framework magic?
    [refreshControl addTarget:self
                       action:@selector(doRefresh:)
             forControlEvents:UIControlEventValueChanged];
    
    // INserts the refresh control subview into the UI. Why into tableView?
    // A: Because it is a subclass of UIView, it can be added as a subview
    // for another view.
    // What is atIndex?
    [self.movieGridView insertSubview:refreshControl atIndex:0];
}

- (void)doRefresh:(UIRefreshControl *)refreshControl {
    // Set up networking error alert.
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
