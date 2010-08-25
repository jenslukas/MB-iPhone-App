//
//  ServiceFacade.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Facade for all service request, responsible for delgating retrieval and parsing of the data

#import <Foundation/Foundation.h>
#import "WebService.h"
#import "AbstractXMLParser.h"
#import "Search.h"
#import "Release.h"
#import "Artist.h"
#import "ServiceResponse.h"

@protocol DataCompleteDelegate
-(void) finishedRequest:(ServiceResponse *) response;
@end

@interface ServiceFacade : NSObject <RequestCompleteDelegate, ParsingFinishedDelegate> {
	WebService *service;
	AbstractXMLParser *xmlParser;
	NSArray *results;
	id <DataCompleteDelegate> delegate;
	Search *searchInfo;
	ServiceResponse *serviceResponse;
	bool requestIsSearch;
}

@property (nonatomic, retain) NSArray *results;
@property (nonatomic, retain) id <DataCompleteDelegate> delegate;
@property (nonatomic, retain) Search *searchInfo;

-(void) search:(Search *)search;
-(void) getRelease:(Release *)release;
-(void) getArtist:(Artist *)artist;
-(void) getReleaseGroup:(NSString *)mbid;
-(void) getTrack:(NSString *)mbid;
-(void) getLabel:(NSString *)mbid;
-(void) tagEntity:(id)entity withTag:(NSString *)tag;
-(void) rateEntity:(id)entity withRating:(NSInteger)rating;
-(void) checkLogin:(NSString *)username andPassword:(NSString *)password;
@end
