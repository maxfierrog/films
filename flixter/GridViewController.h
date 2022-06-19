//
//  GridViewController.h
//  flixter
//
//  Created by maxfierro on 6/19/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GridViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *movieGridView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

NS_ASSUME_NONNULL_END
