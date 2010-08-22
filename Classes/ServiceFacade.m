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
#import "LabelLookUpParser.h"
#import "TrackLookUpParser.h"
#import "ReleaseGroupSearchParser.h"
#import "RateAndTaggableEntity.h"

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
		case ReleaseGroupType:
			urlToCall = @"http://test.musicbrainz.org/ws/2/release-group?query=";
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
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:@"?inc=recordings+artists+labels"] retain];
	
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

// get Track
-(void) getTrack:(NSString *)mbid {
	self.searchInfo = [[Search alloc] init];
	self.searchInfo.detailSearch = YES;
	[self.searchInfo setType:TrackType];
	
	service = [WebService alloc];
	service.delegate = self;
	
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/recording/";
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:mbid] retain];
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:@"?inc=tags+ratings"] retain];
	
	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[urlToCall release];
}

// get Label
-(void) getLabel:(NSString *)mbid {
	self.searchInfo = [[Search alloc] init];
	self.searchInfo.detailSearch = YES;
	[self.searchInfo setType:LabelType];
	
	service = [WebService alloc];
	service.delegate = self;
	
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/label/";
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:mbid] retain];
	urlToCall = [[[urlToCall autorelease] stringByAppendingString:@"?inc=tags+ratings+releases"] retain];
	
	NSURL *url = [NSURL URLWithString:urlToCall];
	[service getData:url];
	[urlToCall release];
}

// rate
-(void) rateEntity:(id)entity withRating:(NSInteger)rating {
	// get type of entity
	NSString *xmlEntityType;
	if([entity isKindOfClass:[Artist class]]) {
		xmlEntityType = @"artist";
	} else if ([entity isKindOfClass:[Label class]]) {
		xmlEntityType = @"label";
	} else if([entity isKindOfClass:[Track class]]) {
		xmlEntityType = @"recording";
	} else if([entity isKindOfClass:[ReleaseGroup class]]) {
		xmlEntityType = @"release-group";
	}
	
	service = [WebService alloc];
	service.delegate = self;
	
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/rating?client=iphone-0.7";
	
	NSURL *url = [NSURL URLWithString:urlToCall];
	
	NSString *xml = [NSString stringWithFormat:@"<metadata xmlns=\"http://musicbrainz.org/ns/mmd-2.0#\"><@%-list><@% id=\"%@\"><user-rating>%d</user-rating></@%></@%-list></metadata>", xmlEntityType, xmlEntityType, [entity getMBID], rating, xmlEntityType, xmlEntityType];
	NSLog(@"%@", xml);
	[service sendData:url withData:xml];
	
	[urlToCall release];
	//[xml release];
}	

// rate
-(void) tagEntity:(id)entity withTag:(NSString *)tag {
	// get type of entity
	NSString *xmlEntityType;
	if([entity isKindOfClass:[Artist class]]) {
		xmlEntityType = @"artist";
	} else if ([entity isKindOfClass:[Label class]]) {
		xmlEntityType = @"label";
	} else if([entity isKindOfClass:[Track class]]) {
		xmlEntityType = @"recording";
	} else if([entity isKindOfClass:[ReleaseGroup class]]) {
		xmlEntityType = @"release-group";
	}
	
	
	service = [WebService alloc];
	service.delegate = self;
	
	// create url
	NSString *urlToCall;
	urlToCall = @"http://test.musicbrainz.org/ws/2/tag?client=iphone-0.7";
	NSURL *url = [NSURL URLWithString:urlToCall];
	
	// create XML
	NSMutableString *tagString;
	for(int i = 0; i < [[entity tags] count]; i++) {
		[tagString appendFormat:@"<user-tag><name>%@</name></user-tag>", [[entity tags] objectAtIndex:i]];
	}
	
	NSString *xml = [NSString stringWithFormat:@"<metadata xmlns=\"http://musicbrainz.org/ns/mmd-2.0#\"><%@-list><%@ id=\"%@\"><user-tag-list>%@</user-tag-list></%@></%@-list></metadata>", xmlEntityType, xmlEntityType, [entity getMBID], tagString, xmlEntityType, xmlEntityType];
	NSLog(@"%@", xml);
	[service sendData:url withData:xml];
	
	[urlToCall release];
	//[xml release];
}	

-(void)checkLogin:(NSString *)username andPassword:(NSString *)password {
	service = [WebService alloc];
	service.delegate = self;
	
	// create url
	NSString *urlToCall;
	urlToCall = @"	 http://test.musicbrainz.org/ws/2/artist/89ad4ac3-39f7-470e-963a-56509c546377?inc=user-tags";
	NSURL *url = [NSURL URLWithString:urlToCall];
	
	[service getData:url];
	
	[urlToCall release];
}

// called by Web Service when data download finished
-(void)finishedRequest:(ServiceResponse *)response {
	if([response getResponseCode] == Success) {
		serviceResponse = response;
		if(searchInfo.detailSearch) {
			switch([searchInfo getType]) {
				case ArtistType:
					xmlParser = [ArtistLookUpParser alloc];
					break;
				case ReleaseType:
					xmlParser = [ReleaseLookUpParser alloc];
					break;
				case LabelType:
					xmlParser = [LabelLookUpParser alloc];
					break;
				case ReleaseGroupType:
					xmlParser = [ReleaseGroupLookUpParser alloc];
					break;
				case TrackType:
					xmlParser = [TrackLookUpParser alloc];
					break;
					
			}
			xmlParser.delegate = self;
			[xmlParser parse:response.data];		
			
		} else {
			switch([searchInfo getType]) {
				case ArtistType:
					xmlParser = [ArtistSearchParser alloc];
					break;
				case ReleaseGroupType:
					xmlParser = [ReleaseGroupSearchParser alloc];
					break;
				case ReleaseType:
					xmlParser = [ReleaseSearchParser alloc];
					break;
				case LabelType:
					xmlParser = [LabelSearchParser alloc];
					break;			
			}
			xmlParser.delegate = self;
			[xmlParser parse:response.data];		
		}
	} else {
		[delegate finishedRequest:response];
	}
}

// called by XML Parser when data parsing finisheds
-(void) finishedParsing {
	results = [NSArray  arrayWithArray:xmlParser.results];
	serviceResponse.data = results;
	[delegate finishedRequest:serviceResponse];
	[searchInfo release];
	delegate = nil;
	[service release];
}

-(void) dealloc {
	[results release];
	[xmlParser release];
	[service release];
	[super dealloc];
}
@end
