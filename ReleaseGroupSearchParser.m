//
//  ReleaseGroupSearchParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for release groups

#import "ReleaseGroupSearchParser.h"


@implementation ReleaseGroupSearchParser
@synthesize currentReleaseGroup;

// Constants for the XML element names used while parsing
static NSString *RELEASEGROUPLIST = @"release-group-list";
static NSString *RELEASEGROUP = @"release-group";
static NSString *TITLE = @"title";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	[parser parse];
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:RELEASEGROUPLIST]) {
		// init results array
		results = [NSMutableArray array];
	} else if([elementName isEqualToString:RELEASEGROUP]) {
		ReleaseGroup *releaseGroup = [[ReleaseGroup alloc] init];
		releaseGroup.mbid = [attributeDict valueForKey:@"id"];
		
		self.currentReleaseGroup = releaseGroup;
		[releaseGroup release];
	} else if([elementName isEqualToString:TITLE]) {
		[currentString setString:@""];
		storingCharacters = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:RELEASEGROUPLIST]) {
		[super finished];
	} else if ([elementName isEqualToString:RELEASEGROUP]) {
		[results addObject:self.currentReleaseGroup];
	} else if ([elementName isEqualToString:TITLE]) {
		self.currentReleaseGroup.title = [NSString stringWithString:self.currentString];
	}
    storingCharacters = NO;
}

-(void) dealloc {
	self.currentReleaseGroup = nil;
	[currentReleaseGroup release];
	[super dealloc];
}

@end

