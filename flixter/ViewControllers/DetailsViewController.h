//
//  DetailsViewController.h
//  flixter
//
//  Created by maxfierro on 6/17/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property Movie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *maturityRating;
@property (weak, nonatomic) IBOutlet UILabel *popularityRating;
@property (weak, nonatomic) IBOutlet UILabel *voteRating;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDetails;
@end

NS_ASSUME_NONNULL_END
