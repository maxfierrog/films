//
//  Utils.m
//  flixter
//
//  Created by maxfierro on 6/21/22.
//

#import "Utils.h"
#import "APIManager.h"
#import <UIKit/UIKit.h>
#import "Movie.h"
#import "UIImageView+AFNetworking.h"

@implementation Utils

+ (UIAlertController *)getNetworkingAlertController: (void (^)(void))doWhenClickOK {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error" message:@"No internet connection." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        doWhenClickOK();
    }];
    [alert addAction:ok];
    return alert;
}

+ (UIRefreshControl *)getRefreshControl:(UIViewController *)viewController refreshSelector:(SEL)refreshSelector UIView:(UIView *)UIView {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:viewController action:refreshSelector forControlEvents:UIControlEventValueChanged];
    [UIView insertSubview:refreshControl atIndex:0];
    return refreshControl;
}

+ (void)setUIImageViewImage:(UIImageView *)target path:(NSString *)path {
    NSString *fullPosterURLString = [@"https://image.tmdb.org/t/p/w500" stringByAppendingString:path];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    target.image = nil;
    [target setImageWithURL:posterURL];
}

@end
