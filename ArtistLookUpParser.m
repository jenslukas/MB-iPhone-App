//
//  ArtistLookUpParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for artist


#import "ArtistLookUpParser.h"


@implementation ArtistLookUpParser
@synthesize currentArtist;
@synthesize currentReleaseGroup;

// Constants for the XML element names used while parsing
static NSString *ARTIST = @"artist";
static NSString *NAME = @"name";
static NSString *RELEASEGROUPLIST = @"release-group-list";
static NSString *RELEASEGROUP = @"release-group";
static NSString *RELEASEGROUPTITLE = @"title";
static NSString *TAGLIST = @"tag-list";
static NSString *RATING = @"rating";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	parsingArtist = NO;
	parsingTag = NO;
	[parser parse];
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:ARTIST]) {
		parsingArtist = YES;
		results = [NSMutableArray array];
		
		Artist *artist = [[Artist alloc] init];
		artist.mbid = [attributeDict valueForKey:@"id"];
		
		// initial rating value
		artist.rating = [[NSNumber alloc] initWithInt:0];
		artist.votes = 0;
		
		self.currentArtist = artist;
		[artist release];
	} else if([elementName isEqualToString:NAME]||[elementName isEqualToString:RELEASEGROUPTITLE]) {
		[currentString setString:@""];
		storingCharacters = YES;
	} else if([elementName isEqualToString:RELEASEGROUPLIST]) {
		self.currentArtist.releaseGroups = [NSMutableArray array];		
	} else if([elementName isEqualToString:RELEASEGROUP]) {
		ReleaseGroup *releaseGroup = [[ReleaseGroup alloc] init];
		releaseGroup.mbid = [attributeDict valueForKey:@"id"];
		
		self.currentReleaseGroup = releaseGroup;
		[releaseGroup release];
	} else if([elementName isEqualToString:TAGLIST]) {
		parsingArtist = NO;
		parsingTag = YES;
		self.currentArtist.tags = [NSMutableArray array];
	} else if([elementName isEqualToString:RATING]) {
		self.currentArtist.votes = [[attributeDict valueForKey:@"votes-count"] intValue];
		[currentString setString:@""];
		storingCharacters = YES;		
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:ARTIST]) {
		[results addObject:self.currentArtist];
		[super finished];
	} else if ([elementName isEqualToString:NAME]) {
		if(parsingArtist) {
			self.currentArtist.name = [NSString stringWithString:self.currentString];		
		} else {
			[self.currentArtist.tags addObject:[NSString stringWithString:self.currentString]];
		}
	} else if([elementName isEqualToString:RELEASEGROUP]) {
		[currentArtist.releaseGroups addObject:currentReleaseGroup];
	} else if([elementName isEqualToString:RELEASEGROUPTITLE]) {
		self.currentReleaseGroup.title = [NSString stringWithString:self.currentString];
	} else if([elementName isEqualToString:RATING]) {
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		self.currentArtist.rating = [formatter numberFromString:self.currentString];
	}
    storingCharacters = NO;
}

-(void) dealloc {
	currentArtist = nil;
	[currentArtist release];
	[super dealloc];
}

@end
