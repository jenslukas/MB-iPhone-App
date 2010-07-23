//
//  LabelLookUpParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/16/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for labels

#import "LabelLookUpParser.h"


@implementation LabelLookUpParser
@synthesize currentLabel, currentRelease;

// Constants for the XML element names used while parsing
static NSString *LABEL = @"label";
static NSString *TITLE = @"title";
static NSString *NAME = @"name";
static NSString *RELEASE = @"release";
static NSString *TAGLIST = @"tag-list";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	parsingTags = NO;
	[parser parse];
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	if([elementName isEqualToString:LABEL]){
		Label *label = [[Label alloc] init];
		label.mbid = [attributeDict valueForKey:@"id"];
		label.type = [attributeDict valueForKey:@"type"];
		label.releases = [NSMutableArray array];
		
		self.currentLabel = label;
		[label release];
	} else if([elementName isEqualToString:RELEASE]) {
		Release *release = [[Release alloc] init];
		release.mbid = [attributeDict valueForKey:@"id"];
		release.tracks = [NSMutableArray array];
		
		self.currentRelease = release;
		[release release];		
	} else if([elementName isEqualToString:TITLE]||[elementName isEqualToString:NAME]) {
		[currentString setString:@""];
		storingCharacters = YES;
	} else if([elementName isEqualToString:TAGLIST]) {
		parsingTags = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:RELEASE]) {
		[results addObject:self.currentRelease];
		[super finished];
	} else if ([elementName isEqualToString:NAME]) {
		if(parsingTags) {
			[self.currentLabel.tags addObject:[NSString stringWithString:self.currentString]];
		} else {
			self.currentLabel.name = [NSString stringWithString:self.currentString];
		}
	} else if([elementName isEqualToString:TITLE]) {
		self.currentRelease.title = [NSString stringWithString:self.currentString];
	}
	storingCharacters = NO;
}

-(void) dealloc {
	currentRelease = nil;
	[currentRelease release];
	[super dealloc];
}

@end

