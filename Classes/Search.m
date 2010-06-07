//
//  Search.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
//	Abstract: Simple search object, indicating search text and type to search for (e.g. Artist, Release etc.)


#import "Search.h"
NSString * const SearchTypeToString[] = {
	@"Artist",
	@"Release",
	@"Label"
};

@implementation Search
@synthesize searchText;
-(void)setType:(SearchTypes)type {
	searchType = type;
}
-(SearchTypes)getType {
	return searchType;
}
@end
