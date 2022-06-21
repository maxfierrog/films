//
//  APIManager.m
//  flixter
//
//  Created by maxfierro on 6/21/22.
//

#import "APIManager.h"
#import "Movie.h"

@implementation APIManager

+ (void)fetchNowPlayingMovies:(void (^)(NSArray *movies, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=0e3e4cf020820c13098e4a8ddad6a61b"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *movies;
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            movies = [[NSMutableArray alloc] init];
            NSArray *movieDictionaries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"results"];
            for (NSDictionary *item in movieDictionaries) {
                Movie *current = [[Movie alloc] init];
                [movies addObject:[current withDictionary:item]];
            }
        }
        completion(movies, error);
    }];
    [task resume];
}

@end
