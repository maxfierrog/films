//
//  Movie.h
//  flixter
//
//  Created by maxfierro on 6/21/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property NSString *adult;
@property NSString *video;

@property NSArray *genreIDs;

@property NSNumber *voteAverage;
@property NSNumber *popularity;
@property NSNumber *voteCount;
@property NSNumber *movieID;

@property NSString *backdropPath;
@property NSString *originalLanguage;
@property NSString *title;
@property NSString *overview;
@property NSString *posterPath;
@property NSString *releaseDate;
@property NSString *originalTitle;

- (NSObject *)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
