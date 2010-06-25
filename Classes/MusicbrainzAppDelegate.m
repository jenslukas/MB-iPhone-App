//
//  MusicbrainzAppDelegate.m
//  Musicbrainz
//
//  Created by Peter Neter on 5/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MusicbrainzAppDelegate.h"
#import "MainMenuController.h"
#import	"ReleaseContoller.h"

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
