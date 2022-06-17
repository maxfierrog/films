//
//  MovieViewController.m
//  flixter
//
//  Created by maxfierro on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSDictionary *movieDict;
@property (nonatomic, strong) NSArray *movieArray;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize a UIRefreshControl.
    // UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // URL object, apparently that's a thing here.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=0e3e4cf020820c13098e4a8ddad6a61b"];
    
    // Request object, apparently that's also a thing here.
    NSURLRequest *request = [NSURLRequest requestWithURL: url
                            cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                            timeoutInterval: 10.0];
    
    // Session object, apparently... no, this one makes sense I guess.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                                [NSURLSessionConfiguration defaultSessionConfiguration]
                            delegate: nil
                            delegateQueue: [NSOperationQueue mainQueue]];

    // URL Session Data Task object. Imagine abstraction.
    NSURLSessionDataTask *task = [session dataTaskWithRequest: request
                                 completionHandler: ^(NSData *data,
                                                      NSURLResponse *response,
                                                      NSError *error) {
        
           // When is error assigned a value?
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               // Mesa don't understand what this is.
               self.movieDict = [NSJSONSerialization JSONObjectWithData:
                                 data options:
                                 NSJSONReadingMutableContainers error:nil];
               
               // An artifact of how the API disbursed the data. We deduced
               // what goes here by looking at it 'manually'.
               self.movieArray = self.movieDict[@"results"];
               
               // Generating tables is faster than getting the data; since
               // we are making tables from the data, we have to refresh
               // once we have it.
               [self.tableView reloadData];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
