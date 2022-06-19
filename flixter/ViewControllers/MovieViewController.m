//
//  MovieViewController.m
//  flixter
//
//  Created by maxfierro on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"

// This is an example of a class category -- adding methods to an framework
// class for added functionality.
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

// It seems that MovieViewController is a class extension, or anonymous
// category. How does it know which class to extend? For example, in
// java you explicitly type CLASS extends ANOTHER. Is it a similar thing?
@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSDictionary *movieDict;
@property (nonatomic, strong) NSArray *movieArray;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    // What is my superclass?
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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
            [self.tableView reloadData];

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
    [self.tableView insertSubview:refreshControl atIndex:0];
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
            [self.tableView reloadData];
            [refreshControl endRefreshing];
        }
    }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section {
    // Will always be how many movies we have, even if we
    // update again from the API.
    return self.movieArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath {
    
    // Cast a recycled cell to another MovieCell object, which we
    // expect to have the properties in "MovieCell.h", which we had to import.
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:
                       @"MovieCell"];
    
    // Fetch movie dictionary from the right index at API-fetched array.
    NSDictionary *currMovie = self.movieArray[indexPath.row];
    
    // Remember currMovie is a dictionary with attributes.
    // If we were true OOPers we would make a movie object.
    cell.synopsisLabel.text = currMovie[@"overview"];
    cell.titleLabel.text = currMovie[@"title"];
    
    // Get the location URL of the desired poster. First get base URL, then
    // append to that the location of the individual poster we need (from
    // the .json), then convert that into a NSURL object.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = currMovie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString
                                     stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    
    // Sometimes it takes a while to load new images, and old ones persist,
    // causing unpleasant flickering. This gets rid of the old image so UI
    // is smoother when scrolling.
    cell.posterView.image = nil;
    
    // Method setImageWithURL is part of AFNetworking.
    [cell.posterView setImageWithURL:posterURL];
    
    // Return the recycled MovieCell with the updated contents.
    return cell;
}

// What is this?
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the index path of the cell which is the segue sender.
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:sender];
    
    // Get the correct dictionary of movie information by checking the row of the
    // sender cell.
    NSDictionary *movieInfo = self.movieArray[cellIndexPath.row];
    
    // Get the new view controller using [segue destinationViewController].
    DetailsViewController *detailsVC = [segue destinationViewController];
    
    // Now we that we have movieInfo dictionary here, and we have initialized
    // the detailsViewController and also have a pointer to it here, we add the
    // movie details to its movieInfo field.
    detailsVC.movieInfo = movieInfo;
}


@end
