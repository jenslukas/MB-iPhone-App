//
//  AbstractXMLParser.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
//	Abstract: Abstract class for XML parsing

#import "AbstractXMLParser.h"


@implementation AbstractXMLParser
@synthesize delegate, results, currentString;


-(void) parse:(NSData *)data {
	[self doesNotRecognizeSelector:_cmd];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
	// throw error if trying to call this method directly in this base class
	[self doesNotRecognizeSelector:_cmd];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	[self doesNotRecognizeSelector:_cmd];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (storingCharacters) [self.currentString appendString:string];
}

// TODO: Error handling
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Handle errors as appropriate for your application.
}

-(void) finished {
	[delegate finishedParsing];
}

-(void) dealloc {
	delegate = nil;
	xmlData = nil;
	currentString = nil;
	results = nil;
	[xmlData release];
	[currentString release];
	[results release];
	[super dealloc];
}
@end
