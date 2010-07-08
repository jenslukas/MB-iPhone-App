//
//  ReleaseLookUpParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
// 
//  Abstract: Concrete implementation of the XML parser for releases


#import "ReleaseLookUpParser.h"


@implementation ReleaseLookUpParser
@synthesize currentRelease, currentTrack;

// Constants for the XML element names used while parsing
static NSString *RELEASE = @"release";
static NSString *TITLE = @"title";
static NSString *ARTIST = @"name";
static NSString *DATE = @"date";
static NSString *TRACK = @"track";
static NSString *POSITION = @"position";
static NSString *RECORDING = @"recording";
static NSString *LENGTH = @"length";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	parsingTrack = NO;
	
	[parser parse];

	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:RELEASE]) {
		results = [NSMutableArray array];
		
		parsingTrack = NO;
		Release *release = [[Release alloc] init];
		release.mbid = [attributeDict valueForKey:@"id"];
		release.tracks = [NSMutableArray array];
		
		self.currentRelease = release;
		[release release];
		
		//currentRelease.score = [attributeDict valueForKey:@"ext:score"];
	} else if([elementName isEqualToString:TITLE]||[elementName isEqualToString:ARTIST]||[elementName isEqualToString:DATE]||[elementName isEqualToString:LENGTH]||[elementName isEqualToString:POSITION]) {
		[currentString setString:@""];
		storingCharacters = YES;
	} else if([elementName isEqualToString:TRACK]) {
		Track *track = [[Track alloc] init];
		self.currentTrack = track;
		[track release];
		
		parsingTrack = YES;
	} else if([elementName isEqualToString:RECORDING]) {
		currentTrack.mbid = [attributeDict valueForKey:@"id"];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:RELEASE]) {
		[results addObject:self.currentRelease];
		[super finished];
	} else if ([elementName isEqualToString:TITLE]) {
		if(parsingTrack) {
			currentTrack.title = [NSString stringWithString:self.currentString];
		} else {
			self.currentRelease.title = [NSString stringWithString:self.currentString];
		}
	} else if ([elementName isEqualToString:ARTIST]) {
		self.currentRelease.artist = [NSString stringWithString:self.currentString];
	} else if ([elementName isEqualToString:DATE]) {
		self.currentRelease.date = [NSString stringWithString:self.currentString];
	} else if ([elementName isEqualToString:POSITION]) {
		currentTrack.position = [[NSString stringWithString:self.currentString] intValue];
	} else if ([elementName isEqualToString:LENGTH]) {
		currentTrack.length = [[NSString stringWithString:self.currentString] intValue];
	} else if ([elementName isEqualToString:TRACK]) {
		[self.currentRelease.tracks addObject:currentTrack];
	}
    storingCharacters = NO;
}

-(void) dealloc {
	currentRelease = nil;
	[currentRelease release];
	[super dealloc];
}

@end
