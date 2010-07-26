//
//  ServiceFacade.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Facade for all service request, responsible for retrieving and parsing data


#import "ServiceFacade.h"
#import "ReleaseSearchParser.h"
#import "ReleaseLookUpParser.h"
#import "ReleaseGroupLookUpParser.h"
#import "ArtistSearchParser.h"
#import "ArtistLookUpParser.h"
#import "LabelSearchParser.h"

@implementation ServiceFacade
@synthesize delegate, results, searchInfo;

// query for entity defined in Search object 
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

// get specific release entity by MBID
-(void) getRelease:(Release *)release {
	self.searchInfo = [[Search alloc] init];
	self.searchInfo.detailSearch = YES;
	[self.searchInfo setType:ReleaseType];
	
	service = [WebService alloc];
	service.delegate = self;
	
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/release/";
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:release.mbid] retain];
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:@"?inc=recordings+artists"] retain];

	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[urlToCall release];
}

// get specific artist by Artist MBID
-(void) getArtist:(Artist *)artist {
	self.searchInfo = [[Search alloc] init];
	self.searchInfo.detailSearch = YES;
	[self.searchInfo setType:ArtistType];
	
	service = [WebService alloc];
	service.delegate = self;
	
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/artist/";
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:artist.mbid] retain];
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:@"?inc=release-groups+tags+ratings"] retain];
	
	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[urlToCall release];
}

// get all releases
-(void) getReleaseGroup:(NSString *)mbid {
	self.searchInfo = [[Search alloc] init];
	self.searchInfo.detailSearch = YES;
	[self.searchInfo setType:ReleaseGroupType];
	
	service = [WebService alloc];
	service.delegate = self;
	
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/release-group/";
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:mbid] retain];
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:@"?inc=releases+tags+ratings"] retain];
	
	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[urlToCall release];
}

// called by Web Service when data download finished
-(void)finishedDownload {
	if(searchInfo.detailSearch) {
		switch([searchInfo getType]) {
			case ArtistType:
				xmlParser = [ArtistLookUpParser alloc];
				break;
			case ReleaseType:
				xmlParser = [ReleaseLookUpParser alloc];
				break;
			case LabelType:
//				xmlParser = [LabelSearchParser alloc];
				break;
			case ReleaseGroupType:
				xmlParser = [ReleaseGroupLookUpParser alloc];
				break;

		}
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

// called by XML Parser when data parsing finisheds
-(void) finishedParsing {
	results = [NSArray  arrayWithArray:xmlParser.results];
	[delegate finishedRequest:results];
	[searchInfo release];
	delegate = nil;
	//results = nil;
	//[results release];
	//[xmlParser release];
	[service release];
}

-(void) dealloc {
	[results release];
	[xmlParser release];
	[service release];
	[super dealloc];
}
@end
