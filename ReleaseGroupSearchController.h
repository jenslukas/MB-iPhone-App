//
//  ReleaseGroupSearchController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays the results of the release group search

#import <UIKit/UIKit.h>
#import	"ServiceFacade.h"

@interface ReleaseGroupSearchController : UITableViewController <DataCompleteDelegate> {
@private
	NSArray *releaseGroups;
	ServiceFacade *service;
	UIActivityIndicatorView *activityView;
}
@property (nonatomic, retain) NSArray *releaseGroups;
@end
