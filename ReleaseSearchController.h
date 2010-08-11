//
//  ReleaseSearchController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays the results of the release search for a Release Group

#import <UIKit/UIKit.h>
#import	"ServiceFacade.h"
#import "ReleaseGroup.h"

@interface ReleaseSearchController : UITableViewController <DataCompleteDelegate> {
	@private
	ReleaseGroup *releaseGroup;
	ServiceFacade *service;
	UIActivityIndicatorView *activityView;
}
@property (nonatomic, retain) ReleaseGroup *releaseGroup;
@end
