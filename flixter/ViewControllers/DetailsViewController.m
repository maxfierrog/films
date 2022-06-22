//
//  DetailsViewController.m
//  flixter
//
//  Created by maxfierro on 6/17/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieTitle.text = self.movie.title;
    self.movieDetails.text = self.movie.overview;
    self.maturityRating.text = self.movie.adult;
    NSString *voteRatingNum = [NSString stringWithFormat:@"%@", self.movie.voteAverage];
    self.voteRating.text = [@"Vote average: " stringByAppendingString:voteRatingNum];
    NSString *popularityNum = [NSString stringWithFormat:@"%@", self.movie.popularity];
    self.popularityRating.text = [@"Popularity: " stringByAppendingString:popularityNum];
    [Utils setUIImageViewImage:self.posterImage path:self.movie.posterPath];
    [Utils setUIImageViewImage:self.backdropImage path:self.movie.backdropPath];
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
