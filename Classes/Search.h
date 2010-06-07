//
//  Search.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
//	Abstract: Simple search object, indicating search text and type to search for (e.g. Artist, Release etc.)

#import <Foundation/Foundation.h>

typedef enum SearchTypes
{
	ArtistType,
	ReleaseType,
	LabelType
} SearchTypes;

extern NSString * const SearchTypeToString[];

@interface Search : NSObject {
	NSString *searchText;
	SearchTypes searchType;
	
}
@property(nonatomic, retain) NSString *searchText;

-(void) setType:(SearchTypes)type;
-(SearchTypes) getType;
@end
