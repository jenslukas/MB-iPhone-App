//
//  ReleaseViewController.h
//  Musicbrainz
//
//  Created by Peter Katheter on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Release.h"
#import "ServiceFacade.h"

@interface ReleaseViewController : UITableViewController <DataCompleteDelegate> {
	Release *release;
	UITableView *tracksTable;
	UILabel *artistNameLabel;
	UILabel *releaseNameLabel;
	UILabel *recordLabel;
	UILabel *dateLabel;		
}

@property (nonatomic, retain) Release *release;
@end
