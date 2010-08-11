//
//  TrackViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for track entity


#import <UIKit/UIKit.h>
#import "Track.h"
#import "ServiceFacade.h"

@interface TrackViewController : UITableViewController <DataCompleteDelegate> {
	Track *track;
	bool parsed;
	UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) Track *track;
@end
