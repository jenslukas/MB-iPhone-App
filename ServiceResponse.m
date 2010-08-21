//
//  ServiceResponse.m
//  Musicbrainz
//
//  Created by Peter Katheter on 8/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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

