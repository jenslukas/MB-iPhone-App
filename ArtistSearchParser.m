//
//  ArtistSearchParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for artists


#import "ArtistSearchParser.h"

@implementation ArtistSearchParser
@synthesize currentArtist;

// Constants for the XML element names used while parsing
static NSString *ARTISTLIST = @"artist-list";
static NSString *ARTIST = @"artist";
static NSString *ARTISTNAME = @"name";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	parsingArtist = NO;
	[parser parse];
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:ARTISTLIST]) {
		// init results array
		results = [NSMutableArray array];
	} else if([elementName isEqualToString:ARTIST]) {
		Artist *artist = [[Artist alloc] init];
		artist.mbid = [attributeDict valueForKey:@"id"];
		parsingArtist = YES;
		self.currentArtist = artist;
		[artist release];
		
		//currentRelease.score = [attributeDict valueForKey:@"ext:score"];
	} else if([elementName isEqualToString:ARTISTNAME]) {
		[currentString setString:@""];
		storingCharacters = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:ARTISTLIST]) {
		[super finished];
	} else if ([elementName isEqualToString:ARTIST]) {
		[results addObject:self.currentArtist];
	} else if ([elementName isEqualToString:ARTISTNAME]) {
		if(parsingArtist) {
			self.currentArtist.name = [NSString stringWithString:self.currentString];
			parsingArtist = NO;
		}
	}
    storingCharacters = NO;
}

-(void) dealloc {
	self.currentArtist = nil;
	[currentArtist release];
	[super dealloc];
}

@end
