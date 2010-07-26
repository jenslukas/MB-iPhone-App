//
//  ReleaseGroupLookUpParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/26/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for release groups

#import "ReleaseGroupLookUpParser.h"

@implementation ReleaseGroupLookUpParser
@synthesize releaseGroup, currentRelease;

// Constants for the XML element names used while parsing
static NSString *RELEASEGROUP = @"release-group";
static NSString *RELEASE = @"release";
static NSString *TITLE = @"title";
static NSString *TAGLIST = @"tag-list";
static NSString *NAME = @"name";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	parsingRelease = NO;
	parsingTags = NO;
	[parser parse];
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:RELEASEGROUP]) {
		results = [NSMutableArray array];
		
		parsingRelease = NO;
		ReleaseGroup *releaseGroupTmp = [[ReleaseGroup alloc] init];
		releaseGroupTmp.mbid = [attributeDict valueForKey:@"id"];
		releaseGroupTmp.type = [attributeDict valueForKey:@"type"];
		releaseGroupTmp.releases = [NSMutableArray array];
		releaseGroupTmp.rating = [[NSNumber alloc] initWithInt:0];
		releaseGroupTmp.votes = 0;
		
		self.releaseGroup = releaseGroupTmp;
		[releaseGroupTmp release];		
	} else if([elementName isEqualToString:TITLE]||[elementName isEqualToString:NAME]) {
		[currentString setString:@""];
		storingCharacters = YES;
	} else if([elementName isEqualToString:RELEASE]) {
		Release *release = [[Release alloc] init];
		release.mbid = [attributeDict valueForKey:@"id"];
		self.currentRelease = release;
		[release release];
		
		parsingRelease = YES;
	} else if([elementName isEqualToString:TAGLIST]) {
		parsingTags = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:RELEASEGROUP]) {
		[results addObject:self.releaseGroup];
		[super finished];
	} else if ([elementName isEqualToString:RELEASE]) {
		[self.releaseGroup.releases addObject:self.currentRelease];
	} else if ([elementName isEqualToString:TITLE]) {
		if(parsingRelease) {
			currentRelease.title = [NSString stringWithString:self.currentString];
		} else {
			self.releaseGroup.title = [NSString stringWithString:self.currentString];
		}
	} else if ([elementName isEqualToString:NAME]) {
		[self.currentRelease.tags addObject:[NSString stringWithString:self.currentString]];
	}
    storingCharacters = NO;
}

-(void) dealloc {
	releaseGroup = nil;
	[releaseGroup release];
	currentRelease = nil;
	[currentRelease release];
	[super dealloc];
}

@end
