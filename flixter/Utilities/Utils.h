//
//  Utils.h
//  flixter
//
//  Created by maxfierro on 6/21/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (UIAlertController *)getNetworkingAlertController:(void (^)(void))doWhenClickOK;
+ (UIRefreshControl *)getRefreshControl:(UIViewController *)viewController refreshSelector:(SEL)refreshSelector UIView:(UIView *)UIView;
+ (void)setUIImageViewImage:(UIImageView *)target path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
