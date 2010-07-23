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
@synthesize currentRelease;

// Constants for the XML element names used while parsing
static NSString *ARTIST = @"artist";
static NSString *NAME = @"name";
static NSString *RELEASELIST = @"release-list";
static NSString *RELEASE = @"release";
static NSString *RELEASETITLE = @"title";
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
		
		self.currentArtist = artist;
		[artist release];
	} else if([elementName isEqualToString:NAME]||[elementName isEqualToString:RELEASETITLE]) {
		[currentString setString:@""];
		storingCharacters = YES;
	} else if([elementName isEqualToString:RELEASELIST]) {
		self.currentArtist.releases = [NSMutableArray array];		
	} else if([elementName isEqualToString:RELEASE]) {
		Release *release = [[Release alloc] init];
		release.mbid = [attributeDict valueForKey:@"id"];
		
		self.currentRelease = release;
		[release release];
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
	} else if([elementName isEqualToString:RELEASE]) {
		[currentArtist.releases addObject:currentRelease];
	} else if([elementName isEqualToString:RELEASETITLE]) {
		self.currentRelease.title = [NSString stringWithString:self.currentString];
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
