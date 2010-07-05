//
//  Artist.h
//  Musicbrainz
//
//  Created by Peter Katheter on 6/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject {
	NSString *mbid;
	NSString *name;	
	NSInteger score;
	NSNumber *rating;
	NSMutableArray *releases;
}
@property (nonatomic, retain) NSString *mbid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger score;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSMutableArray *releases;
@end
