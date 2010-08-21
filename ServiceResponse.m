//
//  ServiceResponse.h
//  Musicbrainz
//
//  Created by Jens Lukas on 8/12/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//  Abstract: Object returned by the service, including the web service data and response code indicating success or failures


#import "ServiceResponse.h"


@implementation ServiceResponse
@synthesize data;

- (void) setResponseCode:(ResponseCode)response {
	responseCode = response;
}

- (ResponseCode)getResponseCode {
	return responseCode;
}

- (void)dealloc {
    [super dealloc];
}


@end

