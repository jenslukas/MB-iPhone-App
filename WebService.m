//
//  WebService.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Responsible for retrieving data from a given URL

#import "WebService.h"

@implementation WebService
@synthesize xmlData, delegate;

// get data from given URL
-(void)getData:(NSURL *)url {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	xmlData = [NSMutableData alloc];
	
	[[NSURLCache sharedURLCache] removeAllCachedResponses];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	serviceConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];		

	request = nil;
	[request release];
	serviceConnection = nil;
	[serviceConnection release];
	
}

// Disable caching
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

// Forward errors to the delegate. (not implemented yet)
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

// Append the new chunk of data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [xmlData appendData:data];
}

// Finished downloading data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	//notify delegate
	[delegate finishedDownload];
}

-(void) dealloc {
	[serviceConnection release];
	[xmlData release];
	[super dealloc];
}

@end
