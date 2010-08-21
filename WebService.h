//
//  WebService.h
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
// Abstract: Responsible for retrieving data from a given URL

#import <Foundation/Foundation.h>
#import "ServiceResponse.h"

// interface
@protocol RequestCompleteDelegate
-(void)finishedRequest:(ServiceResponse *)response;
@end

// common class definition
@interface WebService : NSObject {
	@private
	NSURLConnection *serviceConnection;
	NSMutableData *xmlData;
	id <RequestCompleteDelegate> delegate;
	ServiceResponse *response;
}
@property (nonatomic, retain) id <RequestCompleteDelegate> delegate;

-(void)getData:(NSURL *)url;
@end
