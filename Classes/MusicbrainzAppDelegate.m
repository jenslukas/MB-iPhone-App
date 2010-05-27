//
//  MusicbrainzAppDelegate.m
//  Musicbrainz
//
//  Created by Peter Neter on 5/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MusicbrainzAppDelegate.h"

@implementation MusicbrainzAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
