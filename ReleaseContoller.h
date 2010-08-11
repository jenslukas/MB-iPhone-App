//
//  ReleaseController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for release entity

#import <UIKit/UIKit.h>
#import "Release.h"
#import "ServiceFacade.h"


@interface ReleaseContoller : UIViewController <UITableViewDelegate, UITableViewDataSource,  DataCompleteDelegate> {
	Release *release;
	UITableView *tracksTable;
	UILabel *artistNameLabel;
	UILabel *releaseNameLabel;
	UILabel *recordLabel;
	UILabel *dateLabel;	
	UIActivityIndicatorView *activityView;	
}
@property (nonatomic, retain) Release *release;
@end
