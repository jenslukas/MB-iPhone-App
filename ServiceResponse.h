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


#import <UIKit/UIKit.h>

typedef enum ResponseCode
{
	Success,
	NetworkFailure,
	AuthenticationFailure
} ResponseCode;

@interface ServiceResponse : NSObject {
	ResponseCode responseCode;
	id data;
}
@property(nonatomic, retain) id data;
-(ResponseCode) getResponseCode;
-(void) setResponseCode:(ResponseCode)response;
@end
