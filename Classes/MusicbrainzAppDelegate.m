//
//  MusicbrainzAppDelegate.m
//  Musicbrainz
//
//  Created by Jens Lukas on 5/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Applications entry point

#import "MusicbrainzAppDelegate.h"
#import "MainMenuController.h"
#import	"ReleaseContoller.h"

@implementation MusicbrainzAppDelegate

@synthesize window, navController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	// init paypal
	[NSThread detachNewThreadSelector:@selector(initializePayPalMEP) toTarget:self withObject:nil];
	
	
	// TODO clean up
	MainMenuController *mainMenu = [[MainMenuController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainMenu];

	//ReleaseContoller *releaseController = [[ReleaseContoller alloc] init];
	//UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:releaseController];
	
	navigationController.navigationBar.tintColor = [UIColor orangeColor];
	self.navController = navigationController;
	
	[mainMenu release];
	[navigationController release];
		
	[window addSubview:[navController view]];
    [window makeKeyAndVisible];
}

-(void)initializePayPalMEP {
	// init paypal library in sandbox mode
	[PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];
}


- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}


@end
