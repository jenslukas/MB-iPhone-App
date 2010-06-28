//
//  ReleaseContoller.h
//  Musicbrainz
//
//  Created by Peter Katheter on 6/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Release.h"


@interface ReleaseContoller : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	Release *release;
	UITableView *tracksTable;
}
@property (nonatomic, retain) Release *release;
@end
