//
//  TrackLookUpParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/26/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for track


#import "TrackLookUpParser.h"


@implementation TrackLookUpParser
@synthesize track;

// Constants for the XML element names used while parsing
static NSString *TRACK = @"recording";
static NSString *TITLE = @"title";
static NSString *TAGNAME = @"name";
static NSString *LENGTH = @"length";
static NSString *RATING = @"rating";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	[parser parse];
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:TRACK]) {
		results = [NSMutableArray array];
		
		Track *trackTmp = [[Track alloc] init];
		trackTmp.mbid = [attributeDict valueForKey:@"id"];
		trackTmp.tags = [NSMutableArray array];
		
		trackTmp.votes = 0;
		trackTmp.rating = [[NSNumber alloc] initWithInt:0];
		
		self.track = trackTmp;
		[trackTmp release];		
	} else if([elementName isEqualToString:TITLE]||[elementName isEqualToString:TAGNAME]||[elementName isEqualToString:LENGTH]) {
		[currentString setString:@""];
		storingCharacters = YES;
	} else if([elementName isEqualToString:RATING]) {
		self.track.votes = [[attributeDict valueForKey:@"votes-count"] intValue];
		[currentString setString:@""];
		storingCharacters = YES;		
	}

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:TRACK]) {
		[results addObject:self.track];
		[super finished];
	} else if ([elementName isEqualToString:TITLE]) {
		self.track.title = [NSString stringWithString:self.currentString];
	} else if ([elementName isEqualToString:TAGNAME]) {
		[self.track.tags addObject:[NSString stringWithString:self.currentString]];
	} else if ([elementName isEqualToString:LENGTH]) {
		self.track.length = [[NSString stringWithString:self.currentString] intValue];
	} else if ([elementName isEqualToString:RATING]) {
		
	} else if([elementName isEqualToString:RATING]) {
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		self.track.rating = [formatter numberFromString:self.currentString];
	}
storingCharacters = NO;
}

-(void) dealloc {
	track = nil;
	[track release];
	[super dealloc];
}

@end
