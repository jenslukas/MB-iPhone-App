//
//  MusicbrainzAppDelegate.h
//  Musicbrainz
//
//  Created by Peter Neter on 5/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicbrainzAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

