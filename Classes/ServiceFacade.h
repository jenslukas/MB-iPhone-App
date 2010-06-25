//
//  ServiceFacade.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/6/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Facade for all service request, responsible for retrieving and parsing data

#import <Foundation/Foundation.h>
#import "WebService.h"
#import "AbstractXMLParser.h"
#import "Search.h"

@protocol DataCompleteDelegate
-(void) finishedRequest:(id) results;
@end

@interface ServiceFacade : NSObject <RequestCompleteDelegate, ParsingFinishedDelegate> {
	WebService *service;
	AbstractXMLParser *xmlParser;
	NSArray *results;
	id <DataCompleteDelegate> delegate;
	Search *searchInfo;
	
}
@property (nonatomic, retain) NSArray *results;
@property (nonatomic, retain) id <DataCompleteDelegate> delegate;
@property (nonatomic, retain) Search *searchInfo;

-(void) search:(Search *)search;
@end
