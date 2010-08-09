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

// send data
-(void)sendData:(NSURL *)url withData:(NSString *) data {
	NSData *postData = [data dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	NSString *dataLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setValue:dataLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	serviceConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	//request = nil;
	//[request release];
	//serviceConnection = nil;
	//[serviceConnection release];
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

-(void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if([challenge previousFailureCount] == 0) {
		[[challenge sender] useCredential:[NSURLCredential credentialWithUser:@"brainpimp" password:@"conair148361" persistence:NSURLCredentialPersistenceForSession] forAuthenticationChallenge:challenge];
	} else {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
	}
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
