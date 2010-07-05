//
//  ReleaseContoller.h
//  Musicbrainz
//
//  Created by Peter Katheter on 6/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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
}
@property (nonatomic, retain) Release *release;
@end
