//
//  LabelSearchParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Concrete implementation of the XML parser for labels


#import "LabelSearchParser.h"

@implementation LabelSearchParser
@synthesize currentLabel;

// Constants for the XML element names used while parsing
static NSString *LABELLIST = @"label-list";
static NSString *LABEL = @"label";
static NSString *LABELNAME = @"name";

-(void) parse:(NSData *) data {
	xmlData = data;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	currentString = [NSMutableString string];
	
	[parser parse];
	
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:LABELLIST]) {
		// init results array
		results = [NSMutableArray array];
	} else if([elementName isEqualToString:LABEL]) {
		Label *label = [[Label alloc] init];
		label.mbid = [attributeDict valueForKey:@"id"];
		
		self.currentLabel = label;
		[label release];		
	} else if([elementName isEqualToString:LABELNAME]) {
		[currentString setString:@""];
		storingCharacters = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:LABELLIST]) {
		[super finished];
	} else if ([elementName isEqualToString:LABEL]) {
		[results addObject:self.currentLabel];
	} else if ([elementName isEqualToString:LABELNAME]) {
		self.currentLabel.name = [NSString stringWithString:self.currentString];
	}
	
    storingCharacters = NO;
}

-(void) dealloc {
	self.currentLabel = nil;
	[currentLabel release];
	[super dealloc];
}

@end
