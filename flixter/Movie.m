//
//  Movie.m
//  flixter
//
//  Created by maxfierro on 6/21/22.
//

#import "Movie.h"

@implementation Movie

- (NSObject *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // NSArray
    self.genreIDs = dict[@"genre_ids"];
    
    // NSNumber
    self.voteAverage = dict[@"vote_average"];
    self.popularity = dict[@"popularity"];
    self.voteCount = dict[@"vote_count"];
    self.movieID = dict[@"id"];
    
    // boolean >> NSString
    self.adult = [dict[@"adult"] boolValue] ? @"Yes" : @"No";
    self.video = [dict[@"video"] boolValue] ? @"Yes" : @"No";
    
    // NSString
    self.backdropPath = dict[@"backdrop_path"];
    self.originalLanguage = dict[@"original_language"];
    self.title = dict[@"title"];
    self.overview = dict[@"overview"];
    self.posterPath = dict[@"poster_path"];
    self.releaseDate = dict[@"release_date"];
    self.originalTitle = dict[@"original_title"];
    
    return self;
}


@end
