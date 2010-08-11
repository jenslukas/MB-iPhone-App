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
#import "AccountInformation.h"

@implementation MusicbrainzAppDelegate
@synthesize window, navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
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

- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}


@end
