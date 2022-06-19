//
//  DetailsViewController.m
//  flixter
//
//  Created by maxfierro on 6/17/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set text-only labels.
    self.movieTitle.text = self.movieInfo[@"title"];
    self.movieDetails.text = self.movieInfo[@"overview"];
    
    // Have to convert some of the values to strings, and add a little spice.
    NSString *voteRatingNum = [NSString stringWithFormat:@"%@",
                                    self.movieInfo[@"vote_average"]];
    self.voteRating.text = [@"Vote average: "
                                    stringByAppendingString:voteRatingNum];
    NSString *popularityNum = [NSString stringWithFormat:@"%@",
                                    self.movieInfo[@"popularity"]];
    self.popularityRating.text = [@"Popularity: "
                                    stringByAppendingString:popularityNum];
    self.maturityRating.text = [self.movieInfo[@"adult"] boolValue] ?
                                    @"Adult" : @"For all audiences";
    
    // Base locaiton.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    // Get full URLs for image locations.
    NSString *posterURLString = self.movieInfo[@"poster_path"];
    NSString *backdropURLString = self.movieInfo[@"backdrop_path"];
    
    // Combine each URL to get full location path.
    NSString *fullPosterURLString = [baseURLString
                                stringByAppendingString:posterURLString];
    NSString *fullBackdropURLString = [baseURLString
                                stringByAppendingString:backdropURLString];
    
    // Convert strings back to NSURLs.
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    
    // Set the poster and backdrop images using the links provided.
    [self.posterImage setImageWithURL:posterURL];
    [self.backdropImage setImageWithURL:backdropURL];
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
