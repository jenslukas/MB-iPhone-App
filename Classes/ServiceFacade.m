//
//  ServiceFacade.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/6/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Facade for all service request, responsible for retrieving and parsing data


#import "ServiceFacade.h"
#import "ReleaseSearchParser.h"
#import "ReleaseLookUpParser.h"
#import "ArtistSearchParser.h"
#import "LabelSearchParser.h"

@implementation ServiceFacade
@synthesize delegate, results, searchInfo;

-(void) search:(Search *)search {
	self.searchInfo = search;
	service = [WebService alloc];
	service.delegate = self;
	NSString *urlToCall;
	
	// encode search text
	NSString * encodedQuery = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																				   NULL,
																				   (CFStringRef)search.searchText,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 );	
	switch([search getType]) {
		case ArtistType:
			urlToCall = @"http://test.musicbrainz.org/ws/2/artist?query=";
			urlToCall = [[[urlToCall autorelease] stringByAppendingString:encodedQuery] retain];
			break;
		case ReleaseType:
			urlToCall = @"http://test.musicbrainz.org/ws/2/release?query=";
			//urlToCall = [urlToCall stringByAppendingString:encodedQuery];
			urlToCall = [[[urlToCall autorelease] stringByAppendingString:encodedQuery] retain];
			break;
		case LabelType:
			urlToCall = @"http://test.musicbrainz.org/ws/2/label?query=";
			urlToCall = [[[urlToCall autorelease] stringByAppendingString:encodedQuery] retain];
			break;
	}
	
	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[encodedQuery release];
	[urlToCall release];
}

-(void) getRelease:(Release *)release search:(Search *) search {
	self.searchInfo = search;
	service = [WebService alloc];
	service.delegate = self;
	NSString *urlToCall;

	urlToCall = @"http://test.musicbrainz.org/ws/2/release/";
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:release.mbid] retain];

	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[urlToCall release];
}

-(void)finishedDownload {
	if(searchInfo.detailSearch) {
		xmlParser = [ReleaseLookUpParser alloc];
		xmlParser.delegate = self;
		[xmlParser parse:service.xmlData];		
	} else {
		switch([searchInfo getType]) {
			case ArtistType:
				xmlParser = [ArtistSearchParser alloc];
				break;
			case ReleaseType:
				xmlParser = [ReleaseSearchParser alloc];
				break;
			case LabelType:
				xmlParser = [LabelSearchParser alloc];
				break;			
		}
		xmlParser.delegate = self;
		[xmlParser parse:service.xmlData];		
	}
}

-(void) finishedParsing {
	results = [NSArray  arrayWithArray:xmlParser.results];
	[delegate finishedRequest:results];
	//[xmlParser release];
	//[service release];
}

-(void) dealloc {
	[results release];
	[xmlParser release];
	[service release];
	[super dealloc];
}
@end
