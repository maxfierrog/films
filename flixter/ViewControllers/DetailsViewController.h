//
//  DetailsViewController.h
//  flixter
//
//  Created by maxfierro on 6/17/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

// Ignore properties -- I am just practicing. They are reminders of what
// the defaults are.
@property (strong, atomic, readwrite) NSDictionary *movieInfo;

// Outlets for included movie details.
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *maturityRating;
@property (weak, nonatomic) IBOutlet UILabel *popularityRating;
@property (weak, nonatomic) IBOutlet UILabel *voteRating;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDetails;

@end

NS_ASSUME_NONNULL_END
