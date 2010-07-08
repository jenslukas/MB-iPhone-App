//
//  MusicbrainzAppDelegate.h
//  Musicbrainz
//
//  Created by Jens Lukas on 5/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Applications entry point

#import <UIKit/UIKit.h>


@interface MusicbrainzAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@end

