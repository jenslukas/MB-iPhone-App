//
//  ReleaseViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/24/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for release entity

#import <UIKit/UIKit.h>

#import "ReleaseGroup.h"
#import "ServiceFacade.h"

@interface ReleaseViewController : UITableViewController <DataCompleteDelegate> {
	ReleaseGroup *releaseGroup;
	NSInteger selectedReleaseIndex;
	UITableView *tracksTable;
	UILabel *artistNameLabel;
	UILabel *releaseNameLabel;
	UILabel *recordLabel;
	UILabel *dateLabel;		
	bool parsed;
}

@property (nonatomic, retain) ReleaseGroup *releaseGroup;
@property (nonatomic) NSInteger selectedReleaseIndex;
@end
