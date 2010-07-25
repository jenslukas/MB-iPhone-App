//
//  AbstractXMLParser.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//	
//  Abstract: Abstract class for XML parsing

#import <Foundation/Foundation.h>

// interface
@protocol ParsingFinishedDelegate
//inform delegate that parsing finished
- (void) finishedParsing;
@end

@interface AbstractXMLParser : NSObject <NSXMLParserDelegate> {
	@protected
	NSMutableString *currentString;
    BOOL storingCharacters;
	NSData *xmlData;
	id <ParsingFinishedDelegate> delegate;
	NSMutableArray *results;
}

@property(nonatomic, retain) id <ParsingFinishedDelegate> delegate;
@property(nonatomic, retain) NSMutableArray *results;
@property(nonatomic, retain) NSMutableString *currentString; 

-(void) parse:(NSData *)data;
-(void)finished;

@end
